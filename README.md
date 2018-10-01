# 📦 Packer Compute Images

A set of [Packer][packer] configurations to create compute images.

## Getting Started

Switch to the `packer` sub-directory.

1. You can build a single image by running:

       packer build -only=virtualbox-iso instance.json

   Replacing `virtualbox-iso` with `vmware-iso` or `googlecompute` as needed.

   If you use `googlecompute`, you will need to specify additional variables,
   so your command may look like:

       packer build -only=googlecompute -var ssh_username=ubuntu -var googlecompute_account_file=account.json -var googlecompute_project_id=<your project id> instance.json

   The `googlecompute_account_file` is a service account's JSON credential file
   as mentioned in the [Packer Google Compute Builder][packer-googlecompute] documentation.

2. If you are building a [VirtualBox][virtualbox] or [VMWare][vmware] image, you can use it with
   [Vagrant][vagrant], by running the following:

       vagrant box add ubuntu1804 box/virtualbox/ubuntu1804-0.1.0.box
       vagrant init ubuntu1804

## Google Cloud Build

If you want to automate this build in [Google Cloud Build][google-cloud-build],
one way you can do that is by setting up a service account, encrypting the
account's credentials and adding the encrypted file to the repository,
adding a `cloudbuild.yaml`, and setting up the Google Cloud Build trigger.

You will need to create a Google Cloud Service account with
`Compute Engine Instance Admin (v1)` and `Service Account User` roles.
Then create a credentials JSON file. See the
[Packer Google Compute Builder][packer-googlecompute] page for more details.

Then, encrypt the credentials file (renamed to `account.json`) using
[Google KMS][google-cloud-build-encrypt] after setting up a Google KMS keyring:

```
gcloud kms encrypt \
  --plaintext-file=account.json \
  --ciphertext-file=account.json.enc \
  --location=[KEYRING-LOCATION] \
  --keyring=[KEYRING-NAME] \
  --key=[KEY-NAME]
```

Add the `account.json.enc` file to the repository in the `packer` sub-directory.

You will need to add Packer as a Docker image in your GCP project's container
registry. See the [Google Cloud Builders Community Packer][google-cloud-builders-community-packer]
image.

You can use a `cloudbuild.yaml` like:

```yaml
steps:
  - name: gcr.io/cloud-builders/gcloud
    args:
      - kms
      - decrypt
      - --ciphertext-file=packer/account.json.enc
      - --plaintext-file=packer/account.json
      - --location=[KEYRING-LOCATION]
      - --keyring=core-[KEYRING-NAME]
      - --key=[KEY-NAME]
    id: decrypt credentials
  - name: gcr.io/$PROJECT_ID/packer
    args:
      - build
      - -only=googlecompute
      - -var
      - ssh_username=ubuntu
      - -var
      - googlecompute_account_file=account.json
      - -var
      - googlecompute_project_id=$PROJECT_ID
      - instance.json
    dir: packer
    id: build image with packer
timeout: 1200s
```

Add the `cloudbuild.yaml` to the repository and create a
[Cloud Build trigger][google-cloud-build-trigger].

## License

[Apache-2.0 License][license]

[license]: LICENSE
[packer]: https://packer.io
[packer-googlecompute]: https://packer.io/docs/builders/googlecompute.html
[virtualbox]: https://www.virtualbox.org
[vmware]: https://www.vmware.com/products/fusion.html
[vagrant]: https://www.vagrantup.com
[google-cloud-build]: https://cloud.google.com/cloud-build/
[google-cloud-build-encrypt]: https://cloud.google.com/cloud-build/docs/securing-builds/use-encrypted-secrets-credentials
[google-cloud-build-trigger]: https://cloud.google.com/cloud-build/docs/running-builds/automate-builds
[google-cloud-builders-community-packer]: https://github.com/GoogleCloudPlatform/cloud-builders-community/tree/master/packer
