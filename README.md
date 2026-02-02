# Projekt Optymalizacji Inwentarzu

Kompleksowy projekt analityczny typu End-to-End, mający na celu optymalizację stanów magazynowych.

Celem biznesowym projektu była odpowiedź na 3 pytania:
1. Które produkty generują 80% wartości magazynu?
2. Jaka część kapitału jest zamrożona w produktach nierotujących?
3. Które produkty wymagają natychmiastowego domówienia?

# Technologie
1. Python (Pandas, Faker) - Generowanie syntetycznego, realistycznego zbioru danych transakcyjnych (100+ SKU, historia ruchów magazynowych).
2. SQL (PostgreSQL) - Zastosowanie zaawansowanych technik:
    * Window Functions,
    * CTE's,
    * Views.
3. Power BI (DAX): Interaktywny dashboard zarządczy.
    * Miary DAX do dynamicznego statusowania
    * Wizualizacja Pareto

# Szczegóły projektu
1. Automatyczna Segmentacja ABC
Zaimplementowano algorytm w SQL klasyfikujący towary:
* Klasa A: Top 80% wartości (Priorytet zakupowy).
* Klasa B: Kolejne 15%.
* Klasa C: Ostatnie 5% wartości.

2. System Wczesnego Ostrzegania
Dashboard monitoruje poziom `current_stock` względem wyznaczonego `safety_stock`. Produkty poniżej progu bezpieczeństwa są automatycznie oznaczane statusem alarmu.

# Instrukcja działania
1. Uruchom skrypt Python, dla wygenerowania 2 plików CSV.
2. Zaimportuj dane do PostgreSQL i uruchom skrypt SQL tworzący widoki.
3. Odśwież plik Power BI, aby pobrać przetworzone dane.
