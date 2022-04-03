# Práctica CI/CD Francesc

## Consideraciones
- Se ha optado por hacer los deployments en S3 de AWS
- El método de autenticación con AWS se hará con variables de entorno
- Los Buckets de S3 se crearán con un sufijo de 4 letras aleatorias para evitar duplicidad de nombres 
- Se debe tener un usuario con plenos permisos de S3 en AWS con un Access Key creado

## Pipeline Local
### Requisitos 
Tener instalados Make y Terraform
Por comodidad se aconseja crear las siguientes variables de entorno, si se decide omitir este paso, se deberán incluir en el comando make
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- AWS_REGION

### Uso
Para realizar el deployment de Desarrollo se debe ejecutar el siguiente comando, estando situado en la carpeta del proyecto.

Con variables de entorno de AWS ya creadas:
```
make all
```

Sin variables de entorno de AWS ya creadas:
```
make all -e AWS_ACCESS_KEY_ID=<access_key> -e AWS_SECRET_ACCESS_KEY=<secret_key> -e AWS_REGION=<region>
```

## Pipeline en Jenkins
### Requisitos
Se deben crear las siguientes credenciales
AWS-Credentials:
- Usuario: Access Key de AWS
- Password: Secret Key de AWS

practica-ssh
- Añadir clave SSH asociada a un usuario de Github con permisos de lectura para este repositorio

ssh-jenkins
- Usuario: jenkins
- Password: jenkins

Crear un Cloud de Docker con una plantilla con los siguientes datos:
- Labels: terraform
- Docker Image: fblanco86/terraform-aws-agent
- Remote file system root: /home/jenkins
- Connect method: Connect with SSH (ssh-jenkins) sin verificación de host

### Job DSL
- Crear un Job informando el script del contenido del fichero job.dsl
- Construir el Job, esto creará 2 Pipelines:
  - Práctica Terraform: Se encarga del hacer el deployment de Desarrollo y de Producción si se confirma, si a los 10 minutos no se ha respondido se abortará automáticamente.
  - Práctica Check S3: Se encarga de comprobar cada 10 minutos si los Buckets en S3 que empiecen por "acme-storage" contienen más de 20 MiB, si es así se vaciarán automáticamente.

## Github Actions
### Requisitos
Crear 2 Secretos para Actions:
- AWS_ACCESS_KEY_ID: Access Key de AWS
- AWS_SECRET_ACCESS_KEY: Secret Key de AWS

### Job
El repositorio contiene un fichero yaml en .github/workflows que permite tener un Job que se encarga de hacer el deployment, tanto de Desarrollo como de Producción, cada vez que se hace un push al repositorio.
