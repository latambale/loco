# loco

1. Steps.txt - I have written in detail about all the steps I took to complete the task along with lessons I learned to complete it.
2. app - This directory has all the node js application code along with Dockerfile
3. deployment-yamls - This directory has deployment yaml file, which will create pods of application.
4. namespace-yamls - This directory has namespace yaml file, which will create namespace in cluster.
5. service-yamls - This directory has service yaml file, which will create ClusterIP and NodePort services.
6. hpa-yamls - This directory has hpa yaml file, which will install Horizontal Pod Autoscaler.
7. metrics-server-yamls - This directory has metrics-server component file, which will install metrics-server.

8. deploy-loco.ps1 - Is simple deploy script created to deploy/refresh loco application in single command on cluster.
Usage:
    : .\deploy-loco.ps1 -AppName <application_name>
