# Sistema de Modelado Analítico y Simulación del Crecimiento Poblacional ante Contaminantes

Este repositorio contiene el desarrollo analítico, las bases teóricas y las herramientas de simulación numérica en **MATLAB** correspondientes al proyecto de investigación **"Estudio de Poblaciones influidas por un Contaminante"**. 

El núcleo del proyecto radica en modelizar matemáticamente la interacción dinámica entre una población biológica (v.g. peces en un cuerpo de agua) y un agente contaminante externo que experimenta procesos de introducción continuada y autorregulación natural, evaluando la viabilidad y persistencia de la especie bajo diferentes escenarios de toxicidad.

---

## 📐 El Modelo Matemático (Sistema de EDOs)

El comportamiento del ecosistema se rige por un sistema bidimensional de ecuaciones diferenciales ordinarias autónomas no lineales, definido matemáticamente como:

$$\begin{cases} \frac{dx}{dt} = r x (1 - x) - a x y \\ \frac{dy}{dt} = I - d y - B x y \end{cases}$$

Donde las variables de estado y los parámetros biológicos/químicos se definen como:
* **$x(t)$:** Densidad de la población de peces normalizada respecto a la capacidad de carga del ecosistema ($x = P/k \in [0, 1]$).
* **$y(t)$:** Concentración del agente contaminante en el medio acuático ($y \ge 0$).
* **$r$:** Tasa intrínseca de crecimiento de la población biológica.
* **$a$:** Tasa de mortalidad o detrimento poblacional inducido por la toxicidad del contaminante.
* **$I$:** Tasa constante de introducción o vertido del contaminante en el cuerpo de agua.
* **$d$:** Tasa de descomposición, degradación o disipación natural del contaminante.
* **$B$:** Tasa de eliminación o absorción secundaria del contaminante debido a la interacción directa con la propia biomasa o población.

---

## 📊 Fases del Análisis Teórico-Práctico

El estudio matemático aborda el problema desde un enfoque cualitativo de sistemas dinámicos, dividiéndose en las siguientes etapas fundamentales:

### 1. Análisis de Singularidades y Puntos de Equilibrio
Se determinan analíticamente los estados estacionarios del sistema igualando las derivadas a cero (isoclinas de crecimiento cero: $\dot{x}=0$, $\dot{y}=0$).
* **Extinción Poblacional:** Se demuestra la existencia universal de la singularidad $E_0 = (0, I/d)$, un escenario crítico donde la población de peces se extingue por completo y el contaminante se estabiliza en su ratio de equilibrio natural.
* **Coexistencia Biológica:** Se deducen algebraicamente las condiciones analíticas necesarias para la aparición de singularidades interiores $E^* = (x^*, y^*)$ en el primer cuadrante, lo que representa un equilibrio estacionario donde la especie sobrevive en un medio controlado.

### 2. Análisis Cualitativo del Espacio de Fases (Órbitas)
Se traza el mapa de direcciones y el comportamiento de las trayectorias temporales (órbitas) del sistema en el plano de fases. El análisis revela cómo las condiciones iniciales del vertido y la resiliencia de la población determinan el destino final del ecosistema: la recuperación biológica o el colapso ecológico irreversible.

### 3. Estudio de Estabilidad Local y Global en $(0, I/d)$
Para comprender las dinámicas de extinción, se evalúa la estabilidad del punto $E_0$ mediante dos herramientas potentes:
* **Linealización Local (Matriz Jacobiana):** Se calcula el Jacobiano del sistema en la frontera, obteniendo los autovalores para clasificar la naturaleza local del punto (nodo atractor, punto de silla, etc.) en función del umbral crítico $rd - I\alpha$.
* **Estabilidad Global (Funciones de Liapunov):** En el escenario crítico donde el sistema no lineal presenta ambigüedad analítica ($rd = I\alpha$), se construye y valida analíticamente una **Función de Liapunov** ad-hoc basada en formas bilineales y geometrías elípticas:
    $$V(x,y) = x^2 + \frac{(y-1)^2}{2} + x(y-1)$$
    Se demuestra rigurosamente mediante el cálculo de la derivada a lo largo de las trayectorias (órbita derivada $\dot{V} \le 0$) la estabilidad asintótica y las regiones de atracción del sistema, acotando matemáticamente el umbral en el cual la población se ve irremediablemente abocada a la extinción.

---

## 💻 Simulación Numérica con MATLAB (`Orbitas.m`)

Para contrastar el desarrollo algebraico con la realidad empírica del sistema dinámico, el script `Orbitas.m` automatiza la computación analítica y visual del plano de fases.

### Funcionalidades del Script:
* **Resolución Numérica de Alta Precisión:** Utiliza el resolvedor estándar **`ode45`** (basado en un par Runge-Kutta explícito de orden 4 y 5) para integrar el sistema tanto hacia adelante como hacia atrás en el tiempo (`tspan = [-100, 100]`), capturando la evolución completa de las órbitas.
* **Modelado del Campo Vectorial:** Genera una rejilla bidimensional compacta mediante `meshgrid` para calcular y proyectar el campo de direcciones del sistema empleando la función gráfica `quiver()`.
* **Análisis Multiescenario de Condiciones Iniciales:** Evalúa de forma simultánea un vector matricial de condiciones límite preconfiguradas:
    * Estados de baja contaminación y alta población.
    * Escenarios de choque con vertidos masivos iniciales.
    * Dinámicas próximas a los bordes de las cuencas de atracción.
* **Representación Geométrica de Singularidades:** Localiza e ilustra gráficamente el punto crítico de extinción $(0, I/d)$ mediante marcadores geométricos de contraste para estudiar visualmente el comportamiento asintótico de las órbitas atractoras.

---

## 📈 Estructura del Repositorio

* `Estudio de Poblaciones influidas por un Contaminante.pdf`: Memoria de investigación científica que detalla las demostraciones teoremanas, cálculo matricial del Hessiano y el desarrollo formal del modelo.
* `Orbitas.m`: Script ejecutable en entorno MATLAB para reproducir las simulaciones numéricas y los gráficos dinámicos del espacio de fases.
