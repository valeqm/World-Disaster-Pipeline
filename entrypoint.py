import os
import requests
import ruamel.yaml
import json
from dotenv import load_dotenv


# Kestra Configuration
KESTRA_BASE_URL = "http://localhost:8080/api/v1"
NAMESPACE = "world_disaster"  # Namespace for all flows and KeyValues (modify if necessary)
HEADERS_kv = {"Content-Type": "application/json"} 
HEADERS = {"Content-Type": "application/x-yaml"}

yaml = ruamel.yaml.YAML()

# Function to create a flow from a YAML file
def create_flow(flow_path):
    with open(flow_path, "r") as file:
        flow_data = file.read()

    url = f"{KESTRA_BASE_URL}/flows" 
    response = requests.post(url, data=flow_data, headers=HEADERS)
    print(f"Creating flow from {flow_path}...")
    if response.status_code == 200:
        print(f"Flow {flow_path} created successfully.")
    else:
        print(f"Error creating {flow_path}: {response.status_code} - {response.text}")

    return response.status_code, response.text

# Create all flows in the "flows" folder
flows_dir = "flows"
if os.path.exists(flows_dir):
    for filename in os.listdir(flows_dir):
        if filename.endswith(".yml"):
            flow_path = os.path.join(flows_dir, filename)
            status, response = create_flow(flow_path)

# Function to upload KeyValues
def upload_keyvalues(keyvalues):
    for key, value in keyvalues.items():
        url = f"{KESTRA_BASE_URL}/namespaces/{NAMESPACE}/kv/{key}"
        
        response = requests.put(url, data= str(value), headers=HEADERS_kv)
        print(f"Uploading KeyValue - {key}: {response.status_code} - {response.text}")

# Load environment variables from the .env file
load_dotenv()

# Function to load GCP credentials from the file path in the .env file
def load_credentials():
    creds_path = os.getenv("GCP_CREDS_PATH")
    with open(creds_path, 'r') as file:
        return json.load(file)

# KeyValues (you can add more if needed)
keyvalues = {
    "GCP_CREDS": load_credentials(),
    "GCP_PROJECT_ID": os.getenv("GCP_PROJECT_ID"),
    "GCP_LOCATION": os.getenv("GCP_LOCATION"),
    "GCP_BUCKET_NAME": os.getenv("GCP_BUCKET_NAME"),
    "GCP_DATASET": os.getenv("GCP_DATASET")
}

# Upload KeyValues
upload_keyvalues(keyvalues)



