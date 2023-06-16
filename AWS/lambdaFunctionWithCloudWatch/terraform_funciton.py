import boto3

region = 'eu-west-1'


def lambda_handler(event, context):
    id_list = []
    ec2 = boto3.client('ec2', region_name = 'eu-west-1')
    response = ec2.describe_instances(Filters=[
            {
                'Name': 'instance-state-code',
                'Values': ['16']
            }
        ])
    
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            id_list.append(instance['InstanceId'])
            
    for id in id_list:
        ec2.stop_instances(InstanceIds=[id])