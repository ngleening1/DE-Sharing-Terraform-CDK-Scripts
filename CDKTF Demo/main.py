#!/usr/bin/env python
from constructs import Construct
from cdktf import App, TerraformStack, TerraformOutput
from imports.aws import AwsProvider, Instance
from imports.terraform_aws_modules.vpc.aws import TerraformAwsModulesVpcAws


class MyStack(TerraformStack):
    def __init__(self, scope: Construct, ns: str):
        super().__init__(scope, ns)

        # Provider Details
        AwsProvider(self, 'Aws', region="ap-southeast-1")

        # Using Individual Resource Module
        Demo_VPC = TerraformAwsModulesVpcAws(self, 'demo-vpc',
            name='Demo-VPC',
            cidr='10.0.0.0/16',
            azs=["ap-southeast-1a"],
            private_subnets=["10.0.2.0/24"]
        )

        # Using imports.aws
        Instance(self, 'ec2-instance',
            ami="ami-0ba0ce0c11eb723a1",
            instance_type="t2.micro",
            subnet_id=Demo_VPC.private_subnets[0]
        )


app = App()
MyStack(app, "CDK-demo")

app.synth()
