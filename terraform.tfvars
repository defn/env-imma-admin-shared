provider_region = "us-west-1"
bucket_remote_state = "imma-remote-state"
context_org = "imma"
context_env = "admin"

az_count = 2

nat_cidrs    = "172.16.0.64/28 172.16.0.80/28"
vpn_cidrs    = "172.16.0.96/28 172.16.0.112/28"
jump_cidrs   = "172.16.0.128/28 172.16.0.144/28"
consul_cidrs = "172.16.0.160/28 172.16.0.176/28"
