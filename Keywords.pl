readText(Palabra):- read(X),
  atomic_list_concat(List,' ',X),
  searchKeyword(Palabra,List).

keyword(Word):- enfermedad(Word).
keyword(Word):- causa(Word).

enfermedad(cancer).
causa(existir).

searchKeyword(X,[X|_]):- keyword(X).
searchKeyword(X,[_|Y]):- searchKeyword(X,Y).
