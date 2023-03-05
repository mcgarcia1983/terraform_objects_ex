#two regions with 2 vm instances, central1 region has 2 vms, west1 region has 1 vm
#west1 region is used as failover
#once we have created the vms we will create instance groups per region
variable "regions_vms" {
    type = list(object({
        region=string
        list_vms=list(object({
            name=string
            machine_type=string
        }))
    }
    )
    )
    default = [ 
      {
      list_vms = [ {
        machine_type = "e2-micro"
        name = "vm1"
      },
      {
        machine_type = "e2-micro"
        name = "vm2"
      }      
       ]
      region = "us-central1-a"
      },
      {
      list_vms = [ {
        machine_type = "e2-micro"
        name = "vm1"
      } ]
      region = "us-west1-a"
      }      
    ]

}