clear all;

addpath(genpath('leastSquareGD/'));
addpath(genpath('LogisticRegression/'));
addpath(genpath('penLogisticRegression/'));
addpath(genpath('Data/'));

% load regression data
load('Chennai_regression');

X = normalize(X_train);


%Split data in two y < 3400 and y > 3400 
idx = find(y_train > 3400);
y_large = y_train(idx);
X_large = X(idx,:);

idx = find(y_train <= 3400);
y_small = y_train(idx);
X_small = X(idx,:);


tX_train = [ones(size(y_train)) X];
tX_large = [ones(size(y_large)) X_large];
tX_small = [ones(size(y_small)) X_small];

categIndex = [1 3 11 20 25 39 41 42 45 47 69];
noCategIndex = [2 4:10 12:19 21:24 26:38 40 43 44 46 48:68];

categX = X(:, categIndex);
noCategX = X(:, noCategIndex);
