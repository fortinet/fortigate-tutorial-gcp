## Define CIDR ranges for all networks created in this deployment and save into
## variables for convenience.
CIDR_EXT=172.20.0.0/24          # untrusted network
CIDR_INT=172.20.1.0/24          # trusted network
CIDR_HASYNC=172.20.2.0/24       # FortiGate heartbeat network
CIDR_MGMT=172.20.3.0/24         # FortiGate management network (note, this can be merged with heartbeat for firmware 7.0+)
CIDR_WRKLD_TIER1=10.0.0.0/16    # sample workload frontend network
CIDR_WRKLD_TIER2=10.1.0.0/16    # sample workload backend network
WRKLD_PROXY_IP=10.0.0.5
WRKLD_WEB_IP=10.1.0.5

## Define region and zones for deployment and save into variables for convenience
REGION=europe-west1
ZONE1=europe-west1-b
ZONE2=europe-west1-c
### Some resource names will be labeled with region or zone name. Let's use their
### shortened names:
REGION_LABEL=$(echo $REGION | tr -d '-' | sed 's/europe/eu/' | sed 's/australia/au/' | sed 's/northamerica/na/' | sed 's/southamerica/sa/' )
ZONE1_LABEL=$REGION_LABEL-${ZONE1: -1}
ZONE2_LABEL=$REGION_LABEL-${ZONE2: -1}
