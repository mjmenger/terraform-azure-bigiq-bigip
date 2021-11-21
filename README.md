this repository will use Terragrunt to orchestrate three Terraform directories

1. Network infrastructure
2. BIG-IQ within the network built in #1
3. an arbitrary number of BIG-IPs built in the network of #1 and configured by the BIG-IQ of #2

```bash
cd infrastructure
terragrunt apply
cd ../bigiq
terragrunt apply

# setup the license and license pool in the BIG-IQ

cd ../bigip
terragrunt apply