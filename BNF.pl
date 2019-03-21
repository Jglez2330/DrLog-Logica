

/**/
oracion(Lista):- sintagmaNominal(Lista), sintagmaVerbal(Lista).

/**/
sintagmaNominal([CabezaLista, SiguienteElemento |ColaLista]):- determinante(CabezaLista), nombre(SiguienteElemento).

/**/
sintagmaVerbal([CabezaLista|ColaLista]):- verbo(CabezaLista).

sintagmaVerbal([CabezaLista, SiguienteElemento |ColaLista]):- verbo(CabezaLista), sintagmaNominal(SiguienteElemento).
