# 00_adquisicion.R  --  AGUAS ARRIBA de la frontera (repo restringido)
# Baja los microdatos de la fuente. Usa credenciales y acceso interno.
# Las credenciales viven en .Renviron (fuera del repo), NUNCA aqui.

usuario <- Sys.getenv("DB_USER")
clave   <- Sys.getenv("DB_PASSWORD")
if (usuario == "") stop("Falta configurar .Renviron (copia .Renviron.ejemplo).")

# ... conexion y descarga a datos/crudos/ ...
# Ej: con <- DBI::dbConnect(...); readr::write_csv(crudo, "datos/crudos/microdato.csv")

message("Descarga completa en datos/crudos/ (inmutable de aqui en adelante).")
