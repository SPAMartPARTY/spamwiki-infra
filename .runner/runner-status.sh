#!/bin/bash
# .runner/runner-status.sh

set -euo pipefail
SERVICE="actions.runner.SPAMartPARTY-spamwiki-infra.baremetal-runner.service"

echo "🔍 Checking GitHub Actions Runner service status..."
systemctl status "$SERVICE" --no-pager

