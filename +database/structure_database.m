%-- This function is used to séparer l'ensemble des images en trois
%groupes(Train,Valid,Test)
function [database,indices] = structure_database(img1,img2,img3,img4,img5,img6,img7,img8,img9,nclasse)

% Initialisation des matrices
X_train = zeros(4096,80*nclasse);  Y_train = zeros(nclasse,80*nclasse);
X_valid = zeros(4096,10*nclasse);  Y_valid = zeros(nclasse,10*nclasse);
X_test  = zeros(4096,10*nclasse);   Y_test = zeros(nclasse,10*nclasse);

% assemble img1-9 into images
images = cell(1,9);
images{1} = img1; images{2} = img2; images{3} = img3; images{4} = img4;
images{5} = img5; images{6} = img6; images{7} = img7; images{8} = img8;
images{9} = img9;

% divide the data into three groups randomly
indices = randperm(100); % the first 80 ones for train; then 10 for valid 10 for test


for i = 1:nclasse  % i is the index for the class
   
    Y_class_i = zeros(nclasse,1);
    Y_class_i(i) = 1;
    
    % Assignment of X_train and Y_train
    for j = 1:80    % j is the index for items of the group to be assigned
        X_train(:,(i-1)*80+j) = images{i}{indices(j)}(:);   % images{i} = img_i
        Y_train(:,(i-1)*80+j) = Y_class_i;
    end
    
    % Assignment of X_valid and Y_valid
    for j = 1:10    
        X_valid(:,(i-1)*10+j) = images{i}{indices(j+80)}(:);
        Y_valid(:,(i-1)*10+j) = Y_class_i;
    end
    
    % Assignment of X_test and Y_test
    for j = 1:10    
        X_test(:,(i-1)*10+j) = images{i}{indices(j+90)}(:);
        Y_test(:,(i-1)*10+j) = Y_class_i;
    end
end

    % Creation of database
    database.X_train = X_train;
    database.Y_train = Y_train;
    database.X_valid = X_valid;
    database.Y_valid = Y_valid;
    database.X_test  = X_test;
    database.Y_test  = Y_test;
    
    database.num_px = 64; % useful for display_clanu_database.m
end

