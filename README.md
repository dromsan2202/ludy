# 🛡️ LUDY - Reconocimiento y Automatización de Escaneos de Seguridad

**Proyecto de Fin de Grado (FP Superior en Administración de Sistemas Informáticos en Red - ASIR)**  
Autor: Daniel Romero Sánchez  
Curso: 2024/2025  
Versión: 1.0  
Licencia: MIT

---

## 📌 Descripción

LUDY es una herramienta desarrollada en **Bash y Python** orientada al **análisis de seguridad en redes y sistemas** mediante técnicas de reconocimiento y escaneo. Se ejecuta desde terminal, con una interfaz de menú amigable, y permite combinar distintas herramientas de análisis para evaluar el estado de seguridad de una red local o remota.

El objetivo principal no es la explotación de vulnerabilidades, sino el **reconocimiento activo**, presentando los resultados de forma organizada y, en algunos casos, almacenándolos en una base de datos local con **SQLite**.

---

## ⚙️ Funcionalidades principales

- 📡 **Fingerprinting de red local** (IP, interfaces, hosts activos)
- 🌐 **Escaneo por IP o dominio**
  - Escaneo general con `nmap`
  - Identificación de CMS (`whatweb`)
  - Escaneo DNS (`dnsenum`)
  - Vulnerabilidades web (`nikto`)
- 🔐 **Ataques de fuerza bruta SSH** (mediante `hydra`)
- 🗂️ **Base de datos local** con resultados de escaneos (SQLite)
- 🎨 Personalización visual con ASCII art y colores diferenciados

---

## 🔧 Tecnologías y herramientas usadas

- Bash (núcleo del proyecto)
- Python (gestión e importación en SQLite)
- Nmap, Hydra, Nikto, Net-tools, Whatweb, Dnsenum
- SQLite3
- rockyou.txt como diccionario de contraseñas (descargado vía `curl`)
- patorjk.com (ASCII art)
- regexr.com (validación de expresiones regulares)

---

## 📸 Capturas de pantalla

[recomendable poner capturas de: menú principal, ejecución de escaneo, resultados de base de datos]

---

## 🚧 Posibles mejoras

- Menú accesible desde interfaz gráfica (con icono)
- Barra de progreso para tareas largas (como `nmap -A`)
- Navegación con flechas
- Configuración de rutas personalizadas para ficheros
- Incorporación de entornos vulnerables para pruebas ofensivas
- Implementación de modo sigiloso en ataques

---

## 📚 Bibliografía y recursos

- 0xWord – Pentesting con Kali Linux  
- 0xWord – Ethical Hacking  
- [https://patorjk.com/software/taag/](https://patorjk.com/software/taag/)  
- [https://regexr.com/](https://regexr.com/)  
- [NetworkChuck - YouTube](https://www.youtube.com/@NetworkChuck)  
- [NN Admin - YouTube](https://www.youtube.com/@NNAdmin)

---

## 🚀 Instalación rápida

```bash
git clone https://github.com/tuusuario/ludy.git
cd ludy
bash main.sh
