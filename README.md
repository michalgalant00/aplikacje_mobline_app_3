# aplikacja_3

Aplikacja nr 3 na zaliczenie programowania aplikacji mobilnych.

## Polecenie

### Zadanie 4.1. Klasa modelowa
Napisz klasę odpowiadającą za model danych charakteryzujący osobę. Klasa ma zawierać
takie pola jak:
- imię i nazwisko (może być połączone),
- miasto,
- nr telefonu,
- obrazek – awatar (w postaci nazwy pliku).
### Zadanie 4.2. Obsługa połączenia sieciowego
Napisz klasę zawierającą metody do obsługi połączenia sieciowego. Dane pobierane będą
z serwisu https://randomuser.me w postaci struktury JSON jak pokazano w laboratorium.
Muszą istnieć metody do:
- odebrania danych z sieci,
- konwersji na obiekt Dart,
### Zadanie 4.3. Wyświetlenie danych
Napisz aplikację wyświetlającą dane pobrane zgodnie z zadaniami 4.1 i 4.2.
### Zadanie 4.4. Modyfikacja interfejsu
Zmodyfikuj aplikację tak aby możliwe było:
- określenie liczby użytkowników, których dane mają zostać pobrane,
- określenie liczby użytkowników, których dane mają zostać wyświetlone,
- pobranie nowych danych (odświeżanie).
Dodaj funkcjonalność zapisu pobranych danych lokalnie – do wyboru:
- plik,
- baza danych.
### Zadanie 4.5. Zapis/odczyt lokalny
Dodaj możliwość przełączenia aplikacji w tryb offline – wówczas wyświetlane dane
mogą być wyłącznie z bazy danych/pliku. Możesz bazować na zadaniach wykonanych w
ramach laboratorium 3. W trybie online mogą być wyświetlone wyłącznie dane pobrane
(nowe).
### Zadanie 4.6. Modyfikacja danych
Dodaj możliwość edycji danych zapisanych lokalnie. Należy pamiętać, że dane muszą
wprowadzone do formularza nie mogą być puste.