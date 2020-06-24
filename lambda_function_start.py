import boto3
import sys, traceback
from datetime import datetime
from time import sleep


def start_ec2_instances(event):
    start_time = datetime.now()

    # starting ec2 client
    ec2_client = boto3.client('ec2')

    #regions = ec2_client.describe_regions()
    regions = ['sa-east-1']    

    for region in regions:
        try:
            #print("Region: " + str(region))
            ec2_client = boto3.client('ec2', region_name=region)
            instances = ec2_client.describe_instances()
            instanceIds = list()
            result = dict()
            
            for reservation in instances['Reservations']:
                for instance in reservation['Instances']:
                    if instance['Tags'] is not None : 
                        for tag in instance['Tags']:
                            try:
                                if tag['Key'] == 'ScheduledStartStop' and tag['Value'] == 'True':
                                    instanceIds.append(instance['InstanceId'])
                            except:
                                print("Not expected error: ", traceback.print_exc())
                      
            if len(instanceIds) > 0 :               
                ec2_client.start_instances(InstanceIds=instanceIds)
                result['started'] =  instanceIds,
                             
                                                            
        except:
            print("Not expected error:", traceback.print_exc())
                                                           
    end_time = datetime.now()
    took_time = end_time - start_time
    return {'instance_ids' : instanceIds, 'time': str(took_time)}
    # print("Total time of execution: " + str(took_time))  
     

def lambda_handler(event, context):
    #sprint('Starting instances... ')
    result = start_ec2_instances(event)
    return {
        'statusCode': 200,
        'body': result
    }