import os
import requests
import json
import logging
import boto3


LOGGER = logging.getLogger(__name__)
LOGGER.setLevel(logging.INFO)
logging.basicConfig(
    format='%(asctime)s-%(name)s-%(levelname)s-%(message)s', level=logging.INFO)

kinesis_client = boto3.client('kinesis', region_name='us-east-1')


WEB_ENDPOINT = os.environ.get("WEB_ENDPOINT", "WEB_ENDPOINT")
RAW_STREAM_NAME = os.environ.get("RAW_STREAM_NAME", "RAW_STREAM_NAME")


def _pushing_record_to_kinesis(data, partition_key, stream_name):
    "This function will push = parsed data to data stream"
    LOGGER.debug(f"Pushing event to Kinesis Stream")
    return kinesis_client.put_records(
        Records=[{"Data": data.encode(
            "utf-8"), "PartitionKey": str(partition_key)}],
        StreamName=stream_name
    )


def _ingesting_web(endpoint):
    "This function will ingest raw data from endpoint without Authentication"
    try:
        LOGGER.debug(f'Calling endpoint')
        res = requests.get(endpoint)
        payload = json.loads(res.text)
        LOGGER.debug(f'Raw data: {payload}')

    except ValueError:
        LOGGER.exception('Value Error')
    except Exception as e:
        LOGGER.exception(f'Ingestion failed with {e}')
    return payload


def lambda_handler():
    endpoint = WEB_ENDPOINT
    stream_name = RAW_STREAM_NAME
    LOGGER.debug(f'Starting to pull data from endpoint')
    data = _ingesting_web(endpoint)
    partition_key = data['id']
    _pushing_record_to_kinesis(data, partition_key, stream_name)

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "Message": "Success to Ingest Records"
        })
    }

    # Todo:
    # 1. Failed handler
    # 2. Disaster Recovery
