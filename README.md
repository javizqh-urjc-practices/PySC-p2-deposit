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

### Problema
El archivo de definición del problema debe incluir un único robot, y una lista de objetos (sólo basura) y ubicaciones (suelo, mesa, cama, etc.).
También debes inicializar el peso de cada objeto y la capacidad del contenedor del robot con los valores que consideres apropiados.

Finalmente, el objetivo final se debe fijar a que todos los objetos acaben descargados en el depósito principal.

Ejecuta el planificador (POPF / OPTIC) con los archivos de dominio y problema implementados y analiza la salida.
¿Está cargando el robot varios objetos en su contenedor antes de ir al depósito a descargar? ¿Está cargando y descargando los objetos de forma individual? ¿Por qué crees que se comporta de esta manera?

*[Respuesta]*

Ahora, modifica la capacidad máxima de carga del contenedor del robot y/o modifica el pero de los objetos, y vuelve a ejecutar el planificador. ¿Cambia el plan según lo esperado?

*[Respuesta]*


## Ejercicio 2
Para tener un modelo más realista, en este segundo ejercicio se deben cambiar las acciones normales por [durative actions](https://planning.wiki/ref/pddl21/domain#durative-actions).
Para esto, crea un nuevo archivo de dominio llamado [deposit_durative_domain.pddl](deposit_durative_domain.pddl). Puedes reutilizar el anterior archivo de problema.

Dispones de libertad para elegir la duración de cada una de las acciones, pero la acción `move` debe ser durar significantemente más que el resto.

Ejecuta el planificador con las nuevas acciones durativas y analiza la salida.
¿Está cargando el robot varios objetos en su contenedor antes de ir al depósito a descargar?

*[Respuesta]*

¿Cuáles son las diferencias en la salida del planificador con y sin `durative actions`?

*[Respuesta]*


¿Qué diferencia hay entre la salida del planificador POPF y OPTIC? ¿Cuál parece funcionar mejor?

*[Respuesta]*


## Ejercicio extra [*Opcional*]
Incluye una función para expresar la distancia entre dos ubicaciones, y modifica la duración de la acción `move` para que dependa de esta distancia.
Como es necesario modificar tanto el dominio como el problema, puedes crear dos nuevos ficheros [deposit_domain_extra.pddl](deposit_domain_extra.pddl) y [deposit_problem_extra.pddl](deposit_problem_extra.pddl) para este ejercicio extra.
