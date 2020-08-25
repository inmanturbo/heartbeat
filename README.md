# heartbeat
shell scripts for managing start-up and shutdown of hyper-converged node with onboard virtualized nas for vm backing

## Usage
KVM doesn't have an easy built in way way to ensure your storage vm is up first and down last, such as start and shutdown order options in ESXI. 
This service will autostart vm's marked for autostart only after the virtualized nas has started and the storage pool has become available.
And will make sure they go down before the nas and its pool, such as in the case of a UPS triggered shutdown.

### Caveat:
This service is only intended to protect data in the case of an outage, and reduce startup errors. It assumes the vms have no application level dependencies.
However you can easily add to the scripts if you have some other startup shutdown ordering that needs to be done, such as starting a database before a webserver, etc.

## Installation
clone the repo, cd into repo and run 

```
make install
```

