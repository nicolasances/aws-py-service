import os
from abc import ABC, abstractmethod
from totoapicontroller.TotoLogger import TotoLogger
from totoapicontroller.model.singleton import singleton
from google.cloud import secretmanager

import boto3
from botocore.exceptions import ClientError

class TotoConfig(ABC): 
    
    jwt_key: str
    
    def __init__(self) -> None:
        
        self.logger = TotoLogger(self.get_api_name())
        
        self.logger.log("INIT", "Loading Configuration (temp version)..")
        
        #self.jwt_key = self.access_secret_version("jwt-signing-key")
        self.jwt_key = self.access_aws_secret_version("dev/jwt-signing-key", "eu-west-1")
        
    
    @abstractmethod
    def get_api_name(self) -> str: 
        pass
    
    
    def access_secret_version(self, secret_id, version_id="latest"):
        """
        Retrieves a Secret on GCP Secret Manager
        """

        project_id = os.environ["GCP_PID"]

        # Create the Secret Manager client
        client = secretmanager.SecretManagerServiceClient()

        # Build the resource name of the secret version
        name = f"projects/{project_id}/secrets/{secret_id}/versions/{version_id}"

        # Access the secret version
        response = client.access_secret_version(name=name)

        # Extract the secret payload
        payload = response.payload.data.decode("UTF-8")

        return payload


    def access_aws_secret_version(self, secret_name, region_name):
        """
        Retrieves a Secret on AWS Secrets Manager
        """

        # Create a Secrets Manager client
        session = boto3.session.Session()
        client = session.client(
            service_name='secretsmanager',
            region_name=region_name, 
        )

        try:
            get_secret_value_response = client.get_secret_value( SecretId=secret_name )
        except ClientError as e:
            raise e

        secret = get_secret_value_response['SecretString']

        return secret
