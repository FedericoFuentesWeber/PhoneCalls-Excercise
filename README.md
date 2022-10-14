# PhoneCalls-Excercise

- Se considera que las llamadas empiezan y terminan el mismo día.


### Justificaciones:

- El registro de llamadas cumpliría la función de una base de datos en donde guardo las llamadas para luego utilizarlas cuando se necesiten.
[Referencia](https://stackoverflow.com/questions/40426304/smalltalk-pharo-string-concatenation-instead-of-streams)


- El registro de costos se encarga de guardar el costo de cada tipo de llamada, este registro a partir de una llamada calcula cuál sería su costo final.

- Para evitar tener que crear tres colecciones ordenadas en el registro de llamadas, la factura y el builder de la factura para los distintos tipos de llamadas y evitar tener que seguir agregando nuevas colecciones en caso de que se tuviera que crear nuevos tipo de llamadas, opte por crear una sola colección donde estarán todas las llamadas ya que todas heredan de la misma clase padre por lo cual entienden el mismo mensaje para el cálculo de costos. 

- Ya que todas las llamadas fueron guardadas en una sola colección sin importar de qué tipo sean, agregue un método tipo con el cual diferenciarlas al momento de imprimir la factura.

- Como la duración de una llamada local puede abarcar más de una franja horaria tuve que tener en cuenta todas las posibilidades al momento de calcular el costo de la misma, es por esto que durante el cálculo del costo filtro todas las franjas horarias del día de la llamada y realizó una suma del costo del tiempo que dure la llamada dentro de cada franja para así poder obtener el valor correcto.

- Para las llamadas preferí utilizar herencia por que lo considere como la mejor opción al ver la poca cantidad de tipos de llamadas que se tiene, en caso de que a futuro se decidiera seguir agregando más tipos tal vez sería conveniente cambiar la herencia por composición.

- Al momento de imprimir la factura opte por usar stream en lugar de string concatenados para limitar la cantidad de objetos creados.
