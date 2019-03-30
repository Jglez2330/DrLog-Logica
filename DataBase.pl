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

nombre([hombre|A],A).
nombre([manzana|A],A).
nombre([cancer|A],A).
nombre([yo|A],A).
nombre([tengo|A],A).
nombre([gripe|A],A).

nombre([tos|A],A).
nombre([fiebre|A],A).
nombre([cansancio|A],A).
nombre([enfermedad|A],A).



verbo([come|A],A).
verbo([canta|A],A).
verbo([tiene|A],A).
verbo([tengo|A],A).

% -----------------------------------------------------------------------------
% Palabras clave de usuario
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
