# google-actions » usage

Review this curated collection of dispatch workflows.

## Guides

### Quick

Take this path when you want to get up-and-running as quickly as possible with the least amount of fuss.

| Action | Link |
| :---   | :---: |
| _Create workflows_ | Choose `create` before clicking on the `Run workflow` button |
| KMS Key | [:white_check_mark:](../../../actions/workflows/google-kms-dispatch.yml) |
| Remote Backend Support | [:white_check_mark:](../../../actions/workflows/google-provided-remote-backend-dispatch.yml) |
| Toolset image | [:white_check_mark:](../../../actions/workflows/google-ubuntu-22_04.yml) |
| DNS Zone for base domain | [:white_check_mark:](../../../actions/workflows/google-main-dns-dispatch.yml) |
| DNS Zone for sub domain | [:white_check_mark:](../../../actions/workflows/google-child-dns-dispatch.yml) |
| Create workshop environment | [:white_check_mark:](../../../actions/workflows/google-e2e.yml) |
| _Cleanup workflows_ | Choose `destroy` before clicking on the `Run workflow` button |
| Destroy workshop environment | [:white_check_mark:](../../../actions/workflows/google-e2e-destroy.yml) |
| DNS Zone for sub domain | [:white_check_mark:](../../../actions/workflows/google-child-dns-dispatch.yml) |
| DNS Zone for base domain | [:white_check_mark:](../../../actions/workflows/google-main-dns-dispatch.yml) |
| Remote Backend Support | [:white_check_mark:](../../../actions/workflows/google-provided-remote-backend-dispatch.yml) |
| KMS Key | [:white_check_mark:](../../../actions/workflows/google-kms-dispatch.yml) |
| Clean Workflow Logs | [:white_check_mark:](../../../actions/workflows/clean-workflow-run-logs.yml) |


### Deliberate

Administer resources one at a time.

There are two types of actions defined, those that can be manually triggered (i.e., dispatched), and those that can only be called by another action.  All actions are located [here](../../../actions) and can be run by providing the required parameters.  Go [here](../../.github/workflows) to inspect the source for each action.

> Note that for most dispatch actions, you have the option to either create or destroy the resources.

#### Modules

| Module       | Github Action       | Terraform               |
| :---       | :---:               | :---:                   |
| KMS |[:white_check_mark:](../../actions/workflows/google-kms-dispatch.yml) | [:white_check_mark:](https://github.com/clicktruck/google-terraform/tree/main/modules/kms) |
| Remote backend | [:white_check_mark:](../../actions/workflows/google-provided-remote-backend-dispatch.yml) | [:white_check_mark:](https://github.com/clicktruck/google-terraform/tree/main/modules/tfstate-support) |
| VPC | [:white_check_mark:](../../actions/workflows/google-virtual-network-dispatch.yml) | [:white_check_mark:](https://github.com/clicktruck/google-terraform/tree/main/modules/virtual-network) |
| DNS Zone for base domain | [:white_check_mark:](../../actions/workflows/google-main-dns-dispatch.yml) | [:white_check_mark:](https://github.com/clicktruck/google-terraform/tree/main/modules/main-dns) |
| DNS Zone for sub domain | [:white_check_mark:](../../actions/workflows/google-child-dns-dispatch.yml) | [:white_check_mark:](https://github.com/clicktruck/google-terraform/tree/main/modules/child-dns) |
| GKE Cluster | [:white_check_mark:](../../actions/workflows/google-k8s-cluster-dispatch.yml) | [:white_check_mark:](https://github.com/clicktruck/google-terraform/tree/main/modules/cluster/standard) |
| GKE Autopilot Cluster | [:white_check_mark:](../../actions/workflows/google-k8s-autopilot-cluster-dispatch.yml) | [:white_check_mark:](https://github.com/clicktruck/google-terraform/tree/main/modules/cluster/autopilot) |
| Container registry | [:white_check_mark:](../../actions/workflows/google-container-registry-dispatch.yml) | [:white_check_mark:](https://github.com/clicktruck/google-terraform/tree/main/modules/registry) |
| Harbor | [:white_check_mark:](../../actions/workflows/google-harbor-dispatch.yml) | [:white_check_mark:](../terraform/k8s/harbor) |
| Bastion | [:white_check_mark:](../../actions/workflows/google-bastion-dispatch.yml) | [:white_check_mark:](https://github.com/clicktruck/google-terraform/tree/main/modules/bastion) |
| Secrets Manager | [:white_check_mark:](../../actions/workflows/google-secrets-manager-dispatch.yml) | [:white_check_mark:](https://github.com/clicktruck/google-terraform/tree/main/modules/secrets-manager) |
| Secrets | [:white_check_mark:](../../actions/workflows/google-secrets-manager-secrets-dispatch.yml) | [:white_check_mark:](https://github.com/clicktruck/google-terraform/tree/main/modules/secrets-manager-secrets) |


## Accessing credentials

All Credentials are stored in Google Cloud Secrets Manager.

First, configure Google Cloud using the service account credentials you created earlier

Go visit the Secret Manager Secrets Terraform module's [README](https://github.com/clicktruck/google-terraform/tree/main/modules/secrets-manager-secrets/README.md#accessing-a-secret) for how to retrieve secrets.
