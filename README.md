# ZemogaMobileTest
Prueba Técnica de Zemoga en iOS con Swift 5.4

## Ejecutar App
### Pasos:
1. Descargar el proyecto
2. Instalar :

```
npm install -g json-server
```

3. Dirigirse a la carpeta server y ejecutar

```
json-server --watch db.json
```

4. Abrir [ZemogaTest.xcodeproj](https://github.com/1valero/ZemogaMobileTest/tree/main/ZemogaTest/ZemogaTest.xcodeproj)
5. Compilar el proyecto

## Arquitectura

### Modelo Vista Controllador

Este patrón de diseño me ayudaba realizar de forma rápida el CRUD (Create, Read, Update and Delete) dentro de lo pedido. Dentro del modelo deseaba manejar la BD de forma rápida y persistente para la app. También evitar utilizar blioteca de terceras para utilizar URL (nativo) dentro de los modelos.
Al implementar este patrón de diseño puedo mantener el Control de las Vistas por sus constantes cambios que hay en la data local y de servidor.

### Persistency

Esta aplicación utiliza Core Data (Nativo de iOS). La simpleza de código y su implementación rápida me ayudaba mucho para el rápido desarrollo y también opte por esta base de datos para evitar la instalación de Cocoapods (o otros) y de dependencias en la app. Con el fin de realizar una aplicación menos robusta.

### Blioteca de terceros

Ninguno. No se instalo Cocoapods o alguna dependecía para realizar esta app

¡GRACIAS!

<p align="center">
    <img src="https://blog.teamtreehouse.com/wp-content/uploads/2017/11/Thanksgiving.png" height="200px">
</p>

