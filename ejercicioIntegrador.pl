%viveEn(rata, restaurante)
viveEn(remy, gusteaus).     
viveEn(emile,chezMilleBar).
viveEn(django, pizzeriaJeSuis).

%sabeCocinar(persona, comida, experiencia)
sabeCocinar(linguini, ratatouille , 3).
sabeCocinar(linguini, sopa, 5).
sabeCocinar(colette, salmonAsado, 9).
sabeCocinar(horst, ensaladaRusa, 8).

%trabaja(persona, lugar)
trabaja(linguini, gusteaus).
trabaja(colette, gusteaus).
trabaja(horst, gusteaus).
trabaja(skinner, gusteaus).
trabaja(amilie, cafeSdes2Moulins).

%1
estaEnMenu(Plato, Restaurante):-
    sabeCocinar(Persona, Plato, _), 
    trabaja(Persona, Restaurante).    

%2
cocinaBien(Persona, Plato):- sabeCocinar(Persona, Plato, Experiencia), 
    7 < Experiencia.
cocinaBien(Persona, Plato):- sabeCocinar(Persona, Plato, _), 
tieneTutor(Persona, Tutor), cocinaBien(Tutor, Plato).
cocinaBien(remy, Plato):- sabeCocinar(_, Plato, _).

%tieneTutor(Cocinero, Tutor)
tieneTutor(linguini, Rata):-viveEn(Rata, Restaurante),
        trabaja(linguini, Restaurante).
tieneTutor(amilie, skinner).

%3
esChef(Cocinero, Restaurante):-
    trabaja(Cocinero, Restaurante), 
    cumpleCondiciones(Cocinero, Restaurante).

cumpleCondiciones(Cocinero, Restaurante):- 
    forall(estaEnMenu(Plato, Restaurante), cocinaBien(Cocinero, Plato)).
cumpleCondiciones(Cocinero, _):-totalExperiencia(Cocinero, Total), 20 < Total.
totalExperiencia(Cocinero,Total):-
    findall(Experiencia, sabeCocinar(Cocinero, _, Experiencia), ListaExperiencias), 
    sumlist(ListaExperiencias, Total).
    

%4
encargada(Persona, Restaurante, Plato):- 
    experienciaEnResto(Persona, Plato, Restaurante, Experiencia), 
    forall(experienciaEnResto(_, Plato, Restaurante, OtraExperiencia), 
      OtraExperiencia =< Experiencia).

experienciaEnResto(Persona, Plato, Resto, Experiencia):- 
    trabaja(Persona, Resto), sabeCocinar(Persona, Plato, Experiencia).

%5
plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 2)).
plato(frutillasConCrema, postre(265)).

esSaludable(NombrePlato):- plato(NombrePlato, TipoPlato), 
    cantCalorias(TipoPlato, Calorias), Calorias < 75.

cantCalorias(entrada(Ingredientes), TotalCalorias):-
    length(Ingredientes, Cantidad), TotalCalorias is Cantidad * 15.
cantCalorias(principal(Guarnicion, Tiempo), TotalCalorias):-
    caloriasGuarnicion(Guarnicion, Calorias), 
    TotalCalorias is Calorias + (Tiempo * 5).
cantCalorias(postre(TotalCalorias),TotalCalorias).

caloriasGuarnicion(papaFritas, 50).
caloriasGuarnicion(pure, 20).
caloriasGuarnicion(ensalada, 0).