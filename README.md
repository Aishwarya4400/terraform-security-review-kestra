# Terraform Security Review Assistant with Kestra

A workflow built with Kestra that scans Terraform files for security and compliance issues using Checkov.

---

## Problem Statement

Infrastructure as Code (IaC) enables teams to define cloud resources using code. However, Terraform misconfigurations can introduce serious security risks such as:

- Public S3 buckets
- Open security groups (`0.0.0.0/0`)
- Missing encryption
- Disabled versioning
- Unrestricted IAM policies
- Missing resource tags

This project performs a **pre-deployment security review** of Terraform files and generates downloadable reports before any infrastructure is created.

---

## How It Works

The workflow is orchestrated entirely by Kestra.

1. Upload a Terraform (`.tf`) file through the Kestra UI.
2. Kestra starts a workflow execution.
3. Kestra installs and runs Checkov in a container.
4. Checkov analyzes the Terraform code.
5. Kestra stores the results as downloadable artifacts.
6. Developers review the findings and remediate issues before deployment.

---

## Architecture

```text
Developer uploads Terraform file
            ↓
         Kestra
            ↓
 Install Checkov in Container
            ↓
 Run Terraform Security Scan
            ↓
 Generate TXT and JSON Reports
            ↓
 Store Artifacts
            ↓
 Download Security Findings
```

---

## Why Kestra?

Kestra is the orchestration engine that coordinates the complete process.

Kestra is responsible for:

- Accepting file inputs
- Executing containerized tasks
- Managing task dependencies
- Collecting logs and outputs
- Storing artifacts
- Sending notifications
- Providing an execution dashboard

Checkov performs the actual security analysis; Kestra automates and manages the workflow around it.

---

## Tech Stack

- Kestra
- Checkov
- Docker
- Terraform
- Python 3.11

---

## Project Structure

```text
terraform-security-review-kestra/
├── flows/
│   └── terraform-security-review.yml
├── terraform/
│   └── insecure-example.tf
├── docker-compose.yml
├── README.md
└── .gitignore
```

---

## Sample Terraform File

The repository includes an intentionally insecure Terraform example containing:

- An S3 bucket without encryption or versioning
- A security group allowing SSH from anywhere (`0.0.0.0/0`)

This demonstrates how the workflow identifies security issues before deployment.

---

## Kestra Workflow

The flow:

- Accepts a Terraform file as input
- Copies the uploaded file to a local working file
- Installs Checkov
- Runs the security scan
- Generates:
  - `checkov-report.txt`
  - `checkov-report.json`
- Stores reports as execution artifacts

---

## Prerequisites

- Docker and Docker Compose
- Kestra running locally

---

## Run Kestra Locally

Download the official Docker Compose file and start Kestra:

```bash
curl -o docker-compose.yml https://raw.githubusercontent.com/kestra-io/kestra/develop/docker-compose.yml
docker compose up -d
```

Open the Kestra UI:

```text
http://localhost:8080
```

---

## Import the Workflow

1. Open the Kestra UI.
2. Navigate to **Flows**.
3. Create a new flow.
4. Paste the contents of `flows/terraform-security-review.yml`.
5. Save the flow.

---

## Execute the Workflow

1. Click **Execute**.
2. Upload `terraform/insecure-example.tf`.
3. Start the execution.
4. Wait for the workflow to complete successfully.

---

## Download the Reports

After execution:

1. Open the completed execution.
2. Click the `run_checkov` task.
3. Open the **Outputs** tab.
4. Download:
   - `checkov-report.txt`
   - `checkov-report.json`

---

## Expected Findings

Typical findings include:

- Security group allows SSH from `0.0.0.0/0`
- S3 bucket encryption not enabled
- S3 bucket versioning not enabled
- Missing public access block configuration

---

## Example Output

```text
Check: CKV_AWS_24: Ensure no security groups allow ingress from 0.0.0.0/0 to port 22
FAILED for resource: aws_security_group.web

Check: CKV_AWS_19: Ensure all S3 buckets have versioning enabled
FAILED for resource: aws_s3_bucket.example
```

---

## Use Cases

- Pre-commit Terraform validation
- CI/CD security checks
- Developer self-service scanning
- Training and education
- DevSecOps automation

---

## Future Enhancements

- Generate Markdown and PDF reports
- Security score calculation
- Severity-based summaries
- Slack and email notifications
- AI-generated remediation guidance
- Support for scanning entire Terraform directories

---

## Business Value

This project demonstrates how workflow orchestration can automate security checks before deployment, helping teams:

- Detect misconfigurations early
- Reduce remediation costs
- Improve security posture
- Shift security left in the development lifecycle

---

## Demo Steps

1. Open Kestra.
2. Upload the insecure Terraform file.
3. Execute the workflow.
4. Download `checkov-report.txt`.
5. Review the detected security findings.
6. Explain how Kestra orchestrates the end-to-end process.

---

## Challenge Submission Summary

**Terraform Security Review Assistant** is a Kestra-powered workflow that automates pre-deployment security analysis of Terraform code using Checkov and produces downloadable TXT and JSON reports containing actionable findings.

---

## Author

Aishwarya Joshi

---
