"INDEKSY:"
" 198035 "
" 198202 "
" 189507 "


Object subclass: #Wielokat
	instanceVariableNames: 'wierzcholki nazwa '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'JezykiProgramowania'!

!Wielokat methodsFor: 'initialize-release'!

initialize: liczbaWierzcholkow name: nowaNazwa
	"konstruktor obiektu - wielokata"

	nazwa:=nowaNazwa.
	wierzcholki:=Array new: liczbaWierzcholkow.
	wierzcholki at: 1 put: 0@0.! !

!Wielokat methodsFor: 'accessing'!

nazwa
	"podaje nazwe wielokata"

	^nazwa!

nazwa: nowa_nazwa
	"ustawia nowa nazwe wielokata"

	nazwa:=nowa_nazwa! !



Wielokat subclass: #Kwadrat
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'JezykiProgramowania'!


!Kwadrat methodsFor: 'arithmetic'!

+ figura
	"dodaj 2 figury w sensie pola"

	| p |

	p:=self pole + figura pole.
	^(Kwadrat new) initialize: p sqrt! !

!Kwadrat methodsFor: 'actions'!

pole
	"licz pole kwadratu"
    
	^(wierzcholki at: 2) x squared! !

!Kwadrat methodsFor: 'initialize-release'!

initialize: bok
	"tworz kwadrat o podanym boku"

	super initialize: 4 name: 'Kwadrat'.
	wierzcholki at: 2 put: bok@0.
	wierzcholki at: 3 put: bok@bok.
	wierzcholki at: 4 put: 0@bok.! !
	


Wielokat subclass: #SzeciokatForemny
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'JezykiProgramowania'!


!SzeciokatForemny methodsFor: 'arithmetic'!

+ figura
    "Dodaj dwa sześciokąty foremne w sensie pola, tworząc nową figurę o polu równym sumie pól obu sześciokątów."
    
    | nowePole nowyBok |
    
    "Obliczamy pole nowej figury"
    nowePole := self pole + figura pole.
    
    "Obliczamy długość boku nowej figury, zakładając, że nowy sześciokąt ma proporcje odbiorcy komunikatu"
    nowyBok := ((2 * nowePole) / (3 * (3 sqrt))) sqrt.
    
    "Tworzymy nowy sześciokąt foremny o odpowiedniej długości boku"
    ^(SzeciokatForemny new) initialize: nowyBok.
! !

!SzeciokatForemny methodsFor: 'actions'!

pole
    "Oblicza pole sześciokąta foremnego"
  
    | bok pole |
    bok := (wierzcholki at: 2) x.
    pole := (3 * (3 sqrt) * (bok squared)) / 2.
    ^pole.
! !

!SzeciokatForemny methodsFor: 'initialize-release'!

initialize: bok
	"tworz kwadrat o podanym boku"

	super initialize: 6 name: 'SzeciokatForemny'.
	wierzcholki at: 2 put: bok@0.
	wierzcholki at: 3 put: (bok + (bok * 0.5))@(bok * (3 sqrt)/2).
	wierzcholki at: 4 put: bok@(bok * (3 sqrt)).
	wierzcholki at: 5 put: 0@(bok * (3 sqrt)).
	wierzcholki at: 6 put: (bok * 0.5 * (-1))@(bok * (3 sqrt)/2).! !


| szesciokat1 szesciokat2 wynikowaFigura |

szesciokat1 := SzeciokatForemny new initialize: 5.
szesciokat2 := SzeciokatForemny new initialize: 7.

Transcript show: 'Pole szesciokata o boku 5: ', (szesciokat1 pole asString); cr.
Transcript show: 'Pole szesciokata o boku 7: ', (szesciokat2 pole asString); cr.

wynikowaFigura := szesciokat1 + szesciokat2.

Transcript show: 'Pole wynikowej figury: ', (wynikowaFigura pole asString); cr.
