%Lista de enfermedades, las enfermedades se tratan como strings

enfermedad("Gripe").
enfermedad("Virus Estomacal").
enfermedad("Cancer").
enfermedad("Bronquitis").
enfermedad("Varicela").

% Lista de sintomas, de momento los sintomas son tratados como atomos de
% prolog, sin embargo hay algunos que pueden quedar ambig�os como dolor
% (puede ser dolor de cuerpo, dolor de est�mago,etc), igual sucede con
% p�rdida (p�rdida de apetito, p�rdida de peso).Se puede cambiar a
% string para solucionar la ambig�edad pero se debe recibir el string
% completo de la comunicaci�n con el usuario

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
% causa (la cu�l es propia y �nica para cada enfermedad), el segundo
% string indica a cu�l enfermedad pertenece dicha causa.


causa("La gripe es causada por el virus de la influenza","Gripe").
causa("El virus que causa la varicela es el virus varicela z�ster","Varicela").
causa("El virus estomacal es causado por el norovirus y el rotavirus ","Virus Estomacal").
causa("Los mismos virus que causan los resfriados y la gripe son la causa m�s frecuente de la bronquitis","Bronquitis").
causa("Por lo general el cancer lo provocan mutaciones geneticas","Cancer").


%Lista de prevenciones

prevencion("Lavarse las manos").
prevencion("Cubrise la boca al toser").
prevencion("Usar desinfectante para manos").
prevencion("Desinfectar superficies y objetos del hogar").
prevencion("Hacer ejercicio con frecuencia").
prevencion("Tener buena alimentaci�n").
prevencion("Evitar los vicios como alcohol o cigarros").


% Hechos que me asocian una prevenci�n, con el �rea del cuerpo a la
% cu�l va dirigida la prevenci�n

prevencion_area("Lavarse las manos",estomago).
prevencion_area("Lavarse las manos",respiracion).
prevencion_area("Cubrise la boca al toser",respiracion).
prevencion_area("Usar desinfectante para manos",estomago).
prevencion_area("Desinfectar superficies y objetos del hogar",estomago).
prevencion_area("Hacer ejercicio con frecuencia",condicion_fisica).
prevencion_area("Tener buena alimentaci�n",peso).
prevencion_area("Evitar los vicios como alcohol o cigarros",condicion_fisica).


% Hechos que me indican si una enfermedad tiene tratamiento previo, para
% incluirlos tambi�n en la lista de prevenciones de cada enfermedad. El
% primer string es el nombre de la enfermedad y el segundo el
% tratamiento.

tratamiento_previo("Gripe","Vacunarse todos los a�os").
tratamiento_previo("Bronquitis","Ponerse la vacuna para la gripe todos los a�os").
tratamiento_previo("Varicela","Vacunarse contra el virus que produce la varicela").


% Lista de tratamientos posteriores a la enfermedad, el hecho los asocia
% directamente con la enfermedad (segundo par�metro) ya que los
% tratamientos son �nicos para cada tipo de enfermedad de la base de
% datos


tratamiento_enfermedad("Tomar antigripal por una semana y tomar l�quidos en abundancia","Gripe").
tratamiento_enfermedad("Ingerir alimentos blandos y mantenerse hidratado","Virus Estomacal").
tratamiento_enfermedad("Consumir medicamentos para la tos y comprar un inhibidor para los pulmones","Bronquitis").
tratamiento_enfermedad("Cubrir las ampollas para la piel y utilizar cremas para reducir la picaz�n","Varicela").
tratamiento_enfermedad("Someterse a una quimioterapia","Cancer").



% Hechos que me indican las �reas de afectaci�n de cada enfermedad, una
% misma enfermedad puede atacar diferentes �reas del cuerpo

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


% �reas de afectaci�n de cada s�ntoma, en principio un sintoma solo
% puede atacar un �rea espec�fica del cuerpo, sin embargo hay algunos
% sintomas que atacan varias �reas debido a la ambig�edad de los mismos
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
% enviar la informaci�n correspondiente al usuario

% Regla que me relaciona un solo sintoma con una enfermedad, la variable
% S se refiere a sintoma y la variable E se refiere a enfermedad, la
% regla primero verifica que efectivamente se traten de sintomas y
% enfermedades de la base de datos, y luego hace la relaci�n verificando
% que el �rea de afectaci�n del sintoma concuerde con una de las �reas
% de afectaci�n de la enfermedad

sintoma_de(S,E):-sintoma(S),enfermedad(E),sintoma_area(S,Y),enfermedad_area(E,Y).


% Regla que me relaciona tres sintomas con una enfermedad, los tres
% sintomas son ingresados de la comunicaci�n con el usuario y en la
% variable E se almacena la enfermedad correspondiente

sintomas_de(S1,S2,S3,E):-sintoma_de(S1,E),sintoma_de(S2,E),sintoma_de(S3,E).


% Regla para relacionar una enfermedad con una causa, la enfermedad se
% recibe como par�metro y la regla instancia en la variable C la causa
% correspondiente

causa_enfermedad(E,C):-enfermedad(E),causa(C,E).

% Reglas para obtener las formas de prevenci�n de una enfermedad, la
% regla de prevenir_enfermedad liga una enfermedad con una forma de
% prevenci�n (si existe tratamiento previo tambi�n se incluye) de
% acuerdo con el �rea de afectaci�n. La regla lista_prevenciones recibe
% una enfermedad como par�metro de entrada e instancia en la variable L
% la lista con todas las posibles prevenciones para dicha enfermedad.

prevenir_enfermedad(E,P):-enfermedad(E),tratamiento_previo(E,P).
prevenir_enfermedad(E,P):-enfermedad(E),prevencion(P),enfermedad_area(E,X),prevencion_area(P,X).

lista_prevenciones(E,L):-findall(Prevencion,prevenir_enfermedad(E,Prevencion),L).

% Regla para relacionar el tratamiento con una enfermedad, se recibe
% como par�metro la enfermedad y devuelve en la variable T, el
% tratamiento respectivo para dicha enfermedad.

curar_enfermedad(E,T):-enfermedad(E),tratamiento_enfermedad(T,E).





