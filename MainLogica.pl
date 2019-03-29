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
revisar(List):- %oracion(List,[]), %keywords que importa la sintaxis
  %write("ORACION"), nl,
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
suficientesSintomas():- write("Necesito que me diga más sintomas"),nl.

% revisa las keywords y da una respuesta dependiendo del tipo de keyword
keyword(Word):- sintoma(Word), %el paciente está dando mencionando un sintoma
     asignarVar(Word), suficientesSintomas().

keyword(Word):- caus(Word), %pregunta por las causas de su enfermedad
    b_getval(enfer,E),
    (   E \= 0 -> causa_enfermedad(E,C), write(C), nl;
        write("Como quiere que le de la causa de su enfermedad si aun no me ha dicho los sintomas necesarios para darle un diagnostico?"), nl).

keyword(Word):- trat(Word), %pregunta por el tratamiento de su enfermedad
    b_getval(enfer,E),
    (   E \= 0 -> curar_enfermedad(E,T), write(T), nl;
        write("Como quiere que le diga como curar de su enfermedad si aun no me ha dicho los sintomas necesarios para darle un diagnostico?"), nl).

keyword(Word):- prev(Word), %pregunta como prevenir la enfermedad
    b_getval(enfer,E),
    (   E \= 0 -> lista_prevenciones(E,L), write(L), nl;
        write("Como quiere que le diga como prevenir de su enfermedad si aun no me ha dicho los sintomas necesarios para darle un diagnostico?"), nl).

keywordExtra(Word):- saludo(Word), write("Hola, en que lo puedo ayudar hoy?"), nl.
keywordExtra(Word):- despedida(Word), write("Adios, espero que esté bien."), nl,
    break.

%busqueda en la lista de palabras
searchKeywords([]):- false.
searchKeywords([X|Z]):- searchKeywords(Z); keyword(X).

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
%Lista de enfermedades, las enfermedades se tratan como strings

enfermedad("Gripe").
enfermedad("Virus Estomacal").
enfermedad("Cancer").
enfermedad("Bronquitis").
enfermedad("Varicela").

% Lista de sintomas, de momento los sintomas son tratados como atomos de
% prolog, sin embargo hay algunos que pueden quedar ambigüos como dolor
% (puede ser dolor de cuerpo, dolor de estómago,etc), igual sucede con
% pérdida (pérdida de apetito, pérdida de peso).Se puede cambiar a
% string para solucionar la ambigüedad pero se debe recibir el string
% completo de la comunicación con el usuario

sintoma(tos).
sintoma(fiebre).
sintoma(cansancio).
sintoma(diarrea).
sintoma(vomito).
sintoma(dolor).
sintoma(perdida).
sintoma(flema).
sintoma(picazon).
sintoma(ampollas).


% Lista de Causas para cada enfermedad, El primer string del hecho es la
% causa (la cuál es propia y única para cada enfermedad), el segundo
% string indica a cuál enfermedad pertenece dicha causa.


causa("La gripe es causada por el virus de la influenza","Gripe").
causa("El virus que causa la varicela es el virus varicela zóster","Varicela").
causa("El virus estomacal es causado por el norovirus y el rotavirus ","Virus Estomacal").
causa("Los mismos virus que causan los resfriados y la gripe son la causa más frecuente de la bronquitis","Bronquitis").
causa("Por lo general el cancer lo provocan mutaciones geneticas","Cancer").


%Lista de prevenciones

prevencion("Lavarse las manos").
prevencion("Cubrise la boca al toser").
prevencion("Usar desinfectante para manos").
prevencion("Desinfectar superficies y objetos del hogar").
prevencion("Hacer ejercicio con frecuencia").
prevencion("Tener buena alimentación").
prevencion("Evitar los vicios como alcohol o cigarros").


% Hechos que me asocian una prevención, con el área del cuerpo a la
% cuál va dirigida la prevención

