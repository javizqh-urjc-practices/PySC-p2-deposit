[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/x2hg7_ib)
# P2 - Depósito

El propósito de esta práctica es mejorar el modelo creado en la práctica anterior, introduciendo nuevas features de PDDL como `:fluents` y `:durative-actions`.

Cansados de que los robots se estén moviendo constantemente de un lado a otro recogiendo basura, hemos creado un nuevo robot recolector de basura que tiene una pinza y un pequeño contenedor donde puede ir depositando la basura que recoge. Como este contenedor tiene una capacidad limitada, el robot viene con un depósito más grande que se ha instalado en un punto fijo de la habitación. Si el contenedor del robot está lleno, o ya no puede cargar más objetos, el robot debe dirigirse al depósito principal para descargar la basura que tenga en su pequeño contenedor.

## Ejercicio 1
Implementa desde cero el problema propuesto usando `:fluents`y aciones normales. Crea un fichero llamado [deposit_fluent_domain.pddl](deposit_fluent_domain.pddl) para la definición del dominio y otro llamado [deposit_problem.pddl](deposit_problem.pddl) para la definición del problema.

### Dominio
El dominio debe incluir un set de `functions` ([numeric fluents](https://planning.wiki/ref/pddl21/domain#numeric-fluents)) para definir las siguientes variables.

* Capacidad máxima del contenedor del robot.
* Carga actual del contenedor del robot.
* El peso de un objeto.

Además, el robot es capaz de realizar las siguientes acciones:

* **move**: El robot se mueve de un punto a otro.
* **pick**: Acción de recoger. El robot recoge un objeto con la pinza. El objeto pasa a estar siendo agarrado por la pinza, pero no cargado en el contenedor.
* **drop**: Acción de soltar. El robot suelta el objeto de la pinza en una ubicación.
* **load**: Acción de cargar. El robot carga un objeto en su contenedor. El objeto debe estar siendo agarrado por la pinza.
* **unload**: Acción de descargar. El robot descarga un objeto en el depósito.

**Nota**: Un objeto debe ser agarrado por la pinza antes de poder cargarlo en el contenedor del robot.

Describe aquí la lista de predicados y funciones necesarios para este modelo, explicando brevemente el propósito de cada uno.

*[Respuesta]*

- Predicados añadidos

```pddl
  (robot_store ?r - robot ?it - item) ; Sirve para indicar si un objeto esta en el deposito del robot
  (in_trash ?it - item) ; Sirve para indicar si un objeto esta en el deposito grande
```

- Funciones añadidas

```pddl
(:functions
  (weight ?it - item) ; Indica el peso del objeto
  (max-load ?r - robot) ; Indica la capacidad máxima de carga del depósito del robot
  (current-load ?r - robot) ; Indica la capacidad actual de carga del depósito del robot
)
```

### Problema
El archivo de definición del problema debe incluir un único robot, y una lista de objetos (sólo basura) y ubicaciones (suelo, mesa, cama, etc.).
También debes inicializar el peso de cada objeto y la capacidad del contenedor del robot con los valores que consideres apropiados.

Finalmente, el objetivo final se debe fijar a que todos los objetos acaben descargados en el depósito principal.

Ejecuta el planificador (POPF / OPTIC) con los archivos de dominio y problema implementados y analiza la salida.
¿Está cargando el robot varios objetos en su contenedor antes de ir al depósito a descargar? ¿Está cargando y descargando los objetos de forma individual? ¿Por qué crees que se comporta de esta manera?

*[Respuesta]*

El robot solo carga de uno en uno con OPTIC y con POPF carga 2 objetos al final antes de ir a descargar. Creo que se comporta de esta manera ya que al no tener coste las acciones eligen e plan que contenga menos de ellas, aunque contengan más viajes. También esto puede también ser así debido a que encuentran la primera solución con ese tiempo, aunque con ese mismo tiempo haya otro plan con menos viajes.

- Plan con POPF
```bash
0.000: (move walle table floor)  [0.001]
0.001: (pick bottle floor walle)  [0.001]
0.002: (move walle floor large-deposit)  [0.001]
0.002: (load bottle walle)  [0.001]
0.003: (unload bottle walle)  [0.001]
0.004: (move walle large-deposit floor)  [0.001]
0.005: (pick newspaper floor walle)  [0.001]
0.006: (load newspaper walle)  [0.001]
0.007: (pick rotten_apple floor walle)  [0.001]
0.008: (load rotten_apple walle)  [0.001]
0.008: (move walle floor large-deposit)  [0.001]
0.009: (unload newspaper walle)  [0.001]
0.010: (unload rotten_apple walle)  [0.001]
```

- Plan con OPTIC
```bash
0.000: (move walle table large-deposit)  [0.001]
0.001: (move walle large-deposit floor)  [0.001]
0.002: (pick rotten_apple floor walle)  [0.001]
0.003: (move walle floor large-deposit)  [0.001]
0.003: (load rotten_apple walle)  [0.001]
0.004: (unload rotten_apple walle)  [0.001]
0.005: (move walle large-deposit floor)  [0.001]
0.006: (pick newspaper floor walle)  [0.001]
0.007: (move walle floor large-deposit)  [0.001]
0.007: (load newspaper walle)  [0.001]
0.008: (unload newspaper walle)  [0.001]
0.009: (move walle large-deposit floor)  [0.001]
0.010: (pick bottle floor walle)  [0.001]
0.011: (move walle floor large-deposit)  [0.001]
0.011: (load bottle walle)  [0.001]
0.012: (unload bottle walle)  [0.001]
```

Ahora, modifica la capacidad máxima de carga del contenedor del robot y/o modifica el pero de los objetos, y vuelve a ejecutar el planificador. ¿Cambia el plan según lo esperado?

*[Respuesta]*

Si cambia según lo esperado, al menos con POPF, ya que con OPTIC al ir de uno en uno da igual. Con POPF vemos que no hace inmediatmente el load de rotten_apple como lo hacía anteriormente, sino que se espera ha haber hecho el unload del newspaper.

- Plan con POPF
```bash
0.000: (move walle table floor)  [0.001]
0.001: (pick bottle floor walle)  [0.001]
0.002: (move walle floor large-deposit)  [0.001]
0.002: (load bottle walle)  [0.001]
0.003: (unload bottle walle)  [0.001]
0.004: (move walle large-deposit floor)  [0.001]
0.005: (pick newspaper floor walle)  [0.001]
0.006: (load newspaper walle)  [0.001]
0.007: (pick rotten_apple floor walle)  [0.001]
0.008: (move walle floor large-deposit)  [0.001]
0.009: (unload newspaper walle)  [0.001]
0.010: (load rotten_apple walle)  [0.001]
0.011: (unload rotten_apple walle)  [0.001]
```

- Plan con OPTIC
```bash
0.000: (move walle table large-deposit)  [0.001]
0.001: (move walle large-deposit floor)  [0.001]
0.002: (pick rotten_apple floor walle)  [0.001]
0.003: (move walle floor large-deposit)  [0.001]
0.003: (load rotten_apple walle)  [0.001]
0.004: (unload rotten_apple walle)  [0.001]
0.005: (move walle large-deposit floor)  [0.001]
0.006: (pick newspaper floor walle)  [0.001]
0.007: (move walle floor large-deposit)  [0.001]
0.007: (load newspaper walle)  [0.001]
0.008: (unload newspaper walle)  [0.001]
0.009: (move walle large-deposit floor)  [0.001]
0.010: (pick bottle floor walle)  [0.001]
0.011: (move walle floor large-deposit)  [0.001]
0.011: (load bottle walle)  [0.001]
0.012: (unload bottle walle)  [0.001]
```


## Ejercicio 2
Para tener un modelo más realista, en este segundo ejercicio se deben cambiar las acciones normales por [durative actions](https://planning.wiki/ref/pddl21/domain#durative-actions).
Para esto, crea un nuevo archivo de dominio llamado [deposit_durative_domain.pddl](deposit_durative_domain.pddl). Puedes reutilizar el anterior archivo de problema.

Dispones de libertad para elegir la duración de cada una de las acciones, pero la acción `move` debe ser durar significantemente más que el resto.

Ejecuta el planificador con las nuevas acciones durativas y analiza la salida.
¿Está cargando el robot varios objetos en su contenedor antes de ir al depósito a descargar?

*[Respuesta]*

Sí, como se puede ver en el plan, se recogen los 3 objetos sin hacer viajes al depósito grande 

- Plan con POPF
```bash
0.000: (move walle table floor)  [100.000]
100.001: (pick bottle floor walle)  [2.000]
102.002: (load bottle walle)  [1.000]
103.003: (pick newspaper floor walle)  [2.000]
105.004: (load newspaper walle)  [1.000]
106.005: (pick rotten_apple floor walle)  [2.000]
106.006: (move walle floor large-deposit)  [100.000]
108.006: (load rotten_apple walle)  [1.000]
206.007: (unload bottle walle)  [1.000]
206.008: (unload newspaper walle)  [1.000]
206.009: (unload rotten_apple walle)  [1.000]
```

- Plan con OPTIC
```bash
0.000: (move walle table floor)  [100.000]
100.001: (pick rotten_apple floor walle)  [2.000]
102.002: (load rotten_apple walle)  [1.000]
103.003: (pick newspaper floor walle)  [2.000]
105.004: (load newspaper walle)  [1.000]
106.005: (pick bottle floor walle)  [2.000]
106.006: (move walle floor large-deposit)  [100.000]
108.006: (load bottle walle)  [1.000]
206.007: (unload rotten_apple walle)  [1.000]
206.007: (unload newspaper walle)  [1.000]
206.007: (unload bottle walle)  [1.000]
```


¿Cuáles son las diferencias en la salida del planificador con y sin `durative actions`?

*[Respuesta]*

Con las durative actions el plan resulta más realista, ya que recoge los 3 objetos y luego los descarga todos juntos, minimmizando el número de trayectos.

¿Qué diferencia hay entre la salida del planificador POPF y OPTIC? ¿Cuál parece funcionar mejor?

*[Respuesta]*

En este caso no hay diferencias significativas en la salida de los planificadores, siendo la única diferencia el orden en el que se mueven los objetos.

Con esto no se puede saber cuál es el que funciona mejor. 

## Ejercicio extra [*Opcional*]
Incluye una función para expresar la distancia entre dos ubicaciones, y modifica la duración de la acción `move` para que dependa de esta distancia.
Como es necesario modificar tanto el dominio como el problema, puedes crear dos nuevos ficheros [deposit_domain_extra.pddl](deposit_domain_extra.pddl) y [deposit_problem_extra.pddl](deposit_problem_extra.pddl) para este ejercicio extra.
