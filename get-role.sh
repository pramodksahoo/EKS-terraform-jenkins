aws configure set aws_access_key_id $TF_VAR_access_key
aws configure set aws_secret_access_key $TF_VAR_secret_key
aws configure set aws_session_token $TF_VAR_aws_session_token

oidcrolearn=$(aws iam list-roles --query "Roles[?RoleName=='${TF_VAR_eks_cluster_name}_oidc_role'].Arn" --output text  2>&1)

echo "cluster - oidc role arn $oidcrolearn"
echo "rolearn: $oidcrolearn"  >> ./vars.yaml
        
