#!/bin/bash

# Validar entrada de email
validate_email() {
    if [[ $1 =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$ ]]; then
        return 0
    else
        return 1
    fi
}

# Validar servidor (solo verifica si no está vacío)
validate_server() {
    if [[ -z "$1" ]]; then
        return 1
    else
        return 0
    fi
}

# Función para crear archivo PRF para Outlook
create_outlook_prf() {
    read -p "Ingrese el nombre de su perfil de Outlook: " profile_name
    read -p "Ingrese su nombre de usuario: " user_name
    while true; do
        read -p "Ingrese su servidor IMAP: " imap_server
        validate_server "$imap_server" && break
        echo "Error: Servidor IMAP inválido."
    done
    while true; do
        read -p "Ingrese su servidor SMTP: " smtp_server
        validate_server "$smtp_server" && break
        echo "Error: Servidor SMTP inválido."
    done
    while true; do
        read -p "Ingrese su dirección de correo electrónico: " email_address
        validate_email "$email_address" && break
        echo "Error: Dirección de correo electrónico inválida."
    done

    # Crear archivo PRF
    cat <<EOF > ${profile_name}.prf
[General]
Custom=1
ProfileName=${profile_name}

[Service1]
OverwriteExistingService=Yes
UniqueService=Yes
MailboxName=${user_name}
HomeServer=${imap_server}

[Service2]
OverwriteExistingService=Yes
UniqueService=Yes
AccountName=${email_address}
SMTPAddress=${email_address}
ConnectionType=IMAP
IMAPServer=${imap_server}
SMTPServer=${smtp_server}
UserName=${email_address}
EOF

    echo "Archivo PRF para Outlook creado: ${profile_name}.prf"
}

# Función para crear archivo CFG para Thunderbird
create_thunderbird_cfg() {
    read -p "Ingrese su nombre completo: " full_name
    while true; do
        read -p "Ingrese su dirección de correo electrónico: " email_address
        validate_email "$email_address" && break
        echo "Error: Dirección de correo electrónico inválida."
    done
    read -p "Ingrese su organización (opcional): " organization
    while true; do
        read -p "Ingrese su servidor IMAP: " imap_server
        validate_server "$imap_server" && break
        echo "Error: Servidor IMAP inválido."
    done
    while true; do
        read -p "Ingrese su servidor SMTP: " smtp_server
        validate_server "$smtp_server" && break
        echo "Error: Servidor SMTP inválido."
    done

    # Crear archivo CFG
    cat <<EOF > thunderbird_${email_address}.cfg
lockPref("mail.identity.id1.fullName", "${full_name}");
lockPref("mail.identity.id1.useremail", "${email_address}");
lockPref("mail.identity.id1.organization", "${organization}");
lockPref("mail.server.server1.hostname", "${imap_server}");
lockPref("mail.server.server1.type", "imap");
lockPref("mail.server.server1.userName", "${email_address}");
lockPref("mail.smtpserver.smtp1.hostname", "${smtp_server}");
lockPref("mail.smtpserver.smtp1.username", "${email_address}");
EOF

    echo "Archivo CFG para Thunderbird creado: thunderbird_${email_address}.cfg"
}

# Menú principal
while true; do
    echo "Seleccione el tipo de cliente de correo:"
    echo "1) Outlook"
    echo "2) Thunderbird"
    echo "3) Salir"
    read -p "Opción: " client_option

    case $client_option in
        1) create_outlook_prf ;;
        2) create_thunderbird_cfg ;;
        3) exit ;;
        *) echo "Opción no válida. Intente de nuevo." ;;
    esac
done
