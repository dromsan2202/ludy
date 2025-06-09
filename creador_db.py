
import sqlite3
import re
import argparse

# Configurar argumentos
parser = argparse.ArgumentParser(description="Extraer hosts de una salida de Nmap y guardarlos en SQLite")
parser.add_argument("--archivo", required=True, help="Archivo de texto con la salida de Nmap")
parser.add_argument("--red", required=True, help="Dirección de red (ej: 192.168.1.0/24)")
args = parser.parse_args()

# Leer el archivo de salida de Nmap
with open(args.archivo, "r") as f:
    nmap_output = f.read()

# Crear el nombre de la base de datos
network_name = args.red
db_name = network_name.replace("/", "_") + ".db"

# Expresión regular para extraer hostnames e IPs
matches = re.findall(r'Nmap scan report for (.+?) \(([\d.]+)\)', nmap_output)
# También soporta casos sin hostname (solo IP)
matches += [(m.group(1), m.group(1)) for m in re.finditer(r'Nmap scan report for ([\d.]+)', nmap_output) if (m.group(1), m.group(1)) not in matches]

# Conexión a la base de datos
conn = sqlite3.connect(db_name)
cursor = conn.cursor()

# Crear tabla si no existe
cursor.execute('''
    CREATE TABLE IF NOT EXISTS hosts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        hostname TEXT,
        ip TEXT
    )
''')

# Insertar datos extraídos
for hostname, ip in matches:
    cursor.execute("INSERT INTO hosts (hostname, ip) VALUES (?, ?)", (hostname, ip))

conn.commit()
print(f"Datos insertados en la base de datos: {db_name}")

# Mostrar datos insertados
cursor.execute("SELECT * FROM hosts")
for row in cursor.fetchall():
    print(row)

conn.close() 