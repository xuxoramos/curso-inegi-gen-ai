# Diccionario de datos: datos/procesados/encuesta.csv

Este archivo es LA FRONTERA de reproducibilidad. Todo el analisis parte de aqui.

| Variable | Tipo   | Descripcion |
|----------|--------|-------------|
| estrato  | texto  | Nivel de marginacion del hogar (Alta, Media, Baja). Estratificacion. |
| upm      | texto  | Unidad primaria de muestreo (conglomerado). |
| factor   | numero | Factor de expansion del hogar. |
| programa | 0/1    | Recibe el apoyo (1) o no (0). |
| ingreso  | numero | Ingreso mensual del hogar, en pesos. |
| score    | numero | Indice de resultado, 0 a 100. |

Fuente: [describe el origen]. Fecha de corte: [fecha].
Generado por: scripts/01_limpieza.R (a partir de datos/crudos/, que es inmutable).
