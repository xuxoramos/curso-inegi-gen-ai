# 01_limpieza.R  --  produce LA FRONTERA: datos/procesados/encuesta.csv
# Toma el crudo (solo lectura), lo limpia y unifica, y escribe el dato documentado.
# El crudo NUNCA se edita a mano ni se sobre-escribe.

crudo <- read.csv("datos/crudos/microdato.csv")

# ... tu limpieza real: tipos, faltantes, duplicados, categorias ...
procesado <- crudo

write.csv(procesado, "datos/procesados/encuesta.csv", row.names = FALSE)
message("Frontera lista: datos/procesados/encuesta.csv (documenta en datos/diccionario.md).")
