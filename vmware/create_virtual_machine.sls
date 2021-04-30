my-complete-example:
  provider: vmware
  clonefrom: $vm_clone
  cluster: $cluster_name
  datastore: $vm_datastore
  #resourcepool: Resources
  folder: vm
  num_cpus: 2
  memory: 8GB
  image: debian7_64Guest

  devices:
    scsi:
      SCSI controller 0:
        type: lsilogic_sas
    ide:
      IDE 0: {}
      IDE 1: {}
    disk:
      Hard disk 0:
        controller: 'SCSI controller 0'
        size: 20
        mode: 'independent_nonpersistent'

    network:
      Network adapter 0:
        name: 'VM Network'
        swith_type: standard
