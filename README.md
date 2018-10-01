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

## License

[Apache-2.0 License][license]

[license]: LICENSE
[packer]: https://packer.io
[packer-googlecompute]: https://packer.io/docs/builders/googlecompute.html
[virtualbox]: https://www.virtualbox.org
[vmware]: https://www.vmware.com/products/fusion.html
[vagrant]: https://www.vagrantup.com
