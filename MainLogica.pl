consultaMedica():- read(X),
  atomic_list_concat(List,' ',X),
  revisar(List),
  consultaMedica(). %recursividad para hacer un ciclo de conversacion


revisar(List):- searchExtra(List). %keywords sin necesidad de revisar sintaxis
revisar(List):- oracion(List,[]), %keywords que importa la sintaxis
  write("es oracion"), nl,
  searchKeywords(List).
% -------------------------------------------------------------------------
% revisa las keywords y da una respuesta dependiendo del tipo de keyword
keyword(Word):- enfermedad(Word), write("jaja, que mamon"), nl, false.
keyword(Word):- causa(Word), write(Word), nl.

keywordExtra(Word):- saludo(Word), write("Que me dice bichillo"), nl.
keywordExtra(Word):- despedida(Word), write("Bueno pa, adios"), nl.

%busqueda en la lista de palabras
searchKeywords([]).
searchKeywords([X|Z]):- keyword(X); searchKeywords(Z).

searchExtra([]):- false.
searchExtra([X|Z]):- keywordExtra(X); searchExtra(Z).
% ------------------------------------------------------------------------------
% BNF
oracion(A,B):- sintagma_nominal(A,C),
               sintagma_verbal(C,B).

sintagma_nominal(A,B):- nombre(A,B).
sintagma_nominal(A,B):- determinante(A,C),
                        nombre(C,B).

sintagma_verbal(A,B):- verbo(A,C),
                       sintagma_nominal(C,B).
sintagma_verbal(A,B):- verbo(A,B).

determinante([el|A],A).
determinante([la|A],A).
% ------------------------------------------------------------------------
%base de datos
nombre([hombre|A],A).
nombre([manzana|A],A).
nombre([cancer|A],A).
nombre([yo|A],A).
nombre([tengo|A],A).
nombre([gripe|A],A).


verbo([come|A],A).
verbo([canta|A],A).
verbo([tiene|A],A).

enfermedad(cancer).
enfermedad(gripe).

causa(existir).

saludo(hola).
saludo(saludos).
saludo(buenas).

despedida(adios).
despedida(luego).










