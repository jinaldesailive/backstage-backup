module "service_account" {
  source     = "terraform-google-modules/service-accounts/google"
  version    = "~> 4.2"
  project_id = var.project_id
  prefix     = "sa-cloud-run"
  names      = ["simple"]
}

module "cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "~> 0.11"

  service_name          = "ci-cloud-run"
  project_id            = var.project_id
  location              = "us-east4"
  image                 = "us-east4-docker.pkg.dev/cloudrun/container/hello"
  service_account_email = module.service_account.email
}