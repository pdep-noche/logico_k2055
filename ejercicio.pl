mortal(Persona):-humano(Persona).
humano(socrates).
humano(platon).


habla(juan, espaniol).
habla(juan, ingles).
habla(juan, italiano).
habla(marcela, espaniol).
habla(hernan , aleman).

seComunican(Persona,OtraPersona):- habla(Persona,Idioma), habla(OtraPersona,Idioma), Persona \= OtraPersona.

siguiente(Numero, Siguiente):-numero(Numero), Siguiente is Numero + 1.

numero(Numero):-between(1,10,Numero).

mayor(Mayor, Menor):-numero(Mayor), numero(Menor),Mayor>Menor.


quiere(juan ,playa).
quiere(juan , wifi).
quiere(juan , teatro).
quiere(ana ,  sierra). 
quiere(ana ,playa).

lugar(mardel , playa).
lugar(mardel , wifi).
lugar(mardel , teatro).
lugar(mardel ,casino).
lugar(tandil ,sierra).
lugar(tandil , teatro).

tieneTodoParaVeranear(Lugar, Persona):-lugarVeraneo(Lugar), persona(Persona), forall(quiere(Persona, Algo), lugar(Lugar,Algo)).

lugarVeraneo(Lugar):- lugar(Lugar,_).
persona(Persona):- quiere(Persona,_).


contador(roque).
joven(roque).
trabajoEn(roque,acme).
trabajoEn(silvia,acme).
trabajoEn(ana,omni).
trabajoEn(lucia,omni).
trabajoEn(pablo, fiat).
honesto(roque).
ingeniero(ana).
ingeniero(silvia).
habla(roque,frances).
habla(ana,ingles).
habla(ana,frances).
habla(lucia,ingles).
habla(lucia,frances).
habla(cecilia,frances).
abogado(cecilia).
ambicioso(cecilia).
ambicioso(pablo).
ambicioso(Persona):-contador(Persona),joven(Persona).
tieneExperiencia(Persona):-trabajoEn(Persona, _).
esProfesional(Persona):-abogado(Persona).
esProfesional(Persona):-contador(Persona).
esProfesional(Persona):-ingeniero(Persona).
puedeAndar(comercioExterior, Persona):-ambicioso(Persona).
puedeAndar(contaduria, Persona):-contador(Persona),honesto(Persona).
puedeAndar(ventas, Persona):-ambicioso(Persona),tieneExperiencia(Persona).
puedeAndar(ventas, lucia).
puedeAndar(proyectos, Persona):-ingeniero(Persona), tieneExperiencia(Persona).
puedeAndar(proyectos, Persona):-abogado(Persona), joven(Persona).        
puedeAndar(logistica, Persona):-esProfesional(Persona), cumpleCondicion(Persona).
cumpleCondicion(Persona):- joven(Persona).
cumpleCondicion(Persona):- trabajoEn(Persona, omni).