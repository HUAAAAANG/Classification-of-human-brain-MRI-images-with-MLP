function display_decision_boundary(database,parameters)

    nc = size(database.Y_train,1);
    %-- Create a X_mesh grid based on the position of the input points
    xmin = min(database.X_train(1,:))-0.5;
    xmax = max(database.X_train(1,:))+0.5;
    ymin = min(database.X_train(2,:))-0.5;
    ymax = max(database.X_train(2,:))+0.5;
   
    h = 0.01;
    xvec = xmin:h:xmax;
    yvec = ymin:h:ymax;
    [xx,yy] = meshgrid(xvec,yvec);
    X_mesh = [xx(:)';yy(:)'];
    
    %-- For each node of the mesh, estimate the prediction based on the learned parameters
    z = L_layers_nn.predict(parameters, X_mesh);
    zz = reshape(z,size(xx));
     II = colormap('jet');
    %-- Display the corresponding result
    figure; imagesc(xvec,yvec,zz); axis image; colormap(jet);
     hold on;
    for i=1:nc,
        X_train_ci = database.X_train(:,database.Y_train(i,:)==1);
                plot(X_train_ci(1,:),X_train_ci(2,:),'o','linewidth',2,'color',min(1.5*II(1+round((i-1)*63/(nc-1)),:),1));
   
    end
    

end
