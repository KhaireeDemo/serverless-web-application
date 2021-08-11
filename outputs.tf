output "api_base_url" {
  description = "Base URL for API Gateway stage."

  value = module.lambda_with_api_gw_module.api_base_url
}