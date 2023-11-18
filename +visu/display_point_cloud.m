function display_point_cloud(database,text)

    if ~exist('text','var')
        text = '';
    end

    %-- Extract points that belong to each class
    nc = size(database.Y_train,1)
    figure;
    hold on;
    II = colormap('jet');
    
    for i=1:nc,
        X_train_ci = database.X_train(:,database.Y_train(i,:)==1);
   %     plot(X_train_ci(1,:),X_train_ci(2,:),'o','linewidth',2,'color',[i/nc,abs((nc/2-i))/(nc/2),(nc-i)/nc]);
        plot(X_train_ci(1,:),X_train_ci(2,:),'o','linewidth',2,'color',min(1.5*II(1+round((i-1)*63/(nc-1)),:),1));
   
    end
    
    
    title(text);

end
