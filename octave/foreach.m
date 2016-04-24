%% apply actions for each item
rootpath = '../logs/lg_g4c/';
items = [
    '2016-04-12/olx.praca.m'
    '2016-04-13/pracuj.pl.m'
    '2016-04-14/bkf.m'
    '2016-04-13/olx.moto.m'
    '2016-04-14/facebook.m'
];

for i = 1:size(items, 1)
    item = items(i, :);
    disp(item);
    clear 'RADIO_STATE';
    load(strcat(rootpath, item));
    run('summarize-lg-radiolog.m');
    inp = input('Press RETURN to continue...');
    disp('');
end
