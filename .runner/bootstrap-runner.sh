#!/bin/bash
# bootstrap-runner.sh
# This script bootstraps a GitHub Actions self-hosted runner on a Linux host.

set -euo pipefail

# --- CONFIGURE ---
REPO_OWNER="SPAMartPARTY"
REPO_NAME="spamwiki-infra"
RUNNER_NAME="baremetal-runner"
LABELS="self-hosted,baremetal,terraform"

# You will be prompted for this each time unless stored securely or set as env
if [ -z "${GITHUB_PAT:-}" ]; then
  read -rp "Enter your GitHub Personal Access Token (repo & admin:repo_hook scopes): " GITHUB_PAT
fi

# --- CREATE RUNNER DIR ---
cd ~
mkdir -p actions-runner && cd actions-runner

# --- DOWNLOAD LATEST RUNNER ---
if [ ! -f ./actions-runner-linux-x64-2.317.0.tar.gz ]; then
  curl -O -L https://github.com/actions/runner/releases/download/v2.317.0/actions-runner-linux-x64-2.317.0.tar.gz
fi

tar xzf ./actions-runner-linux-x64-2.317.0.tar.gz

# --- CONFIGURE RUNNER ---
./config.sh \
  --url https://github.com/$REPO_OWNER/$REPO_NAME \
  --token $(curl -s -X POST -H "Authorization: token $GITHUB_PAT" \
    https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runners/registration-token | jq -r .token) \
  --name "$RUNNER_NAME" \
  --labels "$LABELS" \
  --unattended

# --- INSTALL SYSTEMD SERVICE ---
sudo ./svc.sh install
sudo ./svc.sh start

# --- DONE ---
echo "Runner installed and started successfully."
echo "Verify at: https://github.com/$REPO_OWNER/$REPO_NAME/settings/actions/runners"

