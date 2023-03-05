locals {
  #we need to extract the values for vm, machine_type from nested list(object), then we need
  #to add region/zone from parent object

  #first step iterate the values in regions_vms
  list_region_vms=[for obj in var.regions_vms: obj]
  
  #second step is to extract the region and 
  #list_vm_names 
  list_vm_names=[ for obj in var.regions_vms : [
    for vms in obj.list_vms : [
      {#required to define a new object
      region = obj.region,
      vm_name = vms.name
      }
    ]
    
    ]
  ]

  #second step is to extract the region and 
  #list_vm_names 
  vms_flatten=flatten([
    for obj in var.regions_vms : [
      for vms in obj.list_vms : [
        {#required to define a new object
        region = obj.region,
        vm_name = vms.name
        }
        ]
    
    ]
  ])
  
   #toset([for obj in var.vm_object: obj.name_prefix])
}

# resource "google_compute_instance" "vm" {
#   for_each = local.list_vm_names
#   name         = each.value
#   machine_type = "e2-micro"
#   zone         = "us-east1-b"

#   tags = ["foo", "bar"]

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-11"
#       labels = {
#         my_label = "value"
#       }
#     }
#   }

#   // Local SSD disk
#   #scratch_disk {
#     #interface = "SCSI"
#   #}

#   network_interface {
#     network = "net-us-east"
#     subnetwork = "net-sub-us-east"
#     access_config {
#       // Ephemeral public IP
#     }
#   }

#   metadata = {
#     foo = "bar"
#   }

#   metadata_startup_script = "echo hi > /test.txt"


# }

output "output1" {
  value=local.list_region_vms
}

output "output2" {
  value=local.list_vm_names
}

output "output3" {
  value=local.vms_flatten
}
