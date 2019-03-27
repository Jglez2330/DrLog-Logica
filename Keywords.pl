readText():- read(X),
  atomic_list_concat(List,' ',X),
  searchKeywords(List).

keyword(Word):- enfermedad(Word), write(Word), nl, false.
keyword(Word):- causa(Word), write(Word), nl, false.

enfermedad(cancer).
causa(existir).

searchKeywords([]).
searchKeywords([X|Z]):- keyword(X); searchKeywords(Z).


