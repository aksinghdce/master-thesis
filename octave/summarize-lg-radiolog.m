%% relies on RADIO_STATE matrix being loaded first
[n_rows, n_columns] = size(RADIO_STATE);

% kb per recieved packet
if ~exist('RATE_BYTE_PER_RX', 'var')
    RATE_BYTE_PER_RX = 980;
end

% kb per sent packet
if ~exist('RATE_BYTE_PER_TX', 'var')
    RATE_BYTE_PER_TX = 98;
end

% radio state vector
if ~exist('S', 'var')
    S  = RADIO_STATE(:, 2);
end

% sent packets count
if ~exist('TX', 'var')
    TX = (RADIO_STATE(:, 3) * RATE_BYTE_PER_TX) / 1024;
end

% received packets count
if ~exist('RX', 'var')
    RX = (RADIO_STATE(:, 4) * RATE_BYTE_PER_RX) / 1024;
end

% session time in seconds
time_session    = n_rows;
% radio active time in seconds
time_active     = sum(S);
active_percent  = 100 * time_active / time_session;
% total rx/tx values in KB
total_kb_rx     = sum(RX);
total_kb_tx     = sum(TX);
% mean rx / tx KB while radio was active
mean_kbs_rx     = total_kb_rx / time_active;
mean_kbs_tx     = total_kb_tx / time_active;

format = '%.2f';

disp(cstrcat('czas sesji pomiarowej:        ', num2str(time_session), ' s'));
disp(cstrcat('czas aktywności radia:        ', num2str(time_active), ' s  (', num2str(active_percent, format), '%)'));
disp('')
disp(cstrcat('liczba pobranych danych:      ', num2str(total_kb_rx, format), ' KB'));
disp(cstrcat('średnia dla aplikacji:        ', num2str(mean(RX), format), ' KB/s'))
disp(cstrcat('średnia dla aktywnego radia:  ', num2str(mean_kbs_rx, format), ' KB/s'))
disp('')
disp(cstrcat('liczba wysłanych danych:      ', num2str(total_kb_tx, format), ' KB'));
disp(cstrcat('średnia dla aplikacji:        ', num2str(mean(TX), format), ' KB/s'))
disp(cstrcat('średnia dla aktywnego radia:  ', num2str(mean_kbs_tx, format), ' KB/s'))
