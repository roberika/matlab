close all;
clear all;

%creates a new Mamdani-style Fuzzy Inference System structure
% Create new FIS with filename "settletime"
figure('NumberTitle', 'off', 'Name', 'Pressure Cooker');
fis = mamfis('Name', 'settletime');

% Add input variables pressure, temperature, waterlevel and output variable time to FIS.-Fuzzification

% input 1 - pressure
fis = addInput (fis, [-30 30], 'Name', 'pressure');
fis = addMF (fis, 'pressure', 'gaussmf', [10 -28], 'Name', 'VL');
fis = addMF (fis, 'pressure', 'trimf', [-30 -20 -10], 'Name', 'L'); 
fis = addMF (fis, 'pressure', 'trapmf', [-23 -13 0 10], 'Name', 'SL'); 
fis = addMF (fis, 'pressure', 'trimf', [-5 5 15], 'Name', 'SH'); 
fis = addMF (fis, 'pressure', 'trapmf', [-2 8 18 28], 'Name', 'H');
fis = addMF (fis, 'pressure', 'gaussmf', [10 28], 'Name', 'VH');
% plot the MF
subplot(3,4,1);
plotmf (fis, 'input',1);
title("Input 1 - Pressure");

% input 2 - temperature
fis = addInput (fis, [0 30], 'Name', 'temperature');
fis = addMF (fis, 'temperature', 'zmf', [0 10], 'Name', 'VL');
fis = addMF (fis, 'temperature', 'pimf', [-2 5 7 14], 'Name', 'L');
fis = addMF (fis, 'temperature', 'pimf', [5 12 12 19], 'Name', 'SL'); 
fis = addMF (fis, 'temperature', 'pimf', [9 16 19 26], 'Name', 'SH');
fis = addMF (fis, 'temperature', 'pimf', [15 22 22 29], 'Name', 'H');
fis = addMF (fis, 'temperature', 'smf', [18 28], 'Name', 'VH');
% plot the MF
subplot(3,4,2);
plotmf (fis, 'input', 2);
title("Input 2 - Temperature");

% input 3 - water level
fis = addInput (fis, [0 2000], 'Name', 'water');
fis = addMF (fis, 'water', 'linzmf', [200 700], 'Name', 'VL');
fis = addMF (fis, 'water', 'pimf', [-200 500 500 1200], 'Name', 'L'); 
fis = addMF (fis, 'water', 'trimf', [400 900 1400], 'Name', 'Z');
fis = addMF (fis, 'water', 'trapmf', [700 1200 1350 1850], 'Name', 'H');
fis = addMF (fis, 'water', 'linsmf', [1100 1600], 'Name', 'VH');
% plot the MF
subplot(3,4,3);
plotmf (fis, 'input', 3);
title("Input 3 - Water Level");

% output 1 - cooking time
fis = addOutput (fis, [0,15], 'Name', 'time');
fis = addMF (fis,'time', 'trapmf', [0 0 4 8], 'Name', 'short');
fis = addMF (fis, 'time', 'trimf', [0 7.5 15], 'Name', 'average');
fis = addMF (fis, 'time', 'trapmf', [7 11 15 15], 'Name', 'long'); 
% plot the MF
subplot(3,4,4);
plotmf (fis, 'output',1);
title("Output - Cooking Time");

% creating rules
% rule1 : if pressure is NB AND temperature is high THEN time is short
% rule2 : if pressure is NS AND temperature is medium THEN time is average 
% rule3 : if pressure is Z AND temperature is high THEN time is average 
% rule4 : if pressure is PS THEN time is long
rule = [];
for i = 1 : 6
    for j = 1 : 6
        for k = 1 : 5
            rule = cat(1, rule, [i j k]);
        end
    end
end
% 36
rule = cat(2, rule, [
    1; 1; 1; 1; 1;
    1; 1; 1; 1; 2;
    1; 1; 2; 2; 2;
    1; 2; 2; 2; 2;
    1; 2; 2; 2; 3;
    2; 2; 2; 2; 3;

    1; 1; 1; 1; 2;
    1; 1; 2; 2; 2;
    1; 2; 2; 2; 2;
    1; 2; 2; 2; 3;
    2; 2; 2; 2; 3;
    2; 2; 2; 3; 3;

    1; 1; 2; 2; 2;
    1; 2; 2; 2; 2;
    1; 2; 2; 2; 3;
    2; 2; 2; 2; 3;
    2; 2; 2; 3; 3;
    2; 2; 2; 3; 3;
    
    1; 1; 2; 3; 3;
    1; 1; 2; 3; 3;
    1; 2; 2; 3; 3;
    2; 2; 3; 3; 3;
    2; 2; 3; 3; 3;
    2; 3; 3; 3; 3;

    1; 2; 2; 3; 3;
    1; 2; 3; 3; 3;
    2; 2; 2; 3; 3;
    2; 2; 3; 3; 3;
    2; 3; 3; 3; 3;
    2; 3; 3; 3; 3;

    2; 2; 2; 3; 3;
    2; 2; 3; 3; 3;
    2; 2; 3; 3; 3;
    2; 3; 3; 3; 3;
    2; 3; 3; 3; 3;
    3; 3; 3; 3; 3;
    ]);
ruleend = [];
for i = 1 : 180
     ruleend = cat(1, ruleend, [1 1]);
end
rule = [rule ruleend];
fis = addRule (fis, rule);

% Get output from the 6 input values
input = [
    -25 10 1500; 
    -10 25 750; 
    15 10 500; 
    20 20 1000; 
    15 20 800; 
    ];

% Use centroid defuzzification method to find output z.
fis.DefuzzificationMethod = 'centroid';
"Output Centroid"
output = evalfis (fis, input)
fis.DefuzzificationMethod = 'bisector';
"Output Bisector"
output = evalfis (fis, input)
fis.DefuzzificationMethod = 'som';
"Output SoM"
output = evalfis (fis, input)
fis.DefuzzificationMethod = 'mom';
"Output MoM"
output = evalfis (fis, input)
fis.DefuzzificationMethod = 'lom';
"Output LoM"
output = evalfis (fis, input)
