# Terraform Security Review Assistant with Kestra

A workflow built with [Kestra](https://kestra.io) that scans Terraform files for security and compliance issues using [Checkov](https://www.checkov.io).

## Problem Statement

Infrastructure as Code (IaC) enables teams to define cloud resources using code. However, misconfigurations in Terraform can introduce security risks such as:

- Public S3 buckets
- Open security groups (`0.0.0.0/0`)
- Missing encryption
- Disabled versioning
- Unrestricted IAM policies

This project performs a **pre-deployment security review** of Terraform files and generates a report before any infrastructure is created.

## How It Works

The workflow is orchestrated entirely by Kestra.

1. User uploads a Terraform (`.tf`) file.
2. Kestra starts a workflow execution.
3. Kestra runs Checkov inside a container.
4. Checkov analyzes the Terraform code.
5. Findings are displayed in the execution logs.
6. (Optional) Reports are stored as artifacts and sent by email or Slack.

## Architecture

```text
Developer uploads Terraform file
            ↓
         Kestra
            ↓
 Run Checkov in Docker container
            ↓
   Parse security findings
            ↓
 Generate security report
            ↓
 Store artifacts / Send notification
