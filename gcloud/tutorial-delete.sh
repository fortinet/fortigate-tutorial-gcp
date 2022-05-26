source ./tutorial-vars.sh

gcloud compute instances delete wrkld-tier2-web --zone=$ZONE1 -q
gcloud compute instances delete wrkld-tier1-proxy --zone=$ZONE1 -q

gcloud compute firewall-rules delete wrkld-fw-tier1-allowall -q
gcloud compute firewall-rules delete wrkld-fw-tier2-allowall -q

gcloud beta compute forwarding-rules delete fgtelb-serv1-fwd-$REGION_LABEL-l3 --region=$REGION -q
gcloud compute addresses delete fgtelb-serv1-eip-$REGION_LABEL --region=$REGION -q
gcloud compute backend-services delete fgtelb-bes-$REGION_LABEL --region=$REGION -q

gcloud compute networks peerings delete wrkld-peer-hub-to-tier1 --network=int-vpc-$REGION_LABEL -q
gcloud compute networks peerings delete wrkld-peer-tier1-to-hub --network=wrkld-tier1 -q
gcloud compute networks peerings delete wrkld-peer-hub-to-tier2 --network=int-vpc-$REGION_LABEL -q
gcloud compute networks peerings delete wrkld-peer-tier2-to-hub --network=wrkld-tier2 -q

gcloud compute networks subnets delete wrkld-sb-tier1-$REGION_LABEL --region=$REGION -q
gcloud compute networks subnets delete wrkld-sb-tier2-$REGION_LABEL --region=$REGION -q

gcloud compute networks delete wrkld-tier1 -q
gcloud compute networks delete wrkld-tier2 -q

gcloud compute routes delete rt-int-$REGION_LABEL-default-via-fgt -q

gcloud compute forwarding-rules delete fgtilb-int-fwd-$REGION_LABEL-tcp --region=$REGION -q
gcloud compute backend-services delete fgtilb-int-bes-$REGION_LABEL --region=$REGION -q


gcloud compute health-checks delete fgt-hcheck-tcp8008 --region=$REGION  -q

gcloud compute instances delete fgt-vm-$ZONE1_LABEL --zone=$ZONE1 -q
gcloud compute instances delete fgt-vm-$ZONE2_LABEL --zone=$ZONE2 -q

gcloud compute instance-groups unmanaged delete fgt-umig-$ZONE1_LABEL --zone=$ZONE1 -q
gcloud compute instance-groups unmanaged delete fgt-umig-$ZONE2_LABEL --zone=$ZONE2 -q

gcloud compute addresses delete fgt-mgmt-eip-$ZONE1_LABEL --region=$REGION -q
gcloud compute addresses delete fgt-mgmt-eip-$ZONE2_LABEL --region=$REGION -q
gcloud compute addresses delete fgt-ip-int-$ZONE1_LABEL --region=$REGION -q
gcloud compute addresses delete fgt-ip-int-$ZONE2_LABEL --region=$REGION  -q
gcloud compute addresses delete fgtilb-ip-int-$REGION_LABEL --region=$REGION -q
gcloud compute addresses delete fgt-ip-ext-$ZONE1_LABEL --region=$REGION  -q
gcloud compute addresses delete fgt-ip-ext-$ZONE2_LABEL --region=$REGION  -q
gcloud compute addresses delete fgt-ip-hasync-$ZONE1_LABEL --region=$REGION  -q
gcloud compute addresses delete fgt-ip-hasync-$ZONE2_LABEL --region=$REGION  -q

gcloud compute routers delete ext-nat-cr-$REGION_LABEL --region=$REGION -q

gcloud compute firewall-rules delete ext-to-fgt-fw-allowall -q
gcloud compute firewall-rules delete int-to-fgt-fw-allowall -q
gcloud compute firewall-rules delete fgt-hasync-fw-allowall -q
gcloud compute firewall-rules delete fgt-mgmt-fw-allow-admin -q

gcloud compute networks subnets delete ext-sb-$REGION_LABEL --region=$REGION -q
gcloud compute networks subnets delete int-sb-$REGION_LABEL --region=$REGION -q
gcloud compute networks subnets delete fgt-hasync-sb-$REGION_LABEL --region=$REGION -q
gcloud compute networks subnets delete fgt-mgmt-sb-$REGION_LABEL --region=$REGION -q

gcloud compute networks delete ext-vpc-global -q
gcloud compute networks delete int-vpc-$REGION_LABEL -q
gcloud compute networks delete fgt-hasync-vpc -q
gcloud compute networks delete fgt-mgmt-vpc -q
