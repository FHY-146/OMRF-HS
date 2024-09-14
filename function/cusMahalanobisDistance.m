function distances = cusMahalanobisDistance(Data,statt)

    mu = mean(Data, 1);            % 计算整个数据集的均值（每列的均值）
    S = cov(Data);                 % 计算整个数据集的协方差矩阵
    S_inv = inv(S);             % 计算协方差矩阵的逆

    [m,n] = find(statt);
    [m1,I] = sort(m);
    n1 = n(I);


    X1 = Data(m1, :);
    X2 = Data(n1, :);

    % 计算差值矩阵
    delta = X1 - X2;

    % 应用协方差矩阵的逆，并计算马氏距离
    temp = delta * S_inv;
    distances = sqrt(sum(temp .* delta, 2));
end