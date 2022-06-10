This docker image contains all the tools needed to build and manage my
infrastructure in a cloud-like fashion. It must be built with BuildKit enabled.
Since ARM is all the rage in the cloud these days, this image is designed to be
architecture-agnostic where possible.  It is based on an Ubuntu LTS image with
the following (plus a few dependencies):

* git
* vim
* python
* oci-cli
* terraform

# Random Notes

## Terraform

Hashicorp does not provide arm64 packages for Terraform in their apt repo for
some reason, so we fall back to installing from a zip file.
