locals {
  resource_group_name = "workgrp"
  location = "Central India"
  virtual_network_name = "work-network"
  address_space = {
    staging = "10.0.0.0/16"
    Test = "10.1.0.0/16"
  }
}