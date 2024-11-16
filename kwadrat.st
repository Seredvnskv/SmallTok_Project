"INDEKSY:"
" 198035 "
" 198202 "
" 189507 "


Object subclass: #Wielokat
	instanceVariableNames: 'wierzcholki nazwa bok obrot wysrodkowana'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'JezykiProgramowania'!

!Wielokat methodsFor: 'initialize-release'!

initialize: liczbaWierzcholkow name: nowaNazwa
	"konstruktor obiektu - wielokata"

	nazwa:=nowaNazwa.
	wierzcholki:=Array new: liczbaWierzcholkow.
	wierzcholki at: 1 put: 0@0.
	obrot:=0.
	wysrodkowana:=false.
    Transcript show: 'Utworzono nową figurę: '; cr.

	!!

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
    "Podaje wartość kąta o który figura została obrócona"
    ^obrot.!

obrot: nowyObrot
    "ustawia wartość kąta obrotu"
    obrot := nowyObrot.! 
    
wysrodkowana
    "zwraca info czy figura została wyśrodkowana"
    ^wysrodkowana.!

srodekX
    "Zwraca wartość współrzędnej X środka figury"
    
    ^wysrodkowana
        ifTrue: [0]
        ifFalse: [bok / 2].!!


!Wielokat methodsFor: 'actions'!

srodekY
    self error: 'Metoda srodekY musi być zaimplementowana w podklasach'.!

pole
    "Abstrakcyjna metoda pole; musi być nadpisana w podklasach."
    self error: 'Metoda pole musi być zaimplementowana w podklasach'.
! !

!Wielokat methodsFor: 'actions'!

drukuj
    | sumaX sumaY |
    Transcript show: 'Nazwa figury: ', (self nazwa) asString; cr.
    Transcript show: 'Długość boku: ', (self bok) asString; cr.
    Transcript show: 'Pole figury: ', (self pole) asString; cr.

    Transcript show: 'Wierzchołki: '; cr.
    wierzcholki do: [:wierzcholek |
        Transcript show: '(', wierzcholek x asString, ', ', wierzcholek y asString, ')'; cr.
    ].
    
    wysrodkowana
        ifTrue: [Transcript show: 'Figura jest wyśrodkowana.'; cr]
        ifFalse: [Transcript show: 'Figura nie jest wyśrodkowana.'; cr].
        
    Transcript show: 'Figura została obrócona o ', (self obrot )asString, ' stopni względem pozycji startowej.'; cr; cr.
!

wysrodkuj
"Przesun figure na srodek ukladu wspolrzednych, jeśli nie jest jeszcze wysrodkowana."
    wysrodkowana ifFalse: [
        | dX dY |
        dX := self srodekX.
        dY := self srodekY.
        wierzcholki do: [:wierzcholek |
            wierzcholek x: wierzcholek x - dX.
            wierzcholek y: wierzcholek y - dY
        ].
        wysrodkowana := true.
        Transcript show: 'Wysrodkowuję ', (self nazwa )asString; cr; cr.

    ].!
    
