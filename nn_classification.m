clear all;
close all;
clc;
addpath('../');

%-- Load database parameters
filename = './data/data_Clanu_22.mat';
load(filename);

nC = 9;
%-- put database in place
[database,indices] = database.structure_database(T1_A,T1_C,T1_S,T2_A,T2_C,T2_S,PD_A,PD_C,PD_S,nC);

% % -- Display training database
visu.display_clanu_database(database);


%-- Build a model with a n_h-dimensional hidden layer
num_iterations = 2000;
learning_rate = 0.01;
print_cost = true;
nX = size(database.X_train,1);

layers_dims = [nX,64,32,16,nC];
[parameters,costs] = L_layers_nn.model(database, layers_dims, num_iterations, learning_rate, print_cost);


%-- Compute accuracy
X_train = database.X_train;
Y_train = database.Y_train;
X_test = database.X_test;
Y_test = database.Y_test;


nB =  size(database.Y_train,2);
Y_train_c = sum(([1:nC]'*ones(1,nB)).*Y_train , 1); 
nB =  size(database.Y_test,2);
Y_test_c = sum(([1:nC]'*ones(1,nB)).*Y_test , 1); 

Y_prediction_train = L_layers_nn.predict(parameters, X_train);
Y_prediction_test = L_layers_nn.predict(parameters, X_test);


%-- Print train/test Errors
disp(['train accuracy: ', num2str(100 - mean(sum(abs(Y_prediction_train - Y_train_c),1)) * 100), ' %'])
disp(['test accuracy: ', num2str(100 - mean(sum(abs(Y_prediction_test - Y_test_c),1)) * 100), ' %'])  
