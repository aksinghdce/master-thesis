%% RADIO_STATE matrix must be defined and be of size(n, 3)

close all;
hold on;

FLAG_CONVERT_KB = 1
FLAG_PLOT_TX = 1

RATE_KB_PER_RX = 980
RATE_KB_PER_TX = 98

% number of rows / probes
n  = length(RADIO_STATE);
%
X  = 1:n;
% radio state vector
S  = RADIO_STATE(:, 1);
% sent packets count
TX = RADIO_STATE(:, 2);
% received packets count
RX = RADIO_STATE(:, 3);

if (FLAG_CONVERT_KB ~= 0)
    TX = TX * RATE_KB_PER_TX / 1024;
    RX = RX * RATE_KB_PER_RX / 1024;
endif

% hax(1) is left axis, hax(2) right
[hax, h1, h2] = plotyy(X, S, X, RX);
%~ legend('Stan radia', 'RX')

if (FLAG_PLOT_TX ~= 0)
    line(X, TX, 'parent', hax(2));
endif

% add 20% spcing to left yaxis top value
axis(hax(1), [0 (n+1) 0 1.2]);
% add 10% spcing to right yaxis top value
axis(hax(2), [0 (n+1) 0 (max(RX) + max(RX) * 0.1)]);
xlabel('t[s]');
ylabel(hax(1), 'Stan radia');

if (FLAG_CONVERT_KB ~= 0)
    ylabel(hax(2), 'Transfer w KB');
else
    ylabel(hax(2), 'Liczba pakietów');
endif
