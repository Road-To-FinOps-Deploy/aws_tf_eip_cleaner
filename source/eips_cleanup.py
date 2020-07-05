"""
Releases EIPS that are not in use
"""

import boto3

def remove_IPS():
    client = boto3.client('ec2')
    addresses_dict = client.describe_addresses()
    for eip_dict in addresses_dict['Addresses']:
        if "NetworkInterfaceId" not in eip_dict:
            print(eip_dict['PublicIp'])
            client.release_address(AllocationId=eip_dict['AllocationId'])


def lambda_handler(event, context):
    remove_IPS()