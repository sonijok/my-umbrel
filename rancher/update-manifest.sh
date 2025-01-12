#!/bin/sh

# Caminho para o arquivo de senha gerado pelo Rancher
PASSWORD_FILE="/var/lib/rancher/bootstrap-password"

# Caminho para o manifesto
MANIFEST_PATH="$(dirname "$0")/manifest.yaml"

# Capturar a senha gerada pelo Rancher
if [ -f "$PASSWORD_FILE" ]; then
  PASSWORD=$(cat "$PASSWORD_FILE")
  echo "Senha capturada: $PASSWORD"
else
  echo "Erro: Arquivo de senha nao encontrado em $PASSWORD_FILE."
  exit 1
fi

# Verificar se a senha não está vazia
if [ -z "$PASSWORD" ]; then
  echo "Erro: A senha capturada esta vazia."
  exit 1
fi

# Verificar se o manifesto existe
if [ ! -f "$MANIFEST_PATH" ]; then
  echo "Erro: Arquivo de manifesto nao encontrado em $MANIFEST_PATH."
  exit 1
fi

# Criar backup do manifesto
cp "$MANIFEST_PATH" "${MANIFEST_PATH}.bak"

# Atualizar o manifesto com a senha capturada
sed -i "s/defaultPassword:.*/defaultPassword: \"$PASSWORD\"/" "$MANIFEST_PATH"

echo "Manifesto atualizado com sucesso!"
