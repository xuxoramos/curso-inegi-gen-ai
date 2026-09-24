# Guión de demostración: analizar con un agente de código (Sesión 8)

Guía para conducir en vivo la parte de agentes de código de la Sesión 8, con **GitHub Copilot en VS Code** y el archivo `datos_encuesta_sintetica.csv` (el mismo de la Sesión 7). Es demostración del instructor: los alumnos observan y auditan.

El objetivo no es que el análisis salga bien, es que la clase **vea al agente tropezar y lo cace**. El agente, dejado solo, reproduce las mismas trampas del curso; ustedes son los auditores.

---

## Antes de empezar

- Abre VS Code con Copilot en **modo agente** (Agent / el que ejecuta código, no solo autocompletar).
- Ten `datos_encuesta_sintetica.csv` en la carpeta del proyecto, y R disponible.
- Proyecta la pantalla y comparte el encuadre con la clase:

> "Le voy a pedir a Copilot que analice esta encuesta, como lo haría cualquiera. Ustedes no miran, auditan: cada vez que produzca un número, pregúntense si le creerían."

**Recordatorio de seguridad, en voz alta:** este CSV es ficticio (verde en el semáforo). Con microdatos reales de su ámbito, esto **no** se hace en Copilot ni en ninguna herramienta abierta. La demo es posible solo porque el dato es sintético.

---

## Paso 1 · El bucle de trabajo (2 min)

**Prompt:**
```
Carga datos_encuesta_sintetica.csv en R y describe las columnas que tiene.
```

**Qué esperar:** carga el archivo, corre código y muestra las seis columnas (`estrato`, `upm`, `factor`, `programa`, `ingreso`, `score`).

**Qué señalar:** aquí está el bucle de la lámina anterior. Le pediste, escribió y **ejecutó** código, y dejó la salida a la vista. No es un chat que narra: es un agente que corre. El paso que no se automatiza viene ahora: leer y verificar.

---

## Paso 2 · Patrón "inventa lo que no existe" (4 min)

**Prompt:**
```
Dame el ingreso promedio de los hogares por municipio.
```

**Qué esperar:** **no hay columna `municipio`**. El agente casi siempre hace una de dos cosas: inventa/asume una columna, o toma `estrato` (o `upm`) y la trata como si fuera municipio, sin avisar con claridad. Rara vez se detiene a decir "esa columna no existe".

**Pausa de auditoría.** Pregunta a la clase:
- "¿Existe una columna municipio en este archivo?" (No.)
- "¿Qué hizo el agente entonces?" (La inventó o la sustituyó por su cuenta.)

**La lección:** el agente rellena los huecos adivinando. Por eso se verifica contra el diccionario de datos y las columnas reales, no se asume que entendió tu pedido.

**El dato correcto:** las columnas de agrupación son `estrato` (marginación) y `upm` (conglomerado). No hay municipio.

---

## Paso 3 · El ingreso promedio, y el diseño (5 min)

**Prompt:**
```
En R, ¿cuál es el ingreso promedio de los hogares en esta encuesta?
```

**Qué esperar (dos desenlaces, prepárate para ambos):**
- **Falla:** hace `mean(d$ingreso)` y responde **6,949**. Es el promedio de la muestra, no el poblacional: ignoró que es una encuesta con diseño.
- **Acierta:** reconoce `factor`, `estrato` y `upm` como diseño muestral y pondera, dando **8,328**. Los modelos buenos a veces lo hacen (lo vimos con DeepSeek).

**Pausa de auditoría.** Según lo que haya pasado:
- Si dio 6,949: "¿es una muestra simple o una encuesta con factores de expansión? ¿Ponderó?" La clase reconoce el error de la Sesión 7: falta ponderar. El correcto es 8,328.
- Si dio 8,328: "Acertó, ponderó solo. Pero, ¿ustedes lo verificaron, o le creyeron? El punto no es que la IA falle siempre, es que ustedes verifican siempre."

**El dato correcto:** crudo **6,949**, ponderado **8,328** (el crudo subestima 16.6%).

---

## Paso 4 · El efecto del programa: semilla y signo (6 min)

Este es el paso central. Provoca dos patrones a la vez.

