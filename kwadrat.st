"INDEKSY:"
" 198035 "
" 198202 "
" 189507 "


Object subclass: #Wielokat
	instanceVariableNames: 'wierzcholki nazwa bok obrot'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'JezykiProgramowania'!

!Wielokat methodsFor: 'initialize-release'!

initialize: liczbaWierzcholkow name: nowaNazwa
	"konstruktor obiektu - wielokata"

	nazwa:=nowaNazwa.
	wierzcholki:=Array new: liczbaWierzcholkow.
	wierzcholki at: 1 put: 0@0.
	obrot:=0.! !

!Wielokat methodsFor: 'accessing'!

nazwa
	"podaje nazwe wielokata"

	^nazwa!

nazwa: nowa_nazwa
	"ustawia nowa nazwe wielokata"

	nazwa:=nowa_nazwa!
	
bok
    ^bok.!

bok: nowyBok
    bok := nowyBok.!
    
obrot
    ^obrot.!

obrot: nowyObrot
    obrot := nowyObrot.! !

!Wielokat methodsFor: 'actions'!

pole
    "Abstrakcyjna metoda pole; musi być nadpisana w podklasach."
    self error: 'Metoda pole musi być zaimplementowana w podklasach'.
! !

!Wielokat methodsFor: 'actions'!

drukuj
    | polowaWierzcholkow srodkowyWierzcholek sumaX sumaY |
    Transcript show: 'Wspolrzedne wierzcholkow figury: ', (self nazwa) asString; cr.
    wierzcholki do: [:wierzcholek |
        Transcript show: '(', wierzcholek x asString, ', ', wierzcholek y asString, ')'; cr.
    ].
    Transcript show: 'Pole figury: ', (self pole) asString; cr.
    
    "Sprawdź czy figura jest wyśrodkowana"
    polowaWierzcholkow := wierzcholki size // 2.
    srodkowyWierzcholek := wierzcholki at: (polowaWierzcholkow + 1).
    
    sumaX := ((wierzcholki first) x + (srodkowyWierzcholek x)).
    sumaY := ((wierzcholki first) y + (srodkowyWierzcholek y)).
    
    (sumaX = 0 and: [sumaY = 0])
        ifTrue: [Transcript show: 'Figura jest wyśrodkowana.'; cr]
        ifFalse: [Transcript show: 'Figura nie jest wyśrodkowana.'; cr].
        
    Transcript show: 'Figura została obrócona o ',  (self obrot) asString, ' stopni względem pozycji startowej.'; cr.
!


    
obroc: kat
    "Obraca wielokąt o zadany kąt w prawo, jeśli kąt jest w zakresie 0 < kat <= 90."
    | radiany polowaWierzcholkow srodkowyWierzcholek srodekX srodekY nowyObrot|
    (kat > 0 and: [kat <= 90]) ifTrue: [
        polowaWierzcholkow := wierzcholki size // 2.
        srodkowyWierzcholek := wierzcholki at: (polowaWierzcholkow + 1).
    
        srodekX := ((wierzcholki first) x + (srodkowyWierzcholek x))/2.
        srodekY := ((wierzcholki first) y + (srodkowyWierzcholek y))/2.
        radiany := kat degreesToRadians.
        "Przesuwany figurę na środek ukladu współrzędnych do obliczeń"
        wierzcholki do: [:wierzcholek |
        
            wierzcholek x: wierzcholek x - srodekX.
            wierzcholek y: wierzcholek y - srodekY.
        ].
         "Aktualizacja współrzędnych każdego wierzchołka"
        wierzcholki do: [:wierzcholek |
            | x y nowyX nowyY |
            x := wierzcholek x.
            y := wierzcholek y.
            
            "Obliczanie nowych współrzędnych po obrocie"
            nowyX := (x * radiany cos) + (y * radiany sin).
            nowyY := (-1)*(x * radiany sin) + (y * radiany cos).
            
            "Aktualizacja współrzędnych wierzchołka"
            wierzcholek x: nowyX.
            wierzcholek y: nowyY.
        ].
        "Przesuwamy figurę z powrotem na jej miejsce"
        wierzcholki do: [:wierzcholek |
        
            wierzcholek x: wierzcholek x + srodekX.
            wierzcholek y: wierzcholek y + srodekY.
        ].
        "Aktualizacja wartości obrot - wykorzystujemy w komunikacie drukuj"
        nowyObrot := self obrot + kat.
        self obrot: nowyObrot.
        
    ] ifFalse: [
        Transcript show: 'Kąt poza zakresem!'; cr.
    ].
! !

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
    
	^bok squared! 
	

wysrodkuj
    "Przesun figure na srodek ukladu wspolrzednych"
    | przesuniecie |
    przesuniecie := bok / 2.
    wierzcholki do: [:wierzcholek |
        wierzcholek x: wierzcholek x - przesuniecie.
        wierzcholek y: wierzcholek y - przesuniecie.
    ].! !


!Kwadrat methodsFor: 'initialize-release'!

initialize: bok
	"tworz kwadrat o podanym boku"

	super initialize: 4 name: 'Kwadrat'.
	self bok: bok. "Ustawienie boku kwadratu"
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
  
    | pole |
    
    pole := (3 * (3 sqrt) * (bok squared)) / 2.
    ^pole.
! 

wysrodkuj
    "Przesun figure na srodek ukladu wspolrzednych"
    | przesuniecieX przesuniecieY|
    przesuniecieX := bok / 2.
    przesuniecieY := bok*(3 sqrt) / 2.
    wierzcholki do: [:wierzcholek |
        wierzcholek x: wierzcholek x - przesuniecieX.
        wierzcholek y: wierzcholek y - przesuniecieY
    ].! !

!SzeciokatForemny methodsFor: 'initialize-release'!

initialize: bok
	"tworz sześciokąt o podanym boku"

	super initialize: 6 name: 'SzesciokatForemny'.
	self bok: bok. "Ustawienie boku sześciokąta"
	wierzcholki at: 2 put: bok@0.
	wierzcholki at: 3 put: (bok * 1.5)@(bok * (3 sqrt)/2).
	wierzcholki at: 4 put: bok@(bok * (3 sqrt)).
	wierzcholki at: 5 put: 0@(bok * (3 sqrt)).
	wierzcholki at: 6 put: (bok * 0.5 * (-1))@(bok * (3 sqrt)/2).! !


| szesciokat1 szesciokat2 wynikowaFigura |

szesciokat1 := SzeciokatForemny new initialize: 5.
szesciokat2 := SzeciokatForemny new initialize: 7.

kwadrat1 := Kwadrat new initialize: 4.

kwadrat1 drukuj.
kwadrat1 wysrodkuj.

kwadrat1 obroc: 90.
kwadrat1 drukuj.

kwadrat1 obroc: 30.
kwadrat1 drukuj.

kwadrat1 obroc: 130.
kwadrat1 drukuj.

szesciokat1 drukuj.
szesciokat1 wysrodkuj.

szesciokat1 drukuj.
szesciokat1 obroc: 60.

szesciokat1 drukuj.

Transcript show: 'Pole szesciokata o boku 5: ', (szesciokat1 pole asString); cr.
Transcript show: 'Pole szesciokata o boku 7: ', (szesciokat2 pole asString); cr.

wynikowaFigura := szesciokat1 + szesciokat2.

Transcript show: 'Pole wynikowej figury: ', (wynikowaFigura pole asString); cr.
