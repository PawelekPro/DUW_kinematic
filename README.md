# DUW_kinematic
Dynamics of multibody systems

Instrukcja do programu
Do pliku PobierzDane.m wczytujemy konfigurację mechanizmu wynikającą z polecenia. 
Wpisujemy kolejno: punkty, srodki ciężkości oraz definiujemy więzy kinematyczne: obrotowe lub postępowe oraz kierujące: postępowe.

Uwaga!
Podczas definicji więzów ważne jest, aby ciało o numerze 0 (w domyśle jest do podstawa) 
znajdowało się na pierwszym miejscu w parze. Umieszczenie ciała nr 0 na drugim miejscu spowoduje błąd programu.

Funkcja PobierzDane.m definiuje macierz niewiadomych (q),  
dla ktorej ilosc wierszy odpowiada ilosci ciał, a ilośc kolumn wynosi 9.
Pierwsze 3 kolumny: zadanie na położenie
Kolejne 3 kolumny: zadanie na prędkości
Ostatnie 3 kolumny: zadanie na przyspieszenia


Wczytane dane są przekazywane do pliku program_glowny.m, gdzie w głownej pętli wykonywane są obliczenia. 
Znajduje sie tam rowniez prosty postprocessing polegajacy na zwróceniu wykresów, które wymagane są w poleceniu do pracy domowej.

Aby zwrócić przebiegi dla żądanego punktu i ciała wystarczy w pierwszych 
liniach programu zdefiniować obiekty, dla których szukamy przebiegów.
