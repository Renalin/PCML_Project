clear all;

addpath(genpath('leastSquareGD/'));
addpath(genpath('LogisticRegression/'));
addpath(genpath('penLogisticRegression/'));
addpath(genpath('Data/'));

% load regression data
load('Chennai_regression');

%plot data
for i=1:69
    scatter(X_train(:,i),y_train);
    hold on;
end

%Split data in two y < 3400 and y > 3400 
idx = find(y_train > 3400);
y_large = y_train(idx);
X_large = X_train(idx,:);

idx = find(y_train <= 3400);
y_small = y_train(idx);
X_small = X_train(idx,:);

%plot data
% for i=1:69
%     scatter(X_small(:,i),y_small);
%     hold on;
% end

% for i=1:69
%     scatter(X_large(:,i),y_large);
%     hold on;
% end