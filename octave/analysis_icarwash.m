%%
clear all;
close all;
clc;
format short;

load 'icarwash.m'   % loads icarwash and header cell arrays

% convert to plain matrix
I = cell2mat(icarwash(:, 3:end));

% split into smaller matrixes
% appStats.DevicePowerPrediction
device_power_prediction = I(:, 1:7:end);

% appStats.RawStats.foreground.total_time_msec
total_time_msec = I(:, 2:7:end);

% appStats.RawStats.network.mobile_active_time_msec
mobile_active_time_msec = I(:, 3:7:end);

% appStats.RawStats.network.mobile_active_count
mobile_active_count = I(:, 4:7:end);

% appStats.RawStats.network.mobile_bytes_rx
mobile_bytes_rx = I(:, 5:7:end);

% appStats.RawStats.network.mobile_bytes_tx
mobile_bytes_tx = I(:, 6:7:end);

% appStats.RawStats.power_use_item.computed_power_mah
computed_power_mah = I(:, 7:7:end);

% rate of radio active time to whole application running [%]
mobile_active_percent = round((mobile_active_time_msec ./ total_time_msec) * 100);

% calculate normalization rates
norm_rates = total_time_msec / 3600000;
% normalized values
norm_device_power_prediction = device_power_prediction ./ norm_rates;
norm_computed_power_mah = computed_power_mah ./ norm_rates;
norm_mobile_bytes_rx = mobile_bytes_rx ./ norm_rates;
norm_mobile_bytes_tx = mobile_bytes_tx ./ norm_rates;

disp('Przewidywane zużycie energii [%]');
norm_device_power_prediction

disp('Wyliczony pobór energii [mAh]');
round(norm_computed_power_mah)

disp('Stosunek czasu aktywności radia do trwania aplikacji [%]');
mobile_active_percent

disp('Dane pobrane w ciągu godziny [KB]');
round(norm_mobile_bytes_rx / 1024)

disp('Dane wysłane w ciągu godziny [KB]');
round(norm_mobile_bytes_tx / 1024)

% Czy jest sens uśredniać wartości?
% widać, że zależy wiele od samego czasu używania aplikacji
% Wnioski:
%   minimalizujemy procent aktywności radia w stos. do czasu aplikacji
%   nie pobierajmy w każdym przypadku 100% danych!
%       opcja wg. mnie idealna dla icarwash
%           jeżeli nie ma jakichkolwiek danych w cache pobieramy wszystko,
%           jeśli są pobieramy tylko aktualnie oglągany wycinek (to jest w zasadzie ekwiwalent pobierania na żądanie, a to nie), ścieżkę jak dojść do niego?
%           można inaczej – pobrać wszystko za pierwszym razem, używać GCM do informowania o zmianach w danych,
%           wysyłać na serwer zapytanie a aktualizację, nie wiedzą co ma być zaktualizowane
%           zaktualizować dane i ew. widoki (pytanie jak notyfikować widoki o zmianie danych? model view observer?)
%
% testy z serii 3 są bardzo krótkie, trwają około 13.5 sekundy
% seria 2 trwa około minuty
% seria 1 trwa 1 minutę 53 sekundy
% ma to jak widać ogromny wpływ na wyniki
% pamiętajmy jednak, że nikt nie będzie działał w 100% w taki sposób:
%   otwórz app, spójrz w jeden widok, zabij, otwórz i spójrz w inny. i tak przez godzine...
%   tu bym się raczej nie przejmował przy takich aplikacjach tym zjawiskiem
%   jeżeli serwer wykorzystuje gzip i potrafi odpowiednio wysłać kod 304
%   a sami korzystamy z biblioteki typu volley, która przechowuje cache na dysku
%   i obsługuje odpowiednio te standardy to nie ma najmniejszego problemu,
%   ani powodu aby zaprzątać sobie tym głowę
% a może nie normalizować danych? w końcu one przedstawiają podobną jednostkę operacji jaką jest test?
% bardzo brakuje mi teraz współczynnika hit / miss rate
%   dane pobrane, ale nigdy nie wykorzystane!
%   inna opcja to opis słowny wygenerowanych kroków testowych
