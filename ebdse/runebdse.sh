#!/bin/bash

set -x

# graph
graphname=workshop   # the name of your graph in datastax

#misc configurations for turning engine block
rate=10k
threads=64
host=node0       # you will want to set this as localhost (working locally) or node0 (in a cluster)
reads=100
#arg=-v

if [ $# -gt 0 ]; then
    echo $1
    host=$1
fi

# ### 1. CREATE THE GRAPH #####
/tmp/ebdse/ebdse run type=dsegraph yaml=driver tags=phase:create-graph cycles=1 host=$host nameofgraph=$graphname

# ### 2. DEVELOPMENT MODE #####
/tmp/ebdse/ebdse run type=dsegraph yaml=driver graphname=$graphname tags=phase:dev-mode cycles=1 host=$host

# ### 3. INSERT AIR ROUTES DATA#####
/tmp/ebdse/ebdse run type=dsegraph yaml=driver graphname=$graphname tags=phase:read-graph cycles=1 host=$host