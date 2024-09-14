function spectral_weights = FeatureDisCalculating(Img, labels, statt, theta_spec)

[row,col,dim] = size(Img);
% ImgData = reshape(Img,row*col,dim);
rgnCount = max(labels(:));
SpectralMean = zeros(rgnCount,dim);

% for i = 1:rgnCount
%     SpectralMean(i,:) = mean(ImgData(labels==i,:));
% end

for i = 1:dim
    S = regionprops(labels,Img(:,:,i),"MeanIntensity");
    SpectralMean(:,i) = cell2mat(struct2cell(S(:)))';
end

% spectral_weights = zeros(rgnCount,rgnCount);
% spectral_weights = sparse(rgnCount,rgnCount);
% for i = 1:dim
%     spec_dis = pdist2(SpectralMean(:,i),SpectralMean(:,i),'mahalanobis');
%     spectral_weights = spectral_weights+spec_dis;
% end
[m,n] = find(statt);
[m1,I] = sort(m);
n1 = n(I);
spectral_distances = cusMahalanobisDistance(SpectralMean,statt);
spectral_distances = exp(-1*(spectral_distances/(theta_spec^2)/2));
nzmax = size(spectral_distances,1);
spectral_weights = sparse(m1,n1,spectral_distances,rgnCount,rgnCount,nzmax);

% spectral_weights = pdist2(SpectralMean,SpectralMean,'mahalanobis');
% spectral_weights = spectral_weights/3;
% spectral_weights = exp(-1*(spectral_weights/(theta_spec^2)/2)) - diag(ones(1,rgnCount),0);
