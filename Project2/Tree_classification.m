%clearvars;

% -- GETTING STARTED WITH THE IMAGE CLASSIFICATION DATASET -- %
% IMPORTANT:
%    Make sure you downloaded the file train.tar.gz provided to you
%    and uncompressed it in the same folder as this file resides.

% Load features and labels of training data
%load train/train.mat;

%change to have two classes

%y2 = y;
%train.y2(train.y2 ~= 4) = 1;
%train.y2(train.y2 == 4) = 0;

% %% --browse through the images and look at labels
% for i=1:10
%     clf();
% 
%     % load img
%     img = imread( sprintf('train/imgs/train%05d.jpg', i) );
% 
%     % show img
%     imshow(img);
% 
%     title(sprintf('Label %d', train.y(i)));
% 
%     pause;  % wait for key, 
% end

%% -- Example: split half and half into train/test, use HOG features
fprintf('Splitting into train/test..\n');

Tr = [];
Te = [];

training =  [X_hog, X_cnn];


% NOTE: you should do this randomly! and k-fold!
Tr.idxs = 1:2:size(training ,1);
Tr.X = training(Tr.idxs,:);
Tr.y = y(Tr.idxs);

Te.idxs = 2:2:size(training,1);
Te.X = training(Te.idxs,:);
Te.y = y(Te.idxs);

clearvars training

%%
fprintf('Training SVM model..\n');

treeBagger = TreeBagger(50, Tr.X, Tr.y);

yhat = [];

[yhat.Te, scores] = predict(treeBagger, Te.X);

yhat.Te = str2num(cell2mat(yhat.Te));

[yhat.Tr, scores] = predict(treeBagger, Tr.X);

yhat.Tr = str2num(cell2mat(yhat.Tr));

figure;
histogram(yhat.Te);

figure;
histogram(Te.y);

ber = [];
ber.Te = compute_ber(yhat.Te, Te.y, [1,2,3,4]);

ber.Tr = compute_ber(yhat.Tr, Tr.y, [1,2,3,4]);


% get overall error [NOTE!! this is not the BER, you have to write the code
%                    to compute the BER!]





fprintf('\n BER Testing error: %.2f%%\n\n', ber.Te * 100 );

fprintf('\n BER Training error: %.2f%%\n\n', ber.Tr * 100 );


% %% visualize samples and their predictions (test set)
% figure;
% for i=20:30  % just 10 of them, though there are thousands
%     clf();
% 
%     img = imread( sprintf('train/imgs/train%05d.jpg', Te.idxs(i)) );
%     imshow(img);
% 
% 
%     % show if it is classified as pos or neg, and true label
%     title(sprintf('Label: %d, Pred: %d', train.y(Te.idxs(i)), classVote(i)));
% 
%     pause;  % wait for keydo that then, 
% end
