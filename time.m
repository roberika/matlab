%creates a new Mamdani-style Fuzzy Inference System structure

a=mamfis('Name', 'settletime');
% Create new FIS with filename "settletime"

% Add input variables pressure, temperature and output variable time to FIS.-Fuzzification
% input 1-pressure
a=addInput (a, [-30 30], 'Name', 'pressure');
a=addMF (a, 'pressure', 'gaussmf', [-30 -30], 'Name', 'NB');
a=addMF (a, 'pressure', 'trimf', [-28.8 -18.8 -6.27], 'Name', 'NS'); 
a=addMF (a, 'pressure', 'trimf', [-17.3 -6.94 4.68], 'Name', 'Z'); 
a=addMF (a, 'pressure', 'trimf', [-6.63 5.35 16.5], 'Name', 'PS'); 
a=addMF (a, 'pressure', 'trapmf', [5.32 17 30 30], 'Name', 'PB');

% plot the MF
figure;
plotmf (a, 'input',1);

%input 2- temperature-Fuzzification
a=addInput (a, [0 30], 'Name', 'temperature');
a=addMF (a, 'temperature', 'trapmf', [0 0 5 12.49], 'Name', 'low');
a=addMF (a, 'temperature', 'trimf', [0.2904 12.3 24.31], 'Name', 'medium');
a=addMF (a, 'temperature', 'trapmf', [12.29 24.3 36.31 36.31], 'Name', 'high'); 

% plot the MF
figure; 
plotmf (a, 'input', 2);

% output 1-cooking time
a=addOutput (a, [0,15], 'Name', 'time');
a=addMF (a,'time', 'trapmf', [0 0 4 7.568], 'Name', 'short');
a=addMF (a, 'time', 'trimf', [0.1223 7.54 14.96], 'Name', 'average');
a=addMF (a, 'time', 'trapmf', [7.512 10 15 15], 'Name', 'long'); 

% plot the MF
figure; 
plotmf (a, 'output',1);

% creating rules
% rule1 : if pressure is NB AND temperature is high THEN time is short
% rule2 : if pressure is NS AND temperature is medium THEN time is average 
% rule3 : if pressure is Z AND temperature is high THEN time is average 
% rule4 : if pressure is PS THEN time is long

rule=[1 3 1 1 1; 2 2 2 1 1; 3 3 2 1 1; 4 0 3 1 1];
a=addRule (a, rule);

% Use centroid defuzzification method to find output z.
a.DefuzzificationMethod = 'centroid';
time1=evalfis (a, [-22 15]);