obroc: kat
    "Obraca wielokąt o zadany kąt w prawo (zgodnie z ruchem wskazówek zegara),
     jeśli kąt jest w zakresie 0 < kat <= 90."

    | sX sY radiany|
    (kat > 0 and: [kat <= 90]) ifTrue: [
        "Przekształcenie kąta na radiany"
        radiany := kat degreesToRadians.

        "środek wielokąta"
        sX := self srodekX.
        sY := self srodekY.

        "Obrót każdego wierzchołka"
        wierzcholki do: [:wierzcholek |
            | x y nowyX nowyY |
            
            "Przesunięcie srodka figury do punktu (0,0)"
            x := wierzcholek x - sX.
            y := wierzcholek y - sY.

            "Obliczenie nowych współrzędnych po obrocie"
            nowyX := (x * radiany cos) + (y * radiany sin).
            nowyY := (-1)*(x * radiany sin) + (y * radiany cos).

            "Przesunięcie wierzchołka z powrotem na miejsce"
            wierzcholek x: nowyX + sX.
            wierzcholek y: nowyY + sY.
        ].

        "Aktualizacja wartości obrotu figury"
        self obrot: kat.
        Transcript show: 'Obracam ', (self nazwa )asString, ' o ', kat asString, ' stopni.'; cr; cr.


    ] ifFalse: [
        Transcript show: 'Kąt poza zakresem!'; cr;cr.
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
    Transcript show: 'Dodano do siebie 2 kwadraty o polach: ', (self pole asString), ' i ', (figura pole asString); cr.

	p:=self pole + figura pole.
	^(Kwadrat new) initialize: p sqrt! !

!Kwadrat methodsFor: 'actions'!

pole
	"licz pole kwadratu"
    
	^bok squared! 

srodekY
    "Zwraca wartość współrzędnej X środka figury"
    
    ^wysrodkowana
        ifTrue: [0]
        ifFalse: [bok / 2].
!!

!Kwadrat methodsFor: 'initialize-release'!

initialize: bok
	"tworz kwadrat o podanym boku"

	super initialize: 4 name: 'Kwadrat'.
	self bok: bok. "Ustawienie boku kwadratu"
	wierzcholki at: 2 put: bok@0.
	wierzcholki at: 3 put: bok@bok.
	wierzcholki at: 4 put: 0@bok.
	self drukuj.
! !
	

Wielokat subclass: #SzeciokatForemny
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'JezykiProgramowania'!


!SzeciokatForemny methodsFor: 'arithmetic'!

+ figura
    "Dodaj dwa sześciokąty foremne w sensie pola, tworząc nową figurę o polu równym sumie pól obu sześciokątów."
    
    | nowePole nowyBok |
    
    Transcript show: 'Dodano do siebie 2 sześciokąty o polach: ', (self pole asString), ' i ', (figura pole asString); cr.

    "Obliczamy pole nowej figury"
    nowePole := self pole + figura pole.
    
    "Obliczamy długość boku nowej figury, zakładając, że nowy sześciokąt ma proporcje odbiorcy komunikatu"
    nowyBok := ((2 * nowePole) / (3 * (3 sqrt))) sqrt.
    
    "Tworzymy nowy sześciokąt foremny o odpowiedniej długości boku"
    ^(SzeciokatForemny new) initialize: nowyBok.
! !

!SzeciokatForemny methodsFor: 'actions'!

srodekY
    "Zwraca wartość współrzędnej X środka figury"
    
    ^wysrodkowana
        ifTrue: [0]
        ifFalse: [bok * (3 sqrt)/ 2].!
        
pole
    "Oblicza pole sześciokąta foremnego"
  
    | pole |
    pole := (3 * (3 sqrt) * (bok squared)) / 2.
    ^pole.
! !

!SzeciokatForemny methodsFor: 'initialize-release'!

initialize: bok
	"tworz sześciokąt o podanym boku"

	super initialize: 6 name: 'SzesciokatForemny'.
	self bok: bok. "Ustawienie boku sześciokąta"
	wierzcholki at: 2 put: bok@0.
	wierzcholki at: 3 put: (bok * 1.5)@(bok * (3 sqrt)*0.5).
	wierzcholki at: 4 put: bok@(bok * (3 sqrt)).
	wierzcholki at: 5 put: 0@(bok * (3 sqrt)).
	wierzcholki at: 6 put: (bok * 0.5 * (-1))@(bok * (3 sqrt)/2).
	self drukuj.
! !


"Prezentowanie działania programu"

| szesciokat1 szesciokat2 wynikowaFigura kwadrat1 kwadrat2|

kwadrat1 := Kwadrat new initialize: 4.

kwadrat1 wysrodkuj.
kwadrat1 drukuj.

kwadrat1 obroc: 45.
kwadrat1 drukuj.

kwadrat2 := Kwadrat new initialize: 3.

wynikowaFigura := kwadrat1 + kwadrat2.

szesciokat1 := SzeciokatForemny new initialize: 5.
szesciokat1 wysrodkuj.
szesciokat1 drukuj.
szesciokat1 obroc: 60.

szesciokat1 drukuj.

szesciokat2 := SzeciokatForemny new initialize: 7.

wynikowaFigura := szesciokat1 + szesciokat2.



