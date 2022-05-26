#### FortiGate Deployment Tutorial for Google Cloud
# Google Cloud CLI deployment

This directory contains gcloud (Google Cloud CLI) scripts to deploy a reference
architecture consisting of an HA FortiGate cluster and sample workload servers.
The deployment created using tutorial-* scripts matches the one described in
the FortiGate on Google Cloud tutorial published together by Google and Fortinet.

## Before you begin
1. create or select your GCP project
1. enable billing for your project
1. enable Compute API
1. obtain and register your FortiGate VM licenses if you plan to use BYOL licensing. Upload the .lic files to your working directory as lic1.lic and lic2.lic

## How to use the scripts
Tutorial script package consists of 4 shell script files:

**tutorial-vars.sh** - defines variables like the region, zones and CIDRs to be used. All the other scripts will use it.

**tutorial-create.sh** - this is the main script which creates all the compute resources, a custom role and a service account. It will take about 15 minutes to complete. Note that this script requires presence of lic1.lic and lic2.lic files and it will fail if those files are note present. Do modify it if you plan to use PAYG licenses (instructions in comments around line 345)

**tutorial-test.sh** - you can optionally use this script to verify if your deployment completed successfully

**tutorial-delete.sh** - use this script to delete all the compute resources created by tutorial-create.sh. Note that the custom role will NOT be deleted.
