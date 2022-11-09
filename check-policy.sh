aws configure set aws_access_key_id $TF_VAR_access_key
aws configure set aws_secret_access_key $TF_VAR_secret_key
aws configure set aws_session_token $TF_VAR_aws_session_token

#policystatus=$(aws iam get-policy --policy-arn arn:aws:iam::119276831673:policy/policy-create  2>&1)
#policystatus=$(aws iam get-policy --policy-arn arn:aws:iam::119276831673:policy/AmazonEKSClusterAutoscalerPolicy  2>&1)
#var=null
#echo "${policystatus}"  
#if echo "${policystatus}"  | grep -q 'not found'
#then
#    echo "policy doesnt exists"
#    var="create"
#else
#    echo "policy exist"
#    var="nocreate"
#fi

#echo "policy-count = \"$var\"" >> terraform.tfvars


# policystatus=$(aws iam list-policies --query 'Policies[?PolicyName==`AmazonEKSClusterAutoscalerPolicy`].Arn' --output text  2>&1)
policystatus=$(aws iam list-policies --query "Policies[?PolicyName=='$TF_VAR_EKS_ClusterAutoscalarPolicyName'].Arn" --output text  2>&1)
echo "${policystatus}"
var=null
# if echo "${policystatus}"  | grep -q 'AmazonEKSClusterAutoscalerPolicy'
if echo "${policystatus}"  | grep $TF_VAR_EKS_ClusterAutoscalarPolicyName
then
    echo "policy exists"
    var="nocreate"
    echo $var
else
    echo "policy doesn't exist"
    var="create"
    echo $var
fi

echo "policy-count = \"$var\"" >> terraform.tfvars

