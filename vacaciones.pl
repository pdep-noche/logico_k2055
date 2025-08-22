%viajo(persona, lugar).
viajo(dodain, pehuenia).
viajo(dodain, sanMartin).
viajo(dodain, esquel).
viajo(dodain, sarmiento).
viajo(dodain, camarones).
viajo(dodain, playasDoradas).
viajo(alf, sanMartin).
viajo(alf, bariloche).
viajo(alf, elBolson).
viajo(nico, marDelPlata).
viajo(vale, calafate).
viajo(vale, elBolson).
viajo(martu, Lugar):-viajo(nico, Lugar).
viajo(martu, Lugar):-viajo(alf, Lugar).

%Punto 2
%atraccion(Lugar, Atraccion)
atraccion(esquel, parqueNacional(losAlerces)).
atraccion(esquel, excursion(trochita)).
atraccion(esquel, excursion(trevelin)).
atraccion(pehuenia, cerro(bateaMahuida, 2000)).
atraccion(pehuenia, cuerpoDeAgua(moquehue,puedePescar,14)).
atraccion(pehuenia, cuerpoDeAgua(alumine, puedePescar, 19)).

persona(Persona):- viajo(Persona, _).

vacacionesCopadas(Persona):-persona(Persona), 
    forall(viajo(Persona, Lugar), tieneAtraccionCopada(Lugar)).

tieneAtraccionCopada(Lugar):-atraccion(Lugar, Atraccion), 
    esCopada(Atraccion).

% esCopada/1 es un predicado Polimorfico
esCopada(cerro(_, Altura)):- Altura > 2000.
esCopada(cuerpoDeAgua(_, puedePescar, _)).
esCopada(cuerpoDeAgua(_, _, Temperatura)):-Temperatura > 20.
esCopada(playa(Diferencia)):- 5 > Diferencia.
esCopada(excursion(Nombre)):- atom_length(Nombre, Length), Length > 7.
esCopada(parqueNacional(_)).

%Punto 3
noSeCruzo(Persona, OtraPersona):- persona(Persona),
    persona(OtraPersona), 
    not((viajo(Persona, Lugar), viajo(OtraPersona, Lugar))).

%Punto 4
vacacionesGasoleras(Persona):- persona(Persona), 
    forall(viajo(Persona, Lugar), esLugarGasolero(Lugar)).

esLugarGasolero(Lugar):- costoVida(Lugar, Costo), 160 > Costo.

costoVida(sarmiento, 100).
costoVida(esquel, 150).
costoVida(pehuenia, 180).
costoVida(sanMartin, 150).
costoVida(camarones, 135).
costoVida(playasDoradas, 170).
costoVida(bariloche, 140).
costoVida(elCalafate, 240).
costoVida(elBolson, 145).
costoVida(marDelPlata, 140).

%Punto 5
itinerariosPosibles(Persona, Lista):-persona(Persona), 
    findall(Lugar, viajo(Persona, Lugar), ListaLugares), 
    permutacion(ListaLugares, Lista).

permutacion([], []).
permutacion(Lista, [Elem|OtraLista]):- eliminar(Elem, Lista, Rest), 
            permutacion(Rest, OtraLista).

eliminar(Elem,[Elem|Resto], Resto).
eliminar(Elem, [OtroElem|Lista], [OtroElem| Resto]):- eliminar(Elem, Lista, Resto).
    
