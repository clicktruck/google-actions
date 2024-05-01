# google-actions » prerequisites

* [Increase Google Cloud Quotas](#increase-google-cloud-quotas)
* [Setup an Google Cloud service principal](#setup-an-google-cloud-service-principal)
* [Enable the Secret Manager API](#enable-the-secret-manager-api)
* [(Optional) Setup a Github SSH key-pair](#optional-setup-a-github-ssh-key-pair)
* [Setup a Personal Access Token in Github](#setup-a-personal-access-token-in-github)
* [Configure Github Secrets](#configure-github-secrets)

## Increase Google Cloud Quotas

There are a few Google Cloud default [quotas](https://cloud.google.com/compute/quotas) that may need to be adjusted.

1. VM instances
2. Networks

Choose the region and set the limit to >= 30 in your request.

> Note:  The above quotas will be enough to deploy the infrastructure needed for installing TAP.  Individual mileage may vary depending on existing resources.

### Setup an Google Cloud service principal

First, authenticate to Google Cloud.

> Do this only if you are planning on running Terraform scripts locally with an IAM user

```
gcloud auth login
```

Or set the necessary environment variables.

```
export GOOGLE_APPLICATION_CREDENTIALS=<path_to_your_principal_account_key>
```

Then visit the following Terraform module found [here](https://github.com/clicktruck/google-terraform/tree/main/modules/iam) and follow the instructions in the [README](https://github.com/clicktruck/google-terraform/tree/main/modules/iam#readme)

This will create the service account (with appropriate roles) that will be used by all other Terraform modules.

### Enable the Secret Manager API

Follow these [instructions](https://cloud.google.com/secret-manager/docs/accessing-the-api).


## (Optional) Setup a Github SSH key-pair

You will need to create a new public/private SSH key-pair in order to work with (i.e., pull from/push to) private git repositories (e.g., Github, Gitlab, Azure Devops).

Here's how to set up such a key-pair for named repo providers:

* [Github](https://docs.github.com/en/developers/overview/managing-deploy-keys)

Also see [Git Authentication](https://docs.vmware.com/en/VMware-Tanzu-Application-Platform/1.9/tap/scc-git-auth.html).


## Setup a Personal Access Token in Github

A PAT is required so that workflows can add secrets to the repository in order to be used in downstream jobs.  Documentation can be found [here](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).

> We are using this personal access token to create secrets for the `google` backend for Terraform

### Configure Github Secrets

Setup some Github secrets with the SP credentials.  Documentation can be found [here](https://docs.github.com/en/actions/security-guides/encrypted-secrets).  You might also consider using [gh secret set](https://cli.github.com/manual/gh_secret_set) command to set these individually. Or, after exporting all environment variables below, execute [gh-secrets-setup.sh](https://github.com/clicktruck/scripts/blob/main/gh-set-secrets.sh) at the command-line passing `google` as an execution argument.

```bash
# The Google Cloud project that will host all resources created
export GOOGLE_PROJECT_ID=
# The base64-encoded contents of the Google Cloud project's service account key that has the authority to create cloud resources
export GOOGLE_SERVICE_ACCOUNT_KEY=
```

You'll also want to [create another secret](https://github.com/clicktruck/scripts/blob/main/set-personal-access-token.sh) whose value is the fine-grained personal token you created in the prior step.

```bash
export PA_TOKEN=
```
