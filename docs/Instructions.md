# Project Setup Instructions

## 1. Clone the Repository
First, clone this repository to your local machine:
```sh
git clone https://github.com/valeqm/World-Disaster-Pipeline.git
```
Then, navigate into the project folder:
```sh
cd World-Disaster-Pipeline
```

## 2. Create a Google Cloud Project
1. Go to [Google Cloud Console](https://console.cloud.google.com/).
2. Create a new project.

## 3. Create a Service Account
1. Navigate to **IAM & Admin > Service Accounts**.
2. Click **Create Service Account**.
3. Assign the following roles:
   - **Storage Admin** (for GCS access)
   - **BigQuery Admin** (for BigQuery access)
4. Click **Done**.

## 4. Generate a JSON Key
1. In the **Service Accounts** section, find your newly created service account.
2. Click on it and go to the **Keys** tab.
3. Click **Add Key > Create new key**.
4. Select **JSON** and download the key.
5. Move the JSON key to the `terraform/keys/` folder and rename it as:
   ```sh
   terraform/keys/my-creds.json
   ```

## 5. Update Configuration Files
Modify the following files with your project-specific values:
- [`.env`](../.env)
- [`variables.tf`](/terraform/variables.tf)

## 6. Run the Makefile
Before running the Makefile or executing the instructions, install the necessary Python libraries:
```sh
pip install os requests ruamel.yaml json dotenv
```
Execute the Makefile:
```sh
make
```
If `make` is not available, manually run the commands in order from:
- [`instructions.txt`](/docs/instructions.txt)

**Note:** You need to run it from the project root folder.

## 7. Run the Flow in Kestra
1. Open Kestra in your browser: [http://localhost:8080/ui/dashboards/default](http://localhost:8080/ui/dashboards/default)
2. Navigate to the flow **04_master_pipeline**.
   
   ![Navigate to flow_04](/docs/images/flow_04%20(1).png)
   
3. Execute the **04_master_pipeline**. The button is located at the top right corner.
   
   ![Execute master_pipeline](/docs/images/flow_04%20(2).png)

## 8. Create the Dashboard in Looker Studio
1. Use the table **join_disaster** in BigQuery.
2. Build your dashboard based on the transformed data.

---
Now you're ready to analyze disaster data with Looker Studio! 🚀

**Note:** If you want to remove the infrastructure created by Terraform, you can run:
```sh
terraform destroy
```

