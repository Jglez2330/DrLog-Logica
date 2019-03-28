readText():- read(X),
  atomic_list_concat(List,' ',X),
  searchKeywords(List).

readText(Palabra,X):-
  atomic_list_concat(List,' ',X),

    searchKeyword(Palabra,List).

keyword(Word):- enfermedad(Word).
keyword(Word):- causa(Word).

enfermedad(cancer).
causa(existir).

searchKeywords([]).
searchKeywords([X|Z]):- keyword(X); searchKeywords(Z).


