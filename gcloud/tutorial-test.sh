source ./tutorial-vars.sh

cat <<EOT
------------------------------------------------------------------------------------
# This script will run a series of tests to verify if your deployment works correctly.
# With each test you will see information about the expected output - verify if it's
# matching what is returned by the test commands.
------------------------------------------------------------------------------------

EOT

EIP_MGMT=$(gcloud compute addresses describe fgt-mgmt-eip-$ZONE1_LABEL --region=$REGION --format="get(address)")
EIP_ELB=$(gcloud compute addresses describe fgtelb-serv1-eip-$REGION_LABEL --region=$REGION --format="get(address)")

echo "-----------------------------------------------------------"
echo "##  TEST: FGT HA clustering and licensing"
echo "##  Expected output: primary and secondary reported with proper hostnames and non-empty serial numbers"
ssh admin@$EIP_MGMT "get sys ha status" | grep fgt-vm

echo "-----------------------------------------------------------"
echo "##  TEST: ELB health"
echo "##  Expected output: one healthy, one unhealthy backend"
gcloud compute backend-services get-health fgtelb-bes-$REGION_LABEL --region=$REGION --format=json | jq ".[].status.healthStatus[] | {ipAddress,healthState}"

echo "-----------------------------------------------------------"
echo "##  TEST: ILB trusted health"
echo "##  Expected output: one healthy, one unhealthy backend"
gcloud compute backend-services get-health fgtilb-int-bes-$REGION_LABEL --region=$REGION --format=json | jq ".[].status.healthStatus[] | {ipAddress,healthState}"

echo "-----------------------------------------------------------"
echo "##  TEST: peering routes for wrkld-tier1"
echo "##  Expected output: STATIC_PEERING_ROUTE to 0.0.0.0 is listed as accepted"
gcloud compute networks peerings list-routes wrkld-peer-tier1-to-hub --network=wrkld-tier1 --region=$REGION --direction=INCOMING

echo "-----------------------------------------------------------"
echo "##  TEST: peering routes for wrkld-tier2"
echo "##  Expected output: STATIC_PEERING_ROUTE to 0.0.0.0 is listed as accepted"
gcloud compute networks peerings list-routes wrkld-peer-tier2-to-hub --network=wrkld-tier2 --region=$REGION --direction=INCOMING

echo "-----------------------------------------------------------"
echo "##  TEST: website working"
echo "##  Expected output: HTTP 200 OK headers from nginx server"
curl -I http://$EIP_ELB

echo "-----------------------------------------------------------"
echo "##  TEST: website protected"
echo "##  Expected output: information about blocked access to EICAR_TEST_FILE virus"
curl http://$EIP_ELB/eicar.com | tail -20 | grep -A1 "Security Alert"


cat <<EOT

========================================
# Next step:
# - open http://$EIP_ELB to open protected web page
# - open https://$EIP_MGMT to explore your FortiGate
# - run tutorial-delete.sh to clean up
EOT
