<?php

$indicador = true;
$nombre = Walter;
$Edad = 20;
$Promedio = 78.999;
$índice    = $argv[0]; // ¡Cuidado, no hay validación en la entrada de datos!

echo '<p>Hola Mundo</p>';

$consulta  = "SELECT id, name FROM products ORDER BY name LIMIT 20 OFFSET $índice;";
$resultado = pg_query($conexión, $consulta);

?>