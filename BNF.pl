
/*
oracion(Lista1):- sintagmaNominal(Lista), sintagmaVerbal(Lista).


sintagmaNominal([CabezaLista, SiguienteElemento |ColaLista]):- determinante(CabezaLista), nombre(SiguienteElemento).


sintagmaVerbal([CabezaLista|ColaLista]):- verbo(CabezaLista).

sintagmaVerbal([CabezaLista, SiguienteElemento |ColaLista]):- verbo(CabezaLista), sintagmaNominal(SiguienteElemento).

determinante()*/

oracion(A,B):- sintagma_nominal(A,C),
               sintagma_verbal(C,B).

sintagma_nominal(A,B):- determinante(A,C),
                        nombre(C,B).

sintagma_verbal(A,B):- verbo(A,C),
                       sintagma_nominal(C,B).
sintagma_verbal(A,B):- verbo(A,B).

determinante([el|A],A).
determinante([la|A],A).

nombre([hombre|A],A).
nombre([manzana|A],A).

verbo([come|A],A).
verbo([canta|A],A).
