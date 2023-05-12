#!/bin/bash

# Reemplaza esto con la ruta a tu imagen de RAM de Linux
RAM_IMAGE="path/to/your/linux_ram_image"

# Reemplaza esto con el perfil apropiado para tu imagen de RAM de Linux
PROFILE="LinuxUbuntu1604x64"

# Comandos de Volatility
volatility_commands=(
  "linux_pslist"
  "linux_psaux"
  "linux_pstree"
  "linux_netstat"
  "linux_bash"
  "linux_lsmod"
  "linux_mount"
  "linux_find_file"
  "linux_proc_maps"
  "linux_dump_map"
)

# Ejecuta los comandos de Volatility
for cmd in "${volatility_commands[@]}"; do
  echo "Ejecutando: $cmd"
  volatility -f "$RAM_IMAGE" --profile="$PROFILE" "$cmd" > "output_$cmd.txt"
  echo "Resultado guardado en: output_$cmd.txt"
  echo ""
done

echo "Análisis de Volatility completado."




#!/bin/bash

# Reemplaza esto con la ruta a tu imagen de RAM de Linux
RAM_IMAGE="path/to/your/linux_ram_image"

# Reemplaza esto con el perfil apropiado para tu imagen de RAM de Linux
PROFILE="LinuxUbuntu1604x64"

# Comandos de Volatility
volatility_commands=(
  "linux_pslist"
  "linux_psaux"
  "linux_pstree"
  "linux_netstat"
  "linux_bash"
  "linux_lsmod"
  "linux_mount"
  "linux_find_file"
  "linux_proc_maps"
  "linux_dump_map"
)

# Ejecuta los comandos de Volatility
for cmd in "${volatility_commands[@]}"; do
  echo "Ejecutando: $cmd"
  volatility -f "$RAM_IMAGE" --profile="$PROFILE" "$cmd" > "output_$cmd.txt"
  echo "Resultado guardado en: output_$cmd.txt"
  echo ""
done

echo "Análisis de Volatility completado."




#!/bin/bash

# Reemplaza esto con la ruta a tu imagen de RAM de Linux
RAM_IMAGE="path/to/your/linux_ram_image"

# Reemplaza esto con la ruta a tu instalación de Volatility
VOLATILITY_PATH="path/to/volatility"

# Reemplaza esto con el perfil apropiado para tu imagen de RAM de Linux
PROFILE="LinuxUbuntu1604x64"

# Comprueba si la imagen de RAM y la ruta de Volatility existen
if [ ! -f "$RAM_IMAGE" ]; then
  echo "Error: No se encuentra la imagen de RAM en la ruta especificada."
  exit 1
fi

if [ ! -f "$VOLATILITY_PATH" ]; then
  echo "Error: No se encuentra Volatility en la ruta especificada."
  exit 1
fi

# Comandos de Volatility
volatility_commands=(
  "linux_pslist"
  "linux_psaux"
  "linux_pstree"
  "linux_netstat"
  "linux_bash"
  "linux_lsmod"
  "linux_mount"
  "linux_find_file"
  "linux_proc_maps"
  "linux_dump_map"
)

# Crea un directorio para guardar los resultados
mkdir -p volatility_results

# Ejecuta los comandos de Volatility
for cmd in "${volatility_commands[@]}"; do
  echo "Ejecutando: $cmd"
  $VOLATILITY_PATH -f "$RAM_IMAGE" --profile="$PROFILE" "$cmd" > "volatility_results/output_$cmd.txt"
  echo "Resultado guardado en: volatility_results/output_$cmd.txt"
  echo ""
done

echo "Análisis de Volatility completado."
