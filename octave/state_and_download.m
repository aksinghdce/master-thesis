%% plot state & download graph

clear all;
close all;


x_state = [15 15 20 20 30 30 35 35 45 45 50 50 60];
y_state = [0 20 20 10 10 20 20 10 10 20 20 10 10];

x_transfer = [15 16 30 45];
y_transfer = [5 0 5 5];


% setup plot
hold on;
axis([0 60 0 30]);
xlabel('t[s]');
grid on;

%yyaxis left;
%ylabel('Stan radia');
plot(x_state, y_state, '-b');

%yyaxis right;
%ylabel('Transfer danych');
bar(x_transfer, y_transfer, 'histc');

legend('Stan radia', 'Transfer danych');
