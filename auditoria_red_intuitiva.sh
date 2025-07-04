#!/bin/bash

# Colores
verde="\e[32m"
rojo="\e[31m"
azul="\e[34m"
amarillo="\e[33m"
normal="\e[0m"

# Banner
clear
echo -e "${verde}"
echo "╔══════════════════════════════════════════════╗"
echo "║        🔐 AUDITORÍA DE RED - ByThesixcay     ║"
echo "╚══════════════════════════════════════════════╝"
echo -e "${normal}"

# Comprobar si es root
if [[ $EUID -ne 0 ]]; then
   echo -e "${rojo}❌ Este script debe ejecutarse como root${normal}"
   exit 1
fi

# Carpeta para resultados
fecha=$(date +%F_%H-%M-%S)
carpeta="resultados_auditoria_$fecha"
mkdir -p "$carpeta"

# Funciones
escaneo_rapido() {
    echo -e "${azul}📡 Escaneo rápido con nmap...${normal}"
    read -p "🌐 Ingresa la red objetivo (ej. 192.168.1.0/24): " red
    nmap -sn "$red" -oN "$carpeta/escaneo_rapido.txt"
    echo -e "${verde}✅ Resultado guardado en $carpeta/escaneo_rapido.txt${normal}"
}

puertos_abiertos() {
    echo -e "${azul}🚪 Escaneo de puertos abiertos...${normal}"
    read -p "👉 Ingresa IP objetivo: " ip
    nmap -sS -T4 "$ip" -oN "$carpeta/puertos_abiertos.txt"
    echo -e "${verde}✅ Resultado guardado en $carpeta/puertos_abiertos.txt${normal}"
}

detectar_os() {
    echo -e "${azul}🧠 Detección de sistema operativo...${normal}"
    read -p "👉 Ingresa IP objetivo: " ip
    nmap -O "$ip" -oN "$carpeta/deteccion_os.txt"
    echo -e "${verde}✅ Resultado guardado en $carpeta/deteccion_os.txt${normal}"
}

analisis_web() {
    echo -e "${azul}🌐 Análisis de servidor web con Nikto...${normal}"
    read -p "👉 Ingresa la URL (http://IP): " url
    nikto -h "$url" -output "$carpeta/nikto_web.txt"
    echo -e "${verde}✅ Resultado guardado en $carpeta/nikto_web.txt${normal}"
}

info_dns() {
    echo -e "${azul}🔍 Recopilando información DNS...${normal}"
    read -p "👉 Ingresa el dominio: " dominio
    dig $dominio ANY > "$carpeta/dns_info.txt"
    whois $dominio >> "$carpeta/dns_info.txt"
    echo -e "${verde}✅ Resultado guardado en $carpeta/dns_info.txt${normal}"
}

dispositivos_red() {
    echo -e "${azul}📲 Buscando dispositivos conectados...${normal}"
    read -p "🌐 Ingresa la red (ej. 192.168.1.0/24): " red
    interfaz=$(ip route | grep default | awk '{print $5}' | head -n 1)
    arp-scan --interface="$interfaz" "$red" > "$carpeta/dispositivos_conectados.txt"
    echo -e "${verde}✅ Resultado guardado en $carpeta/dispositivos_conectados.txt${normal}"
}

# Menú principal
while true; do
    echo -e "\n${amarillo}🧭 MENÚ PRINCIPAL - Elige una opción:${normal}"
    echo "1️⃣  Escaneo rápido de red"
    echo "2️⃣  Escaneo de puertos abiertos"
    echo "3️⃣  Detección de sistema operativo"
    echo "4️⃣  Análisis de servidor web (Nikto)"
    echo "5️⃣  Información DNS"
    echo "6️⃣  Dispositivos conectados (arp-scan)"
    echo "7️⃣  Salir"
    read -p "👉 Opción [1-7]: " opcion

    case $opcion in
        1) escaneo_rapido ;;
        2) puertos_abiertos ;;
        3) detectar_os ;;
        4) analisis_web ;;
        5) info_dns ;;
        6) dispositivos_red ;;
        7) echo -e "${verde}👋 ¡Hasta la próxima! Resultados en $carpeta${normal}"; exit ;;
        *) echo -e "${rojo}❌ Opción inválida, intenta de nuevo.${normal}" ;;
    esac
done
