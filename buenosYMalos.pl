%gusto(persona, hábito)
gusto(julia,estudiar(ssoo,2)).
gusto(julia,jugar(lol,7)).
gusto(marcos,criticarA(nacho)).
gusto(pedro,practicarDeporte(futbol,2)).
gusto(nacho,jugar(minecraft,6)).
gusto(nacho,jugar(lol,6)).
gusto(nacho,criticarA(camila)).
gusto(sofia,estudiar(pdep,3)).
gusto(sofia,jugar(minecraft,4)).
gusto(camila,estudiar(pdep, 2)).
gusto(camila,practicaDeporte(natacion, 3)).
gusto(martin, criticarA(Persona)):-gusto(Persona, jugar(_, Horas)),
                Horas > 4.
gusto(camila, Algo):- gusto(sofia, Algo), not(gusto(julia, Algo)).
gusto(laura, jugar(minecraft, 3)).


%% Punto2
eslaPerdicion(Persona):-persona(Persona), 
    forall(gusto(Persona, Algo), malHabito(Algo)).

persona(Persona):- gusto(Persona, _).

malHabito(jugar(_, Cant)):- Cant > 5.
malHabito(criticarA(Persona)):-gusto(Persona, estudiar(pdep, _)).

%%Punto 3
esVago(Persona):-persona(Persona),
    not(gusto(Persona, estudiar(_, _))),
    juegaATodosLosJuegos(Persona).

juegaATodosLosJuegos(Persona):-
    forall(juego(Juego), gusto(Persona, jugar(Juego, _))).

juego(Juego):-gusto(_, jugar(Juego, _)).

%% Punto 4
esFeliz(Persona):-persona(Persona), consumoDeHoras(Persona, Horas), 
                   Horas  > 8.

consumoDeHoras(Persona, TotalDeHoras):-
    findall(CantHoras, horasPorGusto(Persona, CantHoras),  ListaHoras), 
    sumlist(ListaHoras, TotalDeHoras).

horasPorGusto(Persona, CantHoras):- gusto(Persona, Algo), 
            horasDeConsumo(Algo, CantHoras).

%Polimorfismo
horasDeConsumo(estudiar(_, Horas), Horas).
horasDeConsumo(jugar(_, Horas), Horas).
horasDeConsumo(practicaDeporte(_, Horas), Horas).
horasDeConsumo(criticarA(_), 1).

%% Punto 5
tieneUnicoHabitoSaludable(Persona):- gusto(Persona, Habito), 
        esSaludable(Habito), 
        forall(gusto(Persona, OtroHabito), iguales(Habito, OtroHabito)).

iguales(Habito, Habito).

esSaludable(estudiar(_, _)).
esSaludable(practicarDeporte(_, _)).

amigo(julia, marcos).
amigo(marcos, pedro).
amigo(pedro, nacho).
amigo(pedro, sofia).
amigo(sofia, camila).
amigo(sofia, martin).

mantenerAlejado(Persona, OtraPersona):- persona(Persona), 
    persona(OtraPersona), 
    not(malaInfluencia(Persona)), sonAmigos(Persona, OtraPersona), 
    malaInfluencia(OtraPersona).

malaInfluencia(Persona):- esVago(Persona).
malaInfluencia(Persona):- eslaPerdicion(Persona).

sonAmigos(Persona, OtraPersona):-amigo(Persona, OtraPersona).
sonAmigos(Persona, OtraPersona):-amigo(Persona, UnAmigo), 
        sonAmigos(UnAmigo, OtraPersona).



