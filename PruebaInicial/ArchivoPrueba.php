<?php

$indicador = true;
$nombre = "Walter";
$Edad = 20;
$Promedio = 78.999;
$indice    = $argv[0]; // ¡Cuidado, no hay validación en la entrada de datos!

echo '<p>Hola Mundo</p>';


$dia = 24; //Se declara una variable de tipo integer.
$sueldo = 758.43; //Se declara una variable de tipo double.
$nombre = "juan"; //Se declara una variable de tipo string.
$exite = true; //Se declara una variable boolean.
echo "Variable entera:";
echo $dia;
echo "<br>";
echo "Variable double:";
echo $sueldo;
echo "<br>";
echo "Variable string:";
echo $nombre;
echo "<br>";
echo "Variable boolean:";
echo $exite;


/*$consulta  = "SELECT id, name FROM products ORDER BY name LIMIT 20 OFFSET $índice;";
$resultado = pg_query($conexión, $consulta);*/

?>