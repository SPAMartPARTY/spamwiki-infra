# GitHub Self-Hosted Runner Setup

This directory contains the configuration and bootstrap script for setting up a GitHub Actions self-hosted runner for the `SPAMartPARTY/spamwiki-infra` repository.

## Files

- `bootstrap-runner.sh`: Automates installation, registration, and service setup for the runner.
- `github-runner.service`: systemd unit file to run the GitHub Actions runner as a persistent service.

## Prerequisites

- A Linux machine with internet access and `curl`, `unzip`, `jq`, `sudo` installed.
- `GITHUB_PAT` environment variable exported with a token that has:
  - `repo` scope (for private repositories)
  - `admin:repo_hook` (for registering the runner)

## Quickstart

```bash
# Export your GitHub Personal Access Token to avoid prompt
export GITHUB_PAT=ghp_yourtokenhere

# Navigate to the runner setup directory
cd .runner

# Run the bootstrap script
bash bootstrap-runner.sh
```

This will:
- Download the latest runner binary.
- Register the runner with GitHub.
- Install and start the runner as a systemd service.

## Re-running Setup

If you need to re-register the runner (e.g., token expires or moved to another machine):

```bash
bash bootstrap-runner.sh
```

## Removing the Runner

To remove the runner:

```bash
sudo ./svc.sh stop
./config.sh remove --token <GITHUB_PAT>
```

## Security Considerations

- Do **not** store your GitHub PAT inside scripts or commit it to version control.
- The public SSH key is safe to include in the repository; private keys should **never** be committed.
- This runner is configured per-repo, not org-wide.
- Ensure the machine running this is secured and monitored.

---

Maintained by: [SPAMartPARTY]
