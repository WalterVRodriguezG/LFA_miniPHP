README:

Informacion:

EL siguiente programa es una analizador puramente lexico del lenguaje de programacion web "PHP". Por medio de la libreria Jflex se declaran las expresiones regulares propias de php.

Para utilizar el programa se realiza lo siguiente:
1. abrir el programa llamado "PruebaInicial" en Netbeans, 
2. Se debe ejecutar (Shift + F6) en primer lugar la clase "PruebaInicial.java". Este generara el archivo "AnalizadorLex.java" que con tiene todas las reglas de validacion para el archivo de entrada de php, a partir del archivo AnalizadorLex.flex
3. Al finaliar muestra un mensaje indicando el fin de la creacion del archivo. Presionar aceptar.
4. Luego se debe ejecutar la clase llamada "Interfase" que despliega un formulario.
5. En dicho formulario presionar el boton "Cargar Archivo" y seleccionar el archivo php.
6. Al cargar la ruta en la linea de texto, presionar el boton "Analizar"
7. Automaticamente despliega el resultado del analizador lexico en el cuadro de texto izquierdo, y envia un mensaje. Si el archivo no tiene errores, despliega el mensaje: " PHP Creado con Exito" y la ruta, de lo contrario, despliega un mensaje indicando que el programa posee errores y la ruta.

