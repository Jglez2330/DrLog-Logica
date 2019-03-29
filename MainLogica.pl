:-consult('DataBase').


consultaMedica():- %se inicializan las variables de sintomas y enfermedad del paciente en 0.
    b_setval(sint1,0),
    b_setval(sint2,0),
    b_setval(sint3,0),
    b_setval(enfer,0),
    conversacion().

conversacion():-read(X),
  atomic_list_concat(List,' ',X),
  revisar(List),
  conversacion(). %recursividad para hacer un ciclo de conversacion

revisar(List):- searchExtra(List). %keywords sin necesidad de revisar sintaxis
revisar(List):- oracion(List,[]), %keywords que importa la sintaxis
  searchKeywords(List).
revisar(_):- write("Lo siento, no entendí, por favor repítalo."), nl.
% -------------------------------------------------------------------------
% Asigna un sintoma nuevo a las variables nulas.
asignarVar(Sintoma):- b_getval(sint1,S1), S1 == 0, b_setval(sint1, Sintoma).
asignarVar(Sintoma):- b_getval(sint2,S2), S2 == 0, b_setval(sint2, Sintoma).
asignarVar(Sintoma):- b_getval(sint3,S3), S3 == 0, b_setval(sint3, Sintoma).

suficientesSintomas():-b_getval(sint1,S1),b_getval(sint2,S2),b_getval(sint3,S3),
    sintomas_de(S1,S2,S3,E), b_setval(enfer,E),
    write("Lamento decirle esto, pero usted padece de "),write(E),nl.
suficientesSintomas().

% revisa las keywords y da una respuesta dependiendo del tipo de keyword
keyword(Word,Resto):- sintoma(Word),%el paciente está dando mencionando un sintoma
     asignarVar(Word), suficientesSintomas(),searchKeywords(Resto).

keyword(Word,_):- caus(Word), %pregunta por las causas de su enfermedad
    b_getval(enfer,E),
    (   E \= 0 -> causa_enfermedad(E,C),write("La causa comun de esa enfermedad es "), write(C), nl;
        write("Como quiere que le de la causa de su enfermedad si aun no me ha dicho los sintomas necesarios para darle un diagnostico?"), nl).

keyword(Word,_):- trat(Word), %pregunta por el tratamiento de su enfermedad
    b_getval(enfer,E),
    (   E \= 0 -> curar_enfermedad(E,T),write("Usted debe "), write(T), nl;
        write("Como quiere que le diga como curar de su enfermedad si aun no me ha dicho los sintomas necesarios para darle un diagnostico?"), nl).

keyword(Word,_):- prev(Word), %pregunta como prevenir la enfermedad
    b_getval(enfer,E),
    (   E \= 0 -> lista_prevenciones(E),write("Para prevenir esa enfermedad, se recomienda ");
        write("Como quiere que le diga como prevenir de su enfermedad si aun no me ha dicho los sintomas necesarios para darle un diagnostico?"), nl).

keywordExtra(Word):- saludo(Word), write("Hola, en que lo puedo ayudar hoy?"), nl.
keywordExtra(Word):- despedida(Word), write("Adios, espero que esté bien."), nl,
    break.

%busqueda en la lista de palabras
searchKeywords([]).
searchKeywords([X|Z]):- keyword(X,Z); searchKeywords(Z).

searchExtra([]):-false.
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
determinante([como|A],A).
determinante([que|A],A).
determinante([cual|A],A).
determinante([en|A],A).
determinante([esa|A],A).
determinante([lo|A],A).
determinante([cuando|A],A).
determinante([con|A],A).
determinante([la|A],A).


% ------------------------------------------------------------------------


% Reglas principales para relacionar los hechos de la base de datos y
% enviar la información correspondiente al usuario

% Regla que me relaciona un solo sintoma con una enfermedad, la variable
% S se refiere a sintoma y la variable E se refiere a enfermedad, la
% regla primero verifica que efectivamente se traten de sintomas y
% enfermedades de la base de datos, y luego hace la relación verificando
% que el área de afectación del sintoma concuerde con una de las áreas
% de afectación de la enfermedad

sintoma_de(S,E):-sintoma(S),enfermedad(E),sintoma_area(S,Y),enfermedad_area(E,Y).


% Regla que me relaciona tres sintomas con una enfermedad, los tres
% sintomas son ingresados de la comunicación con el usuario y en la
% variable E se almacena la enfermedad correspondiente

sintomas_de(S1,S2,S3,E):-sintoma_de(S1,E),sintoma_de(S2,E),sintoma_de(S3,E).


% Regla para relacionar una enfermedad con una causa, la enfermedad se
% recibe como parámetro y la regla instancia en la variable C la causa
% correspondiente

causa_enfermedad(E,C):-enfermedad(E),causa(C,E).

% Reglas para obtener las formas de prevención de una enfermedad, la
% regla de prevenir_enfermedad liga una enfermedad con una forma de
% prevención (si existe tratamiento previo también se incluye) de
% acuerdo con el área de afectación. La regla lista_prevenciones recibe
% una enfermedad como parámetro de entrada e instancia en la variable L
% la lista con todas las posibles prevenciones para dicha enfermedad.

prevenir_enfermedad(E,P):-enfermedad(E),tratamiento_previo(E,P).
prevenir_enfermedad(E,P):-enfermedad(E),prevencion(P),enfermedad_area(E,X),prevencion_area(P,X).

lista_prevenciones(E):-findall(Prevencion,prevenir_enfermedad(E,Prevencion),L),
    concatenarLista(L).

concatenarLista(L):- concatenarLista(L," ",_).
concatenarLista([],_,SF):-write(SF).
concatenarLista([S1|Resto],SI,_):- string_concat(S1,", ",S),
    string_concat(SI,S,SFinal),
    concatenarLista(Resto,SFinal,SFinal).


% Regla para relacionar el tratamiento con una enfermedad, se recibe
% como parámetro la enfermedad y devuelve en la variable T, el
% tratamiento respectivo para dicha enfermedad.

curar_enfermedad(E,T):-enfermedad(E),tratamiento_enfermedad(T,E).

%base de datos














