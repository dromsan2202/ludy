
#!/bin/bash

# =======================
# LUDY - Fingerprinting Client
# =======================

# Colores básicos
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

# Colores intensos (brillantes)
IBLACK='\033[0;90m'
IRED='\033[0;91m'
IGREEN='\033[0;92m'
IYELLOW='\033[0;93m'
IBLUE='\033[0;94m'
IPURPLE='\033[0;95m'
ICYAN='\033[0;96m'
IWHITE='\033[0;97m'

# Colores de fondo
BG_BLACK='\033[40m'
BG_RED='\033[41m'
BG_GREEN='\033[42m'
BG_YELLOW='\033[43m'
BG_BLUE='\033[44m'
BG_PURPLE='\033[45m'
BG_CYAN='\033[46m'
BG_WHITE='\033[47m'

# Reset
NC='\033[0m' # No Color

# ----------------------
# Verificar e instalar paquetes si faltan
# ----------------------

echo -e "${IBLUE}############################Bienvenido a Ludy!###############################${NC}"


echo -e "${BG_IBLUE}${PURPLE}"
cat << "EOF"
LLLLLLLLLLL            UUUUUUUU     UUUUUUUUDDDDDDDDDDDDD       YYYYYYY       YYYYYYY     
L:::::::::L            U::::::U     U::::::UD::::::::::::DDD    Y:::::Y       Y:::::Y     
L:::::::::L            U::::::U     U::::::UD:::::::::::::::DD  Y:::::Y       Y:::::Y     
LL:::::::LL            UU:::::U     U:::::UUDDD:::::DDDDD:::::D Y::::::Y     Y::::::Y     
  L:::::L               U:::::U     U:::::U   D:::::D    D:::::DYYY:::::Y   Y:::::YYY     
  L:::::L               U:::::D     D:::::U   D:::::D     D:::::D  Y:::::Y Y:::::Y        
  L:::::L               U:::::D     D:::::U   D:::::D     D:::::D   Y:::::Y:::::Y         
  L:::::L               U:::::D     D:::::U   D:::::D     D:::::D    Y:::::::::Y          
  L:::::L               U:::::D     D:::::U   D:::::D     D:::::D     Y:::::::Y           
  L:::::L               U:::::D     D:::::U   D:::::D     D:::::D      Y:::::Y            
  L:::::L               U:::::D     D:::::U   D:::::D     D:::::D      Y:::::Y            
  L:::::L         LLLLLLU::::::U   U::::::U   D:::::D    D:::::D       Y:::::Y            
LL:::::::LLLLLLLLL:::::LU:::::::UUU:::::::U DDD:::::DDDDD:::::D        Y:::::Y            
L::::::::::::::::::::::L UU:::::::::::::UU  D:::::::::::::::DD      YYYY:::::YYYY         
L::::::::::::::::::::::L   UU:::::::::UU    D::::::::::::DDD        Y:::::::::::Y         
LLLLLLLLLLLLLLLLLLLLLLLL     UUUUUUUUU      DDDDDDDDDDDDD           YYYYYYYYYYYYY         
EOF
echo -e "${NC}"  # Reset de color  




check_and_install() {
    local pkg="$1"
    local cmd="$2"

    if ! command -v "$cmd" &>/dev/null; then
        echo -e "${RED}[!] $pkg no está instalado.${NC}"
        read -p "¿Deseas instalar $pkg? [s/N]: " respuesta

        if [[ "$respuesta" =~ ^[sS]$ ]]; then
            echo -e "${GREEN}[*] Instalando $pkg...${NC}"
            sudo apt update && sudo apt install -y "$pkg"
        else
            echo -e "${RED}[-] $pkg es requerido. Saliendo...${NC}"
            exit 
        fi
    else
        echo -e "${GREEN}[✓] $pkg ya está instalado.${NC}"
    fi
}

# ----------------------
# Verifica si rockyou.txt está en el directorio actual
# ----------------------
check_rockyou() {
    if [[ ! -f "rockyou.txt" ]]; then
        echo -e "${RED}[!] El diccionario rockyou.txt no está presente.${NC}"
        read -p "¿Deseas descargarlo? [s/N]: " respuesta

            if [ "$respuesta" = "s" ] || [ "$respuesta" = "S" ]; then
            echo -e "${GREEN}[*] Descargando rockyou.txt...${NC}"
            curl -L -o rockyou.txt https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt
        else
            echo -e "${RED}[-] rockyou.txt es requerido. Saliendo...${NC}"
            exit 
        fi
    else
        echo -e "${GREEN}[✓] rockyou.txt ya está presente.${NC}"
    fi
}
##########################

