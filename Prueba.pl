consultaMedica(X,Y):- 
    b_setval(sint1,0),
    b_setval(sint2,0),
    b_setval(sint3,0),
    b_setval(enfer,0),
    nb_setval(enfermedad, 0).

    conversacion(X,Y).


conversacion(X,Salida):- atomic_list_concat(List," ",X),
revisar(List,Salida).

revisar(Lista,Salida):- searchExtra(Lista,Salida).

revisar(Lista,Salida):- searchKeywords(Lista,Salida).

revisar(_,Salida):- atom_concat('Lo siento, no entendi, por favor repitalo.', '',Y).


asignarVar(Sintoma):- b_getval(sint1,S1), S1 == 0, b_setval(sint1, Sintoma).
asignarVar(Sintoma):- b_getval(sint2,S2), S2 == 0, b_setval(sint2, Sintoma).
asignarVar(Sintoma):- b_getval(sint3,S3), S3 == 0, b_setval(sint3, Sintoma).

suficientesSintomas(Salida):-b_getval(sint1,S1),b_getval(sint2,S2),b_getval(sint3,S3),sintomas_de(S1,S2,S3,E), b_setval(enfer,E),


