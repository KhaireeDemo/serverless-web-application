-------------------------
    Task Overview
-------------------------

Since i received the task and i figure out to terraform as IaC framework for my task as i didn't use it before and it was interesting to learn something new. 
So in this readme file i will explain how i started the task step by step until finishing it with the below steps.

a- Plan
b- Prepation
c- Installation
d- Code hierarchy
e- Steps to Build, deploy, and test

-------------------------
          Plan
-------------------------

First I decided to use the GitHub repository to carry my code base using the github actions workflow linked with a terraform cloud account to plan, and apply my configuration on an AWS account. 
This project implements an AWS lambda function that runs a simple Nodejs api gateway application which prints request header, method, and body.



Terraform Cloud, and Github actions Workflow


                                                                |------------------------------- 
                                                                v                              |
		        |-------------------------|             |-----------------|                    |
                |     GitHub repository   |------------>|   Pull Request  |------------->|----------------
                |-------------------------|             |-----------------|              |               |        |-----------> AWS 
                             ^                                                           |   Terraform   |        |            
                             |                                                           |      Cloud    |--------|        
                             |                          |-----------------|              |               |        |
                             |------------------------->|      Master     |------------->|---------------|        |-----------> AWS
                                                        |-----------------|              



-------------------------
        Prepation
-------------------------

Now we should have the following Prerequisites

1- GitHub Account
2- Terraform Cloud account
3- AWS account and AWS Access Credentials

-------------------------
        Installation
-------------------------

Step 1: I created an AWS Access Key ID and Secret Access Key and configured it on my Terraform cloud account by creating a new workspace "API-driven workflow" , then added AWS Access Key ID and Secret Access Key as "Environment Variables".
#### I added the access Key ID and Secret Access Key to my root account directly, but for security it should be created on a limited access user with the needed permission for my terraform configuration file only.

Step 2: Then I went to the Tokens page in my Terraform Cloud User Settings, and generated an API token to link my terraform cloud with Github account.
Step 3: Now i created a new github public repo and added my simple Nodejs app to it, and from repo settings, i created a new secret using my Terraform Cloud API token.

So now my environment is ready to write my terraform files, and github actions yml configuration to plan, and apply my terraform configuration.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
###Workflow actions#### 

a- Pull Request Workflow:
**** Checkout --> Setup Terraform --> Terraform format --> Terraform init --> Terraform plan --> Update Pull Request --> Terraform Plan Status.

b- Merge to Master Workflow:

**** Checkout --> Setup Terraform --> Terraform format --> Terraform init --> Terraform apply.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------
        Code hierarchy
-------------------------

Here's my main files, and hierarchy.

1- terraform.yml under .github/workflows: The file contains my terraform configuration by creating terraform jobs to do (init, validate, plan, and apply).
2- index.js under src folder: This file contains my simple web service API code, written by Nodejs.
3- Terraform file: i created my terraform files with the following structure
    a- main.tf: The main terraform file which contains my aws region, and terraform cloud organization, and terraform workspace. Also contains the module link to module files. 
    b- variables.tf: I generated this file to carry some variables which were used in my main files.
    c- output.tf: This file is used to print my lambda api gateway base link which will be used to hit my web service after deployment.
    d- lambda_with_aws_api_gw_module: Contains the main.tf file with all my project infrastructure build configuration.


--------------------------------
Steps to Build, deploy, and test
--------------------------------

To do the full pracaties of build, deploy, and test in a new aws account, and terraform cloud account. Just do the below steps

1- Clone my github repo to a new repo on your github account with a new branch "stage" for example.
2- Create AWS Access Key ID and Secret Access Key using your account, then configure it in your terraform cloud. ** Follow the steps on the installation section section **
3- In your github repo settings, create a new secret using your a terraform Cloud API token with the exact name which i usedC it in the terraform.yml file 'TF_API_TOKEN'.
###NOTE: You can use an existing configured connection by replacing your existing github secret name with the one saved in the terraform.yml in the 'cli_config_credentials_token' variable.
4- In Github Repo create a new pull request from "stage" branch to "master" branch.
5- Once your pull request is done successfully, Click on 'Merge Pull Request', and 'Confirm Merge'.
6- Now click on actions tap from on your repo, then click on merge pull request, then the terraform button to check the terraform plan , and apply.
7- Once the 'Merge pull request' is done, expand the 'Terraform Apply' section, and scroll to the end to find your 'api_base_url'.
8- Use this api_base_url/api to reach the created simple web application that runs on AWS Lambda.


##### Also My created project is up and running under the URL 'https://ceugd6m65k.execute-api.us-east-1.amazonaws.com/serverless_lambda_stage/api'.


