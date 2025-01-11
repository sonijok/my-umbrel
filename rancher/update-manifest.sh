#!/bin/sh

# Caminho para o arquivo de senha gerado pelo Rancher
PASSWORD_FILE="/var/lib/rancher/bootstrap-password"

# Caminho para o manifesto
MANIFEST_PATH="./manifest.yaml"

# Capturar a senha gerada pelo Rancher
if [ -f "$PASSWORD_FILE" ]; then
  PASSWORD=$(cat "$PASSWORD_FILE")
  echo "Senha capturada: $PASSWORD"
else
  echo "Erro: Arquivo de senha não encontrado."
  exit 1
fi

# Atualizar o manifesto com a senha capturada
sed -i "s/defaultPassword:.*/defaultPassword: \"$PASSWORD\"/" "$MANIFEST_PATH"

echo "Manifesto atualizado com sucesso!"
