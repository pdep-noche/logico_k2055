interseccion(Lista, OtraLista, Interseccion):-
    findall(Elem,(member(Elem, Lista), member(Elem, OtraLista)), Interseccion).

esCreciente([_]).
esCreciente([Cab, OtraCab| Cola]):- Cab < OtraCab, 
                esCreciente([OtraCab|Cola]).



sublistaMayoresA([], _, []).
sublistaMayoresA([Cab|Cola], Elem, [Cab|Resto]):-Elem < Cab,
            sublistaMayoresA(Cola,Elem, Resto).
sublistaMayoresA([_| Cola], Elem, Resto):-
            sublistaMayoresA(Cola, Elem, Resto).

genero(titanic,drama).
genero(gilbertGrape,drama).
genero(atrapameSiPuedes,comedia).
genero(ironMan,accion).
genero(rapidoYFurioso,accion).
genero(elProfesional,drama).

gusta(belen,titanic).
gusta(belen,gilbertGrape).
gusta(belen,elProfesional).
gusta(juan, ironMan).
gusta(pedro, atrapameSiPuedes).
gusta(pedro, rapidoYFurioso).

soloLeGustaPeliculasDeGenero(Persona, Genero):-
    persona(Persona), generoPelicula(Genero),
    forall(gusta(Persona, Pelicula), genero(Pelicula,Genero)).

persona(Persona):- gusta(Persona, _).
generoPelicula(Genero):-genero(_, Genero).

peliculasQueLeGustaPorGenero(Persona, Genero, ListaPeliculas):-
    persona(Persona), generoPelicula(Genero), 
    findall(Pelicula, leGustaPelicula(Persona, Genero, Pelicula),  ListaPeliculas).

leGustaPelicula(Persona, Genero, Pelicula):- gusta(Persona, Pelicula), 
    genero(Pelicula, Genero).

%lugar(nombre,hotel(nombre,cantEstrellas,montoDiario)%
lugar(marDelPlata, hotel(elViajante,4,1500)).
lugar(marDelPlata, hotel(casaNostra,3,1000)).
lugar(lasToninas, hotel(holidays,2,500)).
lugar(lasToninas, carpa(60)).
lugar(tandil,quinta(amanecer,pileta,650)).
lugar(bariloche,carpa(80)).
lugar(laFalda, casa(pileta,600)).
lugar(laFalda, carpa(70)).
lugar(rosario, casa(garaje,400)).

%puedeGastar(nombre,cantDias,montoTotal)%
puedeGastar(ana,4,10000).
puedeGastar(hernan,5,8000).
puedeGastar(mario,5,4000).


puedeIr(Persona, Lugar, Alojamiento):-
        puedeGastar(Persona, CantDias, Disponible),
        lugar(Lugar, Alojamiento), 
        montoDia(Alojamiento, MontoDia), 
        meAlcanza(Disponible, CantDias, MontoDia).

meAlcanza(Disponible,Dias, MontoDia):- 
        Dias * MontoDia =< Disponible.  

%Polimorfismo
montoDia(hotel(_, Estrellas, MontoDia), MontoDia):- 3 < Estrellas.
montoDia(casa(garaje, MontoDia), MontoDia).
montoDia(quinta(_, pileta, MontoDia),MontoDia).
montoDia(carpa(Monto), Monto).

puedeIrACualquierLugar(Persona):-puedeGastar(Persona, _,  _),
    forall(lugar(Lugar, _), puedeIr(Persona, Lugar, _)).


