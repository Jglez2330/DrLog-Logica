%Lista de enfermedades, las enfermedades se tratan como strings

enfermedad("Gripe").
enfermedad("Virus Estomacal").
enfermedad("Cancer").
enfermedad("Bronquitis").
enfermedad("Varicela").
enfermedad("thanos").

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
sintoma(muerte).
sintoma(polvo).
sintoma(inexistencia).


% Lista de Causas para cada enfermedad, El primer string del hecho es la
% causa (la cuál es propia y única para cada enfermedad), el segundo
% string indica a cuál enfermedad pertenece dicha causa.


causa("La gripe es causada por el virus de la influenza","Gripe").
causa("El virus que causa la varicela es el virus varicela zóster","Varicela").
causa("El virus estomacal es causado por el norovirus y el rotavirus ","Virus Estomacal").
causa("Los mismos virus que causan los resfriados y la gripe son la causa más frecuente de la bronquitis","Bronquitis").
causa("Por lo general el cancer lo provocan mutaciones geneticas","Cancer").
causa("gemas","thanos").



%Lista de prevenciones

prevencion("Lavarse las manos").
prevencion("Cubrise la boca al toser").
prevencion("Usar desinfectante para manos").
prevencion("Desinfectar superficies y objetos del hogar").
prevencion("Hacer ejercicio con frecuencia").
prevencion("Tener buena alimentación").
prevencion("Evitar los vicios como alcohol o cigarros").
prevencion("ninguna").
prevencion("matar a thanos").
prevencion("no existir").


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
prevencion_area("ninguna",muerte).
prevencion_area("matar a thanos",polvo).
prevencion_area("no existir",inexistencia).

% Hechos que me indican si una enfermedad tiene tratamiento previo, para
% incluirlos también en la lista de prevenciones de cada enfermedad. El
% primer string es el nombre de la enfermedad y el segundo el
% tratamiento.

tratamiento_previo("Gripe","Vacunarse todos los años").
tratamiento_previo("Bronquitis","Ponerse la vacuna para la gripe todos los años").
tratamiento_previo("Varicela","Vacunarse contra el virus que produce la varicela").
tratamiento_previo("thanos","matar a thanos").


% Lista de tratamientos posteriores a la enfermedad, el hecho los asocia
% directamente con la enfermedad (segundo parámetro) ya que los
% tratamientos son únicos para cada tipo de enfermedad de la base de
% datos


tratamiento_enfermedad("Tomar antigripal por una semana y tomar líquidos en abundancia","Gripe").
tratamiento_enfermedad("Ingerir alimentos blandos y mantenerse hidratado","Virus Estomacal").
tratamiento_enfermedad("Consumir medicamentos para la tos y comprar un inhibidor para los pulmones","Bronquitis").
tratamiento_enfermedad("Cubrir las ampollas para la piel y utilizar cremas para reducir la picazón","Varicela").
tratamiento_enfermedad("Someterse a una quimioterapia","Cancer").
tratamiento_enfermedad("ninguno","thanos").



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
enfermedad_area("thanos",cabeza).
enfermedad_area("thanos",torso).
enfermedad_area("thanos",piernas).


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
sintoma_area(muerte, cabeza).
sintoma_area(polvo, torso).
sintoma_area(inexistencia, piernas).

% ------------------------------------------------------------------------
% Palabras para el BNF
nombre([hombre|A],A).
nombre([cancer|A],A).
nombre([yo|A],A).
nombre([doctor|A],A).
nombre([drlog|A],A).
nombre([fiebre|A],A).
nombre([cansancio|A],A).
nombre([tos|A],A).
nombre([diarrea|A],A).
nombre([dolor|A],A).
nombre([vomito|A],A).
nombre([flema|A],A).
nombre([perdida|A],A).
nombre([ampollas|A],A).
nombre([garganta|A],A).
nombre([cabeza|A],A).
nombre([espalda|A],A).
nombre([estomago|A],A).
nombre([virus|A],A).
nombre([manos|A],A).
nombre([ojos|A],A).
nombre([nariz|A],A).
nombre([bronquitis|A],A).
nombre([varicela|A],A).
nombre([enfermedad|A],A).
nombre([tratamiento|A],A).
nombre([prevencion|A],A).
nombre([cura|A],A).


verbo([tiene|A],A).
verbo([tengo|A],A).
verbo([duele|A],A).
verbo([curar|A],A).
verbo([tratar|A],A).
verbo([prevenir|A],A).


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
caus(provoca).



