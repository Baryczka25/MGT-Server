#!/bin/bash
# =====================================================
# LIMPEZA AUTOMÁTICA DE MODS CLIENT-ONLY (ENXADAHOST)
# =====================================================

# Caminhos
MODS_DIR="./mods"
CLIENT_DIR="./mods_cliente"

# Cria pasta de destino se não existir
mkdir -p "$CLIENT_DIR"

echo "🧹 Verificando mods client-only..."

# Lista de padrões de mods que NÃO devem estar no servidor
CLIENT_ONLY_MODS=(
  "iris"
  "sodium"
  "oculus"
  "rubidium"
  "watermedia"
  "waterframes"
  "watervision"
  "lambdynamiclights"
  "lambdynlights"
  "expandability"
  "embeddium"
  "optifine"
  "forgified-fabric-api"
  "entityculling"
  "reeses-sodium-options"
  "ferritecore"
)

# Procura e move
for pattern in "${CLIENT_ONLY_MODS[@]}"; do
  found=$(find "$MODS_DIR" -maxdepth 1 -type f -iname "*${pattern}*.jar")
  if [ -n "$found" ]; then
    for file in $found; do
      echo "➡️  Movendo $(basename "$file") para $CLIENT_DIR"
      mv "$file" "$CLIENT_DIR/"
    done
  fi
done

echo "✅ Limpeza concluída. Iniciando o servidor..."

# Comando padrão de inicialização (ajuste conforme seu .jar e memória)
java -Duser.timezone=America/Sao_Paulo -Xms128M -Xmx5120M -Dterminal.jline=false -Dterminal.ansi=true -jar neoforge-1.21.1-21.1.213.jar nogui