**Prompt:**
```
En R, estima el efecto de recibir el programa (columna programa) sobre el score,
con su error estandar por bootstrap.
```

**Qué vigilar:**

1. **La semilla (patrón de reproducibilidad).** ¿El código incluye `set.seed(...)` antes del bootstrap? Muchas veces no.
   - **Pausa:** corre la misma celda dos veces (o pídele "córrelo otra vez"). Si no fijó semilla, el error estándar **cambia entre corridas**.
   - "¿Cuál de los dos es el bueno?" Ninguno es reproducible sin semilla.
   - Pídele: "agrega set.seed para que sea reproducible" y vuelve a correr dos veces: ahora sí coincide.

2. **El signo (patrón de agregación, Simpson).** El efecto agregado sale **negativo, alrededor de −4.5**: parece que el programa **baja** el score.
   - **Pausa:** "El programa, ¿daña? ¿Alguien recuerda Simpson de la Sesión 7?"
   - Pídele: "desglosa el efecto por estrato de marginación". Aparece la reversión: **sube alrededor de +11 en los tres estratos**. El programa ayuda; el agregado engañaba porque los tratados se concentran en Alta marginación.

**Los datos correctos:**
- Efecto agregado: **−4.5** (error estándar clásico 1.46; por conglomerado 2.19).
- Por estrato: Alta 42.2 a 53.2, Media 58.5 a 69.5, Baja 76.8 a 88.4 (**+11 parejo**). El programa **ayuda**.

---

## Paso 5 · "Pierdes el hilo" y "sobre-escribe el crudo" (3 min)

**Para el hilo:** a estas alturas el agente hizo muchos pasos y varias versiones del número. Pregunta:
> "¿Alguien puede decirme, sin desplazarse hacia arriba, cuál fue la cifra correcta del ingreso y por qué?"

Cuesta. Esa es la lección: pídele **pasos chicos**, verifica en cada uno, y al final quédate con el **flujo** (el código ordenado), no con la conversación.

**Para el crudo (opcional, si hay tiempo):**
```
Guarda los resultados en un archivo.
```
Vigila si intenta escribir sobre `datos_encuesta_sintetica.csv` o en la carpeta de datos crudos. Si lo hace, cázalo: **el crudo es de solo lectura**; las salidas van a otra carpeta. Revisa siempre qué archivos toca antes de aceptar.

---

## Cierre del demo (2 min)

Recapitula, conectando con la lámina de los cuatro patrones:

- El agente fue **rápido y competente**, y aun así (inventó una columna / omitió la semilla / reportó el agregado con el signo al revés).
- **Cada error lo cazaron ustedes**, con lo que aprendieron en las Sesiones 7 y 8: ponderar, condicionar por estrato, fijar la semilla, verificar.
- El agente es el copiloto que acelera el trabajo; la auditoría, el diseño y la firma son humanos.

> Frase de cierre: "El agente escribe el análisis en segundos. Que el número sea correcto, reproducible y honesto sigue siendo su trabajo."

---

## Tabla de referencia rápida (para el instructor)

| Qué | Valor correcto |
|-----|----------------|
| Ingreso crudo (sin ponderar) | 6,949 |
| Ingreso ponderado (poblacional) | 8,328 |
| Efecto del programa (agregado) | −4.5 (EE clásico 1.46, por conglomerado 2.19) |
| Efecto por estrato | +11 aproximado en los tres (Alta 42.2 a 53.2, Media 58.5 a 69.5, Baja 76.8 a 88.4) |
| Simpson agregado | sin programa 63.9, con programa 59.5 |
| Columna municipio o región | No existe (solo estrato y upm) |

## Si el agente acierta más de lo esperado

Los modelos mejoran rápido; puede que pondere solo, incluya la semilla o desglose por estrato sin que se lo pidas. **No fuerces una falla que no ocurrió.** Pivota al mensaje honesto: "miren, lo hizo bien, hasta reconoció el diseño; pero ustedes no lo sabían de antemano, y por eso verifican siempre, no porque la IA sea tonta". Los dos patrones más confiables de provocar son el de la **columna inexistente** (Paso 2) y el de la **semilla omitida** (Paso 4); empieza por ahí si el tiempo es corto.
