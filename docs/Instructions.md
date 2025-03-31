# Project Setup Instructions

## 1. Create a Google Cloud Project
1. Go to [Google Cloud Console](https://console.cloud.google.com/).
2. Create a new project.

## 2. Create a Service Account
1. Navigate to **IAM & Admin > Service Accounts**.
2. Click **Create Service Account**.
3. Assign the following roles:
   - **Storage Admin** (for GCS access)
   - **BigQuery Admin** (for BigQuery access)
4. Click **Done**.

## 3. Generate a JSON Key
1. In the **Service Accounts** section, find your newly created service account.
2. Click on it and go to the **Keys** tab.
3. Click **Add Key > Create new key**.
4. Select **JSON** and download the key.
5. Move the JSON key to the `terraform/keys/` folder and rename it as:
   ```sh
   terraform/keys/my-creds.json
   ```

## 4. Update Configuration Files
Modify the following files with your project-specific values:
- [`.env`](link_here)
- [`variables.tf`](link_here)

## 5. Run the Makefile
Execute the Makefile:
```sh
make
```
If `make` is not available, manually run the commands in order from:
- [`instructions.txt`](link_here)

## 6. Run the Flow in Kestra
1. Open Kestra in your browser: [http://localhost:8080/ui/dashboards/default](http://localhost:8080/ui/dashboards/default)
2. Navigate to **flow_04**.
3. Execute the **master_pipeline**.

## 7. Create the Dashboard in Looker Studio
1. Use the table **join_disaster** in BigQuery.
2. Build your dashboard based on the transformed data.

---
Now you're ready to analyze disaster data with Looker Studio! 🚀