fingerprinting_ip_dominio() {

        echo -e "${IRED}"
        cat << 'EOF'
           ___    ___    _  _     ___     ___     ___      ___    ___     ___    _  _    _____    ___    _  _     ___   
          | __|  |_ _|  | \| |   / __|   | __|   | _ \    | _ \  | _ \   |_ _|  | \| |  |_   _|  |_ _|  | \| |   / __|  
          | _|    | |   | .` |  | (_ |   | _|    |   /    |  _/  |   /    | |   | .` |    | |     | |   | .` |  | (_ |  
         _|_|_   |___|  |_|\_|   \___|   |___|   |_|_\   _|_|_   |_|_\   |___|  |_|\_|   _|_|_   |___|  |_|\_|   \___|  
        _| """ |_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_| """ |_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""| 
        "`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-' 

EOF
        echo -e "${NC}"
        echo -e "${GREEN}[+] Fingerprinting de IP/dominio...${NC}"
        
        echo -e "${YELLOW}Seleccione una opción:${NC}"
        echo "1. Escaneo general con nmap -A"
        echo "2. Escaneo DNS con dnsenum"
        echo "3. Identificación de servidor web con nmap -sV"
        echo "4. Identificación de CMS con whatweb"
        echo "5. Detección de vulnerabilidades con nikto"
        read -p "Opción: " subopcion
        
        read -p "Introduzca la dirección que desea escanear: " direccion
        
                case $subopcion in
                    1)
                        echo -e "${GREEN}[+] Ejecutando: nmap -A $direccion${NC}"
                        nmap -A "$direccion"
                        ;;
                    2)
                        echo -e "${GREEN}[+] Ejecutando: dnsenum --enum --noreverse $direccion${NC}"
                        dnsenum --enum --noreverse $direccion
                        ;;
                    3)
                        echo -e "${GREEN}[+] Ejecutando: nmap -sV $direccion${NC}"
                        nmap -sV "$direccion"
                        ;;
                    4)
                        echo -e "${GREEN}[+] Ejecutando: whatweb -v $direccion${NC}"
                        whatweb -v "$direccion"
                        ;;
                    5)
                        echo -e "${GREEN}[+] Ejecutando: nikto -h $direccion${NC}"
                        nikto -h "$direccion"
                        ;;
                    *)
                        echo -e "${RED}[!] Opción inválida.${NC}"
                        exit
                        ;;
                esac

}





# ----------------------
# Menú principal
# ----------------------
menu_ludy() {
    clear
    echo -e "${GREEN}|-----------------------------[BIENVENIDO A LUDY]----------------------------------------|${NC}"
    echo "|                                                                                      |"
    echo "|        ¿Qué le gustaría realizar? Pulse el número de la opción que quiera            |"
    echo "|                                                                                      |"
    echo "|    1-----> FINGERPRINTING RED LOCAL                                                  |"
    echo "|    2-----> FINGERPRINTING IP / DOMINIO                                               |"
    echo "|    3-----> ATAQUE SSH                                                                |"
    echo "|    4-----> BASE DE DATOS LOCAL                                                       |"
    echo "|    5-----> SALIR                                                                     |"
    echo "|--------------------------------------------------------------------------------------|"

    read -p "Seleccione una opción [1-5]: " opcion
    case "$opcion" in
        1)
        echo -e "${CYAN}"
        cat << EOF
         ____  ___   ___    __    _  _  ____  _____    __    _____  ___    __    __   
        ( ___)/ __) / __)  /__\  ( \( )( ___)(  _  )  (  )  (  _  )/ __)  /__\  (  )  
         )__) \__ \( (__  /(__)\  )  (  )__)  )(_)(    )(__  )(_)(( (__  /(__)\  )(__ 
        (____)(___/ \___)(__)(__)(_)\_)(____)(_____)  (____)(_____)\___)(__)(__)(____)
EOF
        echo -e "${NC}"

            echo -e "${GREEN}[+] Explorando red local...${NC}"
            IP=$(ifconfig | grep -oP '(?<=inet\s)([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)'| head -n 1)
            NET=${IP%.*}.0/24
            echo "Red: $NET"
            nmap -PR -sn $NET
            ;;
        2) 
        fingerprinting_ip_dominio ;;

        3)

            echo -e "${YELLOW}"
            cat << "EOF"
                ___ _________  ____  __  ______  __________ __  
               / _ /_  __/ _ |/ __ \/ / / / __/ / __/ __/ // /  
              / __ |/ / / __ / /_/ / /_/ / _/  _\ \_\ \/ _  /   
             /_/ |_/_/ /_/ |_\___\_\____/___/ /___/___/_//_/    
EOF
            echo -e "${NC}" 
        
            echo -e "${GREEN}[+] Preparando ataque SSH...${NC}"
            read -p "Introduce nombre de usuario: " nombreusuario
            read -p "Introduce IP del objetivo: " ipusuario
            echo -e "${GREEN}[+] Ejecutando ataque SSH...${NC}"
            hydra -l "$nombreusuario" -P "${HOME}/rockyou.txt" ssh://"$ipusuario" -f -V
            ;;
        4)
            echo -e "${GREEN}[+] Creando base de datos...${NC}"
            IP=$(ifconfig | grep -oP '(?<=inet\s)([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)'| head -n 1)
            NET=${IP%.*}.0/24
            echo "Red: $NET" 
            nmap -PR -sn $NET > salida.txt
            python3 creador_db.py --archivo salida.txt --red $NET

            ;;
        5)
            echo -e "${RED}Saliendo...${NC}"
            exit 
            ;;
        
        *)
            echo -e "${RED}[!] Opción inválida.${NC}"
            exit
            ;;
            
    esac
}

# ----------------------
# Función principal
# ----------------------
main() {
    echo -e "${GREEN}Bienvenido a Ludy - Fingerprinting Cliente${NC}"

    # Verificar herramientas necesarias
    check_and_install "nmap" "nmap"
    check_and_install "nikto" "nikto"
    check_and_install "net-tools" "ifconfig"
    check_and_install "hydra" "hydra"
    check_and_install "whatweb" "whatweb"
    check_and_install "sqlite3" "sqlite3"
    check_and_install "python3" "python3"
    check_rockyou

    echo -e "${GREEN}✔ Todas las dependencias están listas.${NC}"
     

    # Mostrar menú
    menu_ludy
}

main "$@"


