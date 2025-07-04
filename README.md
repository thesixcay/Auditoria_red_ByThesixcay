# 🛡️ Auditoría de Red - ByThesixcay

Este proyecto contiene un script en Bash para realizar auditorías básicas de red en Parrot OS o Kali Linux.

## 🚀 Características
- Escaneo de red y puertos con `nmap`
- Detección de sistemas operativos
- Análisis de servidores web con `nikto`
- Recolección de información DNS
- Descubrimiento de dispositivos conectados con `arp-scan`

## 📦 Instrucciones

1. Dar permisos de ejecución:
```bash
chmod +x auditoria_red_intuitiva.sh
```

2. Ejecutar como root:
```bash
sudo ./auditoria_red_intuitiva.sh
```

## ✅ Requisitos
```bash
sudo apt install nmap nikto dnsutils whois arp-scan -y
```

## 📂 Carpeta de resultados
Los resultados se guardan automáticamente en carpetas por fecha.

---

Creado por **ByThesixcay**
