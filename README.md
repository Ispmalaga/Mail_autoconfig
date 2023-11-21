# Mail_autoconfig
Script de ayuda para crear archivos para Thunderbird o Outlook, para autoconfigurar las cuentas de corrreo

Para thunderbird
Ubicar el Archivo en el Directorio Adecuado:

Debes colocar el archivo .cfg en el directorio raíz de tu instalación de Thunderbird o en el directorio de tu perfil de Thunderbird. La ubicación del directorio de tu perfil de Thunderbird varía según el sistema operativo:
En Windows, suele estar en C:\Users\[TuNombreDeUsuario]\AppData\Roaming\Thunderbird\Profiles\xxxxxxxx.default\.
En macOS, en ~/Library/Thunderbird/Profiles/xxxxxxxx.default/.
En Linux, en ~/.thunderbird/xxxxxxxx.default/.
Modificar el Archivo prefs.js (opcional):

Si Thunderbird ya está instalado y configurado, es posible que necesites agregar una línea al archivo prefs.js en tu directorio de perfil para que Thunderbird lea el archivo .cfg.
Agrega la siguiente línea al final de prefs.js (asegúrate de hacer esto mientras Thunderbird no esté ejecutándose):
arduino
Copy code
pref("general.config.filename", "nombre_del_archivo.cfg");
Reemplaza nombre_del_archivo.cfg con el nombre de tu archivo .cfg.
Ejecutar Thunderbird:

Cuando inicies Thunderbird, debería leer automáticamente el archivo .cfg y configurar tu cuenta según las especificaciones del archivo.
