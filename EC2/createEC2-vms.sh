#!/bin/bash

KEY_NAME="YOUR_KEY_PAIR_NAME"
KEY_PATH="/path/to/your/key.pem"
chmod 400 "$KEY_PATH"
AMI_ID="YOUR_AMI_ID"
INSTANCE_TYPE="t2.micro"
SECURITY_GROUP="YOUR_SECURITY_GROUP_ID"
PROFILE="YOUR_AWS_PROFILE"
VMS=("vm01" "vm02")

# Adiciona regra SSH se não existir
aws ec2 authorize-security-group-ingress \
    --group-id $SECURITY_GROUP \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0 \
    --profile $PROFILE 2>/dev/null

criar_vm() {
    local NOME_VM=$1
    echo "Criando VM: $NOME_VM"

    # Cria a instância e captura o ID
    INSTANCE_ID=$(aws ec2 run-instances \
        --image-id $AMI_ID \
        --count 1 \
        --instance-type $INSTANCE_TYPE \
        --key-name $KEY_NAME \
        --security-group-ids $SECURITY_GROUP \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$NOME_VM}]" \
        --associate-public-ip-address \
        --query 'Instances[0].InstanceId' \
        --output text \
        --profile $PROFILE)

    echo "Instância criada com ID: $INSTANCE_ID"

    # Pega o IP público
    PUBLIC_IP=$(aws ec2 describe-instances \
        --instance-ids $INSTANCE_ID \
        --query 'Reservations[0].Instances[0].PublicIpAddress' \
        --output text \
        --profile $PROFILE)

    echo "VM $NOME_VM está rodando. IP público: $PUBLIC_IP"

    # Espera porta SSH ficar disponível
    while ! nc -z $PUBLIC_IP 22; do
        echo "Aguardando SSH ficar disponível em $PUBLIC_IP..."
        sleep 5
    done

   # Comando para SSH aceitando o host
    echo 'Conecte via SSH em '"$NOME_VM"' - Comando: ssh -i "'"$KEY_PATH"'" -o StrictHostKeyChecking=no ubuntu@'"$PUBLIC_IP"
}

for nome in "${VMS[@]}"; do
    criar_vm $nome
done
