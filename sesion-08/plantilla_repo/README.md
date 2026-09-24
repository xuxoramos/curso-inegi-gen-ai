# Proyecto reproducible (plantilla)

Plantilla de estructura para un analisis cuantitativo reproducible, curso de IA Aplicada (INEGI).
Ajustala a tu proyecto. La idea central es la **frontera de reproducibilidad**.

## La frontera

La reproducibilidad empieza en `datos/procesados/`: un dato limpio, versionado y documentado
(ver `datos/diccionario.md`). El analisis (`scripts/02_analisis.Rmd`) parte de ahi y es 100% reproducible.

- **Aguas arriba de la frontera** (`00_adquisicion`, `01_limpieza`): usan credenciales y acceso interno.
  Viven idealmente en un repo restringido aparte; no todos pueden reproducir esta parte.
- **Aguas abajo** (`02_analisis`, `03_reporte`): cualquiera las reproduce desde el dato documentado.

## Como reproducir

1. Copia `.Renviron.ejemplo` a `.Renviron` y pon tus valores (solo si vas a correr `00`/`01`).
2. En R: `renv::restore()` para instalar las versiones fijadas.
3. Teje el analisis: `rmarkdown::render("scripts/02_analisis.Rmd")`.
4. Prueba de reproducibilidad: reinicia y corre todo de cero; el numero debe salir igual.

## Los tres candados

- **Azar:** `set.seed()` al inicio de todo lo que use aleatoriedad.
- **Aritmetica:** funciones probadas (`var`, `sd`), no formulas de libro.
- **Entorno:** `renv.lock` fija versiones; `sessionInfo()` las registra; el insumo con ruta relativa.

## En Python

Cambia `.R`/`.Rmd` por `.py`/`.ipynb`, `renv.lock` por `requirements.txt`, y `renv::restore()` por
`pip install -r requirements.txt`. La estructura y la frontera son las mismas.
