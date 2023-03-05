terraform {
  backend "local" {
    path = "terraform_state_dir/terraform.tfstate"
  }
}
