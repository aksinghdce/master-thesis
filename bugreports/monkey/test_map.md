# Plik zawiera mapowanie scenariuszy testowych na katalog zawierający wyniki

## iCarWash
* bez optymalizacji, bez gzip       → icarwash/capture_5
* bez optymalizacji, z gzip         → icarwash/capture_3
* pobranie kompletu danych, bez gzip→ icarwash/capture_6
* pobranie kompletu danych, z gzip  → icarwash/capture_4
* bez optymalizacji, bez gzip, jasność 100%      → icarwash/capture_7
* pobranie kompletu danych, z gzip, jasność 100% → icarwash/capture_8

## OLX
* bez optymalizacji, bez kompresji  → olx/capture_6
* bez optymalizacji, kompresja      → olx/capture_1
* prefetch 5, potem 1, bez gzip     → olx/capture_7
* prefetch 5, potem 1, z gzip       → olx/capture_2
* prefetch 5, potem 2, bez gzip     → olx/capture_8
* prefetch 5, potem 2, z gzip       → olx/capture_3
* prefetch 10, potem 1, bez gzip    → olx/capture_9
* prefetch 10, potem 1, z gzip      → olx/capture_4
* prefetch 10, potem 2, bez gzip    → olx/capture_10
* prefetch 10, potem 2, z gzip      → olx/capture_5
