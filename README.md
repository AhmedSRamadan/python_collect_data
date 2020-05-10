# python_collect_data
pyhon collect data from api deployed in flask container with nginx as reverse proxy


Project this project utilize IaC solutions by using terraform to fully automate the deployment process of a small application to collect data from Chuck Norris jokes API

project in details and how to run it in two ways

1 - Terraform in the main path you can run this two commands ( terraform init && terraform apply ) then you will find ec2 machine created and you will found public ip in the terraform output appear after running the above two commands

run in browser ( http://ec2-ip ) : you will found the result of data collected from chuck norries api

terraform project description terraform main code ( main.tf ): is full of all needed resources && data modules to build machine and run user data script which will build the project inside the machine script.sh : script run after machine created in user data variable in main.tf && this script install docker & docker-compose & git and build docker-compose project

2- Docker-compose : you can run docker-compose build && docker-compose up to run the project from any machine has docker and docker-compose installed

docker-compose project description : two folders : app ( for the python code and usgwi app server ) && nginx ( sidecare container to receive the traffice then make reverse proxy to the application server ( from port 80 to port 5000 ) )
