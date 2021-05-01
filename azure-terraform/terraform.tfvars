RG_NAME="MyRG"
VNET = [
  {
    vnet_name     = "MyVnet1"
    address_space = ["20.0.0.0/16"]
    subnets = [
      {
        name    = "Public"
        address = "20.0.10.0/24"
      },
      {
        name    = "Private"
        address = "20.0.20.0/24"
      }
    ]
  },
  {
    vnet_name     = "MyVnet2"
    address_space = ["10.0.0.0/16"]
    subnets = [
      {
        name    = "Public"
        address = "10.0.10.0/24"
      },
      {
        name    = "Private"
        address = "10.0.20.0/24"
      }
    ]
  }
]
ADMIN_USER="azureuser"
VM_SIZE="Standard_B1ls"
VM_NAME="MyVM"
PUB_IP_NAME="MyPubIP"
NSG_NAME="MyNSG"
PORTS = [
  {
    priority = "100"
    port = "22"
  },
  {
    priority = "110"
    port = "80"
  }
]