prevencion_area("Lavarse las manos",estomago).
prevencion_area("Lavarse las manos",respiracion).
prevencion_area("Cubrise la boca al toser",respiracion).
prevencion_area("Usar desinfectante para manos",estomago).
prevencion_area("Desinfectar superficies y objetos del hogar",estomago).
prevencion_area("Hacer ejercicio con frecuencia",condicion_fisica).
prevencion_area("Tener buena alimentación",peso).
prevencion_area("Evitar los vicios como alcohol o cigarros",condicion_fisica).


% Hechos que me indican si una enfermedad tiene tratamiento previo, para
% incluirlos también en la lista de prevenciones de cada enfermedad. El
% primer string es el nombre de la enfermedad y el segundo el
% tratamiento.

tratamiento_previo("Gripe","Vacunarse todos los años").
tratamiento_previo("Bronquitis","Ponerse la vacuna para la gripe todos los años").
tratamiento_previo("Varicela","Vacunarse contra el virus que produce la varicela").


% Lista de tratamientos posteriores a la enfermedad, el hecho los asocia
% directamente con la enfermedad (segundo parámetro) ya que los
% tratamientos son únicos para cada tipo de enfermedad de la base de
% datos


tratamiento_enfermedad("Tomar antigripal por una semana y tomar líquidos en abundancia","Gripe").
tratamiento_enfermedad("Ingerir alimentos blandos y mantenerse hidratado","Virus Estomacal").
tratamiento_enfermedad("Consumir medicamentos para la tos y comprar un inhibidor para los pulmones","Bronquitis").
tratamiento_enfermedad("Cubrir las ampollas para la piel y utilizar cremas para reducir la picazón","Varicela").
tratamiento_enfermedad("Someterse a una quimioterapia","Cancer").



% Hechos que me indican las áreas de afectación de cada enfermedad, una
% misma enfermedad puede atacar diferentes áreas del cuerpo

enfermedad_area("Gripe",respiracion).
enfermedad_area("Gripe",cuerpo).
enfermedad_area("Gripe",temperatura).
enfermedad_area("Virus Estomacal",estomago).
enfermedad_area("Virus Estomacal",temperatura).
enfermedad_area("Cancer",cuerpo).
enfermedad_area("Cancer",peso).
enfermedad_area("Cancer",temperatura).
enfermedad_area("Cancer",condicion_fisica).
enfermedad_area("Bronquitis",respiracion).
enfermedad_area("Bronquitis",cuerpo).
enfermedad_area("Bronquitis",pecho).
enfermedad_area("Varicela",piel).
enfermedad_area("Varicela",temperatura).


% Áreas de afectación de cada síntoma, en principio un sintoma solo
% puede atacar un área específica del cuerpo, sin embargo hay algunos
% sintomas que atacan varias áreas debido a la ambigüedad de los mismos
% (son el caso de dolor y perdida).

sintoma_area(tos,respiracion).
sintoma_area(fiebre,temperatura).
sintoma_area(cansancio,cuerpo).
sintoma_area(diarrea,estomago).
sintoma_area(vomito,estomago).
sintoma_area(dolor,estomago).
sintoma_area(dolor,cuerpo).
sintoma_area(perdida,peso).
sintoma_area(perdida,estomago).
sintoma_area(flema,pecho).
sintoma_area(picazon,piel).
sintoma_area(ampollas,piel).


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

lista_prevenciones(E,L):-findall(Prevencion,prevenir_enfermedad(E,Prevencion),L).

% Regla para relacionar el tratamiento con una enfermedad, se recibe
% como parámetro la enfermedad y devuelve en la variable T, el
% tratamiento respectivo para dicha enfermedad.

curar_enfermedad(E,T):-enfermedad(E),tratamiento_enfermedad(T,E).






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


saludo(hola).
saludo(saludos).
saludo(buenas).
saludo(buenos).

despedida(adios).
despedida(luego).

prev(prevenirla).
prev(prevenirlo).
prev(prevenir).
prev(prevencion).

trat(tratamiento).
trat(tratarlo).
trat(tratarla).
trat(tratar).
trat(curarme).
trat(cura).
trat(tomar).
trat(medicina).

caus(causa).













