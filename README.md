---
# title: Laboratorio de Funcional
### authors: Facundo Sharry, Alejandro Pitt, Juan Gonzalez
---
# Laboratorio de Funcional Grupo 30

Integrantes:

- Facundo Sharry
- Juan Gonzalez
- Alejandro Pitt

La consigna del laboratorio está en:
<https://tinyurl.com/funcional-2024-famaf>

## 1. Tareas

Pueden usar esta checklist para indicar el avance.

### Verificación de que pueden hacer las cosas

- [X] Haskell instalado y testeos provistos funcionando. (En Install.md están las instrucciones para instalar.)

### 1.1. Lenguaje

- [X] Módulo `Dibujo.hs` con el tipo `Dibujo` y combinadores. Puntos 1 a 3 de la consigna.
- [X] Definición de funciones (esquemas) para la manipulación de dibujos.
- [X] Módulo `Pred.hs`. Punto extra si definen predicados para transformaciones innecesarias (por ejemplo, espejar dos veces es la identidad).

### 1.2. Interpretación geométrica

- [X] Módulo `Interp.hs`.

### 1.3. Expresión artística (Utilizar el lenguaje)

- [X] El dibujo de `Dibujos/Feo.hs` se ve lindo.
- [X] Módulo `Dibujos/Grilla.hs`.
- [X] Módulo `Dibujos/Escher.hs`.
- [X] Listado de dibujos en `Main.hs`.

### 1.4 Tests

- [X] Tests para `Dibujo.hs`.
- [X] Tests para `Pred.hs`.

## 2. Experiencia

> Nuestra experiencia en el desarrollo del proyecto del DSL Dibujo ha sido altamente educativa y reveladora. Hemos aprendido la importancia de la modularidad y la organización del código a través de la separación de funcionalidades en distintos módulos. Esto ha facilitado enormemente nuestra comprensión del proyecto y ha fomentado una colaboración efectiva entre los miembros del equipo. Además, hemos explorado el poder de la polimorfia en la definición del lenguaje, lo que nos ha permitido flexibilidad y reutilización de código en diferentes contextos. En conclusión, esta experiencia nos ha dotado de una comprensión más profunda de los principios de la programación funcional y nos ha preparado para futuros desafíos en el desarrollo de software.

## 3. Preguntas

1. ¿Por qué están separadas las funcionalidades en los módulos indicados? Explicar detalladamente la responsabilidad de cada módulo.

    > La importancia de separar funcionalidades en módulos radica en la separación de responsabilidades y dependencias. Cada módulo posee sus propios imports utilizando otras funcionalidades diferentes, esta separación permite una mejor organización y comprensión del código, y por ende del programa. Consideramos la separación más importante del proyecto la de la semántica y la sintaxis de nuestro DSL.
    
    > En nuestra responsabilidad cayó la implementación de los módulos Dibujo, Pred e Interp. El primero de estos contiene la especificación de qué es un dibujo sintácticamente, sus constructores y combinadores. Además, funciones que permiten la transformación, manipulación y composición de un dibujo dado.
    
    > El módulo Pred contiene predicados que permiten la evaluación de condiciones en los dibujos que se les presenten con el objetivo de realizar modificaciones, o no, en los mismos en consecuencia.
    
    > Finalmente el módulo Interp se encarga de la interpretación semántica de un Dibujo a través de la librería Gloss, la cual le da una interpretación visual a la interpretación geométrica que utilizan las funciones de Interp. Esta interpretación geométrica sucede modificando los vectores que utilizamos para definir un dibujo en un plano. 

2. ¿Por qué las figuras básicas no están incluidas en la definición del lenguaje, y en vez de eso, es un parámetro del tipo?

    > El proyecto está definido de forma polimórfica, es decir podríamos interpretar diferentes formas de “Dibujo” dependiendo de lo que se quiera graficar. Es por esto que no se incluyen las figuras básicas, ya que estas serán definidas de diferente forma en función del contexto de uso del DSL. Esto aporta la posibilidad de reutilizar el código en caso de ser necesario con ligeras modificaciones. 

3. ¿Qué ventaja tiene utilizar una función de `fold` sobre hacer pattern-matching directo?

    > La función fold concede la posibilidad de evitar el pattern-matching en el resto de funciones, esto ayuda a implementar funciones con código más limpio, por ende más fácil de interpretar para el programador. Consideramos esto una gran ventaja a la hora de trabajar en un equipo formado por múltiples individuos.

4. ¿Cuál es la diferencia entre los predicados definidos en Pred.hs y los tests?

    > Los predicados permiten la evaluación de condiciones en los dibujos, otorgando la posibilidad de modificarlos en función de dicha evaluación e incluso hay una función que directamente modifica un dibujo cambiando cierta figura indicada por otra. Es decir los predicados están más cerca del uso del lenguaje DSL implementado, por otro lado los test permiten comprobar el correcto funcionamiento de las diversas funciones a través de la comprobación de sus entradas, salidas, estado, etc.

## 4. Extras

Completar si hacen algo.
