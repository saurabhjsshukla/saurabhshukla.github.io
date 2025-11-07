# ======================================================================
# Author: Saurabh Shukla
# Script: create_structure.ps1
# Purpose: Auto-generate full MkDocs documentation structure + configs
# ======================================================================

Write-Host "🚀 Starting MkDocs documentation setup..." -ForegroundColor Cyan

# --- Folder structure -------------------------------------------------
$folders = @(
    "docs/rdbms",
    "docs/nosql",
    "docs/devops",
    "docs/containers",
    "docs/cloud",
    "docs/monitoring",
    "docs/scripting",
    "docs/os_virtualization",
    ".github/workflows"
)

foreach ($folder in $folders) {
    if (!(Test-Path $folder)) {
        New-Item -ItemType Directory -Force -Path $folder | Out-Null
        Write-Host "📁 Created folder: $folder"
    }
}

# --- Markdown files ---------------------------------------------------
$files = @(
    "docs/rdbms/oracle26ai.md",
    "docs/rdbms/postgresql.md",
    "docs/rdbms/mysql.md",
    "docs/rdbms/sqlserver.md",
    "docs/nosql/mongodb.md",
    "docs/nosql/dynamodb.md",
    "docs/devops/github.md",
    "docs/devops/gitlab.md",
    "docs/devops/ansible.md",
    "docs/devops/terraform.md",
    "docs/containers/docker.md",
    "docs/containers/podman.md",
    "docs/containers/kubernetes.md",
    "docs/containers/openshift.md",
    "docs/cloud/oci.md",
    "docs/cloud/aws.md",
    "docs/cloud/azure.md",
    "docs/cloud/gcp.md",
    "docs/monitoring/prometheus.md",
    "docs/monitoring/grafana.md",
    "docs/monitoring/elk.md",
    "docs/monitoring/oem.md",
    "docs/monitoring/cloudwatch.md",
    "docs/scripting/python.md",
    "docs/scripting/bash.md",
    "docs/scripting/shell.md",
    "docs/scripting/powershell.md",
    "docs/os_virtualization/linux.md",
    "docs/os_virtualization/oracle_kvm.md"
)

foreach ($file in $files) {
    if (!(Test-Path $file)) {
        "# Coming soon..." | Out-File -FilePath $file -Encoding utf8
        Write-Host "📝 Created file: $file"
    }
}

# --- Homepage ---------------------------------------------------------
$indexContent = @"
# 🧭 Saurabh Shukla Docs
### Multi-RDBMS, DevOps & Cloud Knowledge Base

Welcome to my centralized technical documentation repository.  
This site consolidates years of practical experience across enterprise-grade Database Administration,
Cloud Architecture, DevOps, and Automation practices.

---

© **Saurabh Shukla** — Multi-RDBMS | Cloud Architect | DevOps Expert
"@
$indexContent | Out-File -FilePath "docs/index.md" -Encoding utf8
Write-Host "🏠 Created homepage (index.md)"

# --- mkdocs.yml -------------------------------------------------------
$mkdocsYml = @"
site_name: "Saurabh Shukla Docs — Multi-RDBMS, DevOps & Cloud Knowledge Base"
site_author: "Saurabh Shukla"
site_description: "Centralized technical documentation covering Databases, DevOps, Cloud, and Automation"
theme:
  name: material
  palette:
    scheme: default
    primary: blue
    accent: indigo
  features:
    - navigation.expand
    - navigation.sections
    - navigation.tabs
    - search.suggest
    - search.highlight
extra:
  meta:
    robots: noindex
copyright: "© Saurabh Shukla"
nav:
  - Home: index.md
  - RDBMS:
      - Oracle 26ai: rdbms/oracle26ai.md
      - PostgreSQL: rdbms/postgresql.md
      - MySQL: rdbms/mysql.md
      - SQL Server: rdbms/sqlserver.md
  - No-SQL:
      - MongoDB: nosql/mongodb.md
      - AWS DynamoDB: nosql/dynamodb.md
  - DevOps & Automation:
      - GitHub: devops/github.md
      - GitLab: devops/gitlab.md
      - Ansible: devops/ansible.md
      - Terraform: devops/terraform.md
  - Containerization & Orchestration:
      - Docker: containers/docker.md
      - Podman: containers/podman.md
      - Kubernetes: containers/kubernetes.md
      - OpenShift: containers/openshift.md
  - Cloud Platforms:
      - OCI: cloud/oci.md
      - AWS: cloud/aws.md
      - Azure: cloud/azure.md
      - GCP: cloud/gcp.md
  - Monitoring & Observability:
      - Prometheus: monitoring/prometheus.md
      - Grafana: monitoring/grafana.md
      - ELK/EFK Stack: monitoring/elk.md
      - OEM: monitoring/oem.md
      - CloudWatch: monitoring/cloudwatch.md
  - Scripting & Programming:
      - Python: scripting/python.md
      - Bash: scripting/bash.md
      - Shell: scripting/shell.md
      - PowerShell: scripting/powershell.md
  - OS & Virtualization:
      - Linux (OEL/RHEL): os_virtualization/linux.md
      - Oracle KVM: os_virtualization/oracle_kvm.md
"@
$mkdocsYml | Out-File -FilePath "mkdocs.yml" -Encoding utf8
Write-Host "⚙️ Created mkdocs.yml configuration file"

# --- GitHub Actions Workflow -----------------------------------------
$workflow = @"
name: Deploy MkDocs site to GitHub Pages

on:
  push:
    branches: [ main ]
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.x'

      - name: Install dependencies
        run: |
          pip install mkdocs mkdocs-material

      - name: Build and deploy MkDocs site
        run: |
          mkdocs gh-deploy --force
"@
$workflow | Out-File -FilePath ".github/workflows/mkdocs.yml" -Encoding utf8
Write-Host "🤖 Created GitHub Actions workflow"

Write-Host "`n✅ All folders, files, and configurations created successfully!" -ForegroundColor Green
