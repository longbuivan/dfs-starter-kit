import os
import logging
import json
from datetime import datetime
import boto3

WEB_LOG_FIELDS = []
KINESIS_STREAM_NAME = os.environ['WEB_RAW_KINESIS']

LOGGER = logging.getLogger(__name__)
LOGGER.setLevel(logging.INFO)
logging.basicConfig(
    format='%(asctime)s-%(name)s-%(levelname)s-%(message)s', level=logging.INFO)

dynamodb_client = boto3.client('dynamodb', region_name='us-east-1')
s3_client = boto3.client('s3', region_name='us-east-1')
firehose_client = boto3.client('firehose', region_name='us-east-1')
kinesis_client = boto3.client('firehose', region_name='us-east-1')


def _event_parser(event):
    try:
        data_object = event.get('key')

    except KeyError:
        LOGGER.exception("Cannot file the key in event")
    except Exception as e:
        LOGGER.exception("Error occur during parsing event")
    return data_object


def _put_kinesis_data_stream(kinesis_record, id, kinesis_stream_name):
    put_response = None
    try:
        put_response = kinesis_client.put_record(
            StreamName=kinesis_stream_name,
            Data=json.dumps(kinesis_record),
            PartitionKey=id)
        LOGGER.debug("Written  {} to stream {}".format(
            kinesis_record, kinesis_stream_name))
    except Exception as e:
        LOGGER.exception("Exception for put records to Kinesis")
    return put_response


def lambda_handler(event):
    """Main function: Parsing event from payload and push to Kinesis Data Stream"""
    LOGGER.info('Event structure: %s', event)
    kinesis_stream_name = KINESIS_STREAM_NAME
    count = 0
    for record in event['Records']:
        # Flatten Data
        raw_data = _event_parser(record)

        id = raw_data.get('id')
        # Push to Kinesis
        kinesis_res = _put_kinesis_data_stream(
            raw_data, id, kinesis_stream_name)
        if (kinesis_res == None):
            raise Exception(
                "Something went wrong with while processing records {}".format(raw_data))
        count += 1
    LOGGER.info("Processed event with {} records".format(count))
    return "Success"
