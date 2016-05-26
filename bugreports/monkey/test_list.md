# Plik zawiera mapowanie scenariuszy testowych na katalog zawierający wyniki

## iCarWash
* bez optymalizacji, bez gzip       → icarwash/capture_5
* bez optymalizacji, z gzip         → icarwash/capture_3
* pobranie kompletu danych, bez gzip→ icarwash/capture_6
* pobranie kompletu danych, z gzip  → icarwash/capture_4

## OLX --- redo mt_1_1, mt_2_1 for first 3 captures [with gzip]
* bez optymalizacji, bez kompresji  → [now]
* bez optymalizacji, kompresja      → olx/capture_1
* prefetch 5, potem 1, bez gzip     → brak
* prefetch 5, potem 1, z gzip       → olx/capture_2
* prefetch 5, potem 2, bez gzip     → brak
* prefetch 5, potem 2, z gzip       → olx/capture_3
* prefetch 10, potem 1, bez gzip    → brak
* prefetch 10, potem 1, z gzip      → olx/capture_4
* prefetch 10, potem 2, bez gzip    → brak
* prefetch 10, potem 2, z gzip      → olx/capture_5
