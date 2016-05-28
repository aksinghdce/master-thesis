%%
clear all;
close all;
clc;
format short g;

load 'olx.m'   % loads olx and header cell arrays

% convert to plain matrix
O = cell2mat(olx(:, 3:end));

% split into smaller matrixes
% appStats.DevicePowerPrediction
device_power_prediction = O(:, 1:7:end);

% appStats.RawStats.foreground.total_time_msec
total_time_msec = O(:, 2:7:end);

% appStats.RawStats.network.mobile_active_time_msec
mobile_active_time_msec = O(:, 3:7:end);

% appStats.RawStats.network.mobile_active_count
mobile_active_count = O(:, 4:7:end);

% appStats.RawStats.network.mobile_bytes_rx
mobile_bytes_rx = O(:, 5:7:end);

% appStats.RawStats.network.mobile_bytes_tx
mobile_bytes_tx = O(:, 6:7:end);

% appStats.RawStats.power_use_item.computed_power_mah
computed_power_mah = O(:, 7:7:end);

% rate of radio active time to whole application running [%]
mobile_active_percent = ((mobile_active_time_msec ./ total_time_msec) * 100);

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

% compare the power consumption gain loss
% compare the first mesurement (no opt) to other methods
base = norm_computed_power_mah(1, :);
disp('Konsumpcja energii w porównaniu do pierwszej metody');
((norm_computed_power_mah - base) ./ base) * 100
