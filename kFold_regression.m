M=readtable("CCPP.xlsx");
features=4;
X=table2array(M(:,1:features));
Y=table2array(M(:,features+1));
kFolds = 10;
kIdx = crossvalind('Kfold', length(Y), kFolds);
   for k = 1:kFolds
        tree(k) = node
        X_train = X(kIdx~=k, :);
        Y_train = Y(kIdx~=k);
        X_test = X(kIdx==k, :);
        Y_test = Y(kIdx==k);
        tree(k).features_rem = [1:4];
        tree(k).data = X_train
        tree(k).label = Y_train
        [tree(k).thresh,tree(k).feature_used] = findThresh(tree(k));
        tree(k).features_rem = tree(k).features_rem(tree(k).features_rem ~= tree(k).feature_used);
        makeTree(tree(k));
%         Y_Pred = getPred(0,tree(k),X_test);
%         Class_Perf(k)= 100*sum(Y_Pred==Y_test)/length(Y_test)
        y_pred = getPred(1,tree(k),X_test)
        result_mse = zeros(length(y_pred),1)
        result_mse = (y_pred - Y_test).*(y_pred - Y_test)
        reg_result(k) = sqrt(sum(result_mse)/length(Y_test))
   end

   avg = mean(reg_result)