param (
    [string]$AppName
)

# Function to display usage information
function Show-Usage {
    Write-Host "Usage: .\deploy-loco.ps1 -AppName <application_name>"
    Write-Host "Options:"
    Write-Host "  -AppName <application_name>  Specify the application name to deploy (e.g., loco)."
    exit 1
}

# Check if AppName is provided
if (-not $AppName) {
    Write-Host "**********************************************"
    Write-Host "Error: Missing application name flag."
    Show-Usage
    Write-Host "**********************************************"
}

# Install namespace if not already exists
Write-Host "**********************************************"
    Write-Host "Creating namespace '$AppName'..."
    kubectl apply -f namespace-yamls/${AppName}-namespace.yaml
    Write-Host "Namespace '$AppName' created."

# Apply service.yaml
Write-Host "**********************************************"
Write-Host "Applying service configuration..."
kubectl apply -f service-yamls/${AppName}-service.yaml --namespace=$AppName
Write-Host "Service configuration applied."

# Delete existing deployment and re-deploy
Write-Host "**********************************************"
Write-Host "Deleting existing deployment..."
kubectl delete -f deployments-yamls/${AppName}-deployment.yaml --namespace=$AppName
Write-Host "Deploying new application..."
kubectl apply -f deployments-yamls/${AppName}-deployment.yaml --namespace=$AppName
Write-Host "Application deployed."

# Install Horizontal Pod Autoscaler (HPA)
Write-Host "**********************************************"
Write-Host "Applying HPA configuration..."
kubectl apply -f hpa-yamls/${AppName}-hpa.yaml --namespace=$AppName
Write-Host "HPA configuration applied."

# Install metrics-server
Write-Host "**********************************************"
Write-Host "Applying metrics-server configuration..."
kubectl apply -f metrics-server-yamls/components.yaml
Write-Host "Metrics-server installed."

# Install Nginx Ingress Controller
Write-Host "**********************************************"
Write-Host "Enabling Nginx Ingress addon..."
minikube addons enable ingress
Write-Host "Applying Nginx Ingress configuration..."
kubectl apply -f nginx-yamls/${AppName}-ingress.yaml --namespace=$AppName
Write-Host "Nginx Ingress configuration applied."

# Run minikube tunnel in the background
Write-Host "**********************************************"
Write-Host "Starting minikube tunnel in the background..."
Start-Process "minikube" "tunnel"
Write-Host "Minikube tunnel started."
Write-Host "**********************************************"
Write-Host "Deployment script completed successfully."
Write-Host "**********************************************"