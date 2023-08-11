# create an nework list

# $ export AKAMAI_CLIENT_SECRET="your_secret"
# $ export AKAMAI_HOST="your_host"
# $ export AKAMAI_ACCESS_TOKEN="your_access_token"
# $ export AKAMAI_CLIENT_TOKEN="your_client_token"
provider "akamai" {
    edgerc         = "~/.edgerc"
    config_section = "betajam"
}

# just use group_name to lookup our contract_id and group_id
# this will simplify our variables file as this contains contract and group id
# use "akamai property groups list" to find all your groups
data "akamai_contract" "contract" {
  group_name = var.group_name
}

# create or replace the network list
resource "akamai_networklist_network_list" "network_list" {
  name = "TF_TestNetworkList"
  type = "IP"
  description = "Network list created by TF"
  list = var.network_list
  mode = "REPLACE"

  # optional group and contract_id 
  /* 
  contract_id = data.akamai_contract.contract.id
  group_id = trim(data.akamai_contract.contract.group_id, "grp_") 
  */
  
}

# activate network list on staging
resource "akamai_networklist_activations" "activation" {
    network_list_id     = resource.akamai_networklist_network_list.network_list.uniqueid
    sync_point          = resource.akamai_networklist_network_list.network_list.sync_point
    network             = "STAGING"
    notes               = "TF activated network list"
    notification_emails = ["user@example.com"]
}