# chef-java-sample

* 1 - Script python Downloader
* 2 - Deploy app Java with CF On AWS

---

#### Download multiples URLs  ####

Reqs: Python 2, lib boto3

* Install boto3

```
pip install boto3

```
* Using Downloader

```
use ./downloader.py {arg1} {arg2} {argN}

```
---

#### Create Stack on AWS and Deploy Sample Java APP ####

AWS Region: sa-east-1, us-east-1


* Create Stack using Cloud Formation

```
aws cloudformation create-stack --region sa-east-1 --profile dev --stack-name GlovoStack --template-body file://create-stack-sample-java.json --parameters ParameterKey=ProjectName,ParameterValue=Glovo-sample-app ParameterKey=InstanceType,ParameterValue=t2.micro ParameterKey=VPCName,ParameterValue=glovo-sample ParameterKey=CIDRVPC,ParameterValue=172.16.0.0/22 ParameterKey=NameSub1,ParameterValue=AZa ParameterKey=NameSub2,ParameterValue=AZc ParameterKey=Sub1Zone,ParameterValue=sa-east-1a ParameterKey=Sub2Zone,ParameterValue=sa-east-1c ParameterKey=CIDRSub1,ParameterValue=172.16.0.0/24 ParameterKey=CIDRSub2,ParameterValue=172.16.1.0/24 ParameterKey=KeyName,ParameterValue=your_key

```

