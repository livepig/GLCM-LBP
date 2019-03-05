function feature = sum_diff_glcm_feature(glcm ,gray_level)
% 
% Sum and Difference Histograms for Texture Classification
% IEEE TRANSACTIONS ON PATTERN ANALYSIS AND MACHINE INTELLIGENCE 
% author：Michael Unser
% year:1986
% 
%% 比较glcm计算特征和 sum、diff计算特征的不同
%f1-f9
feature = struct('mean',0,'variance',0,'energy',0,'correlation',0,'entropy',0, ...
    'contrast',0,'homogeneity',0,'cluster_shade',0,'cluseter_prominence',0);
i = repmat((1:gray_level)',1,gray_level);
j = repmat(1:gray_level ,gray_level ,1 );
ij_sq = (i-j).^2;
p=glcm ./ sum(glcm(:));
f1 = sum(sum(i.*p));
f2 = sum(sum(p.*(i-f1).^2));
f3 = sum(sum(p.^2));
f4 = sum(sum((i-f1).*(j-f1).*p));

non_zero_glcm = p(p > 0);
f5 = sum(sum(-non_zero_glcm.*log2(non_zero_glcm)));

f6 = sum(sum(ij_sq.*p));
f7 = sum(sum(p./(1+ij_sq)));
f8 = sum(sum(p.*(i+j-2*f1).^3));
f9 = sum(sum(p.*(i+j-2*f1).^4));

feature.mean = f1;
feature.variance = f2 ;
feature.energy = f3 ;
feature.correlation = f4;
feature.entropy  = f5;
feature.contrast = f6;
feature.homogeneity = f7;
feature.cluster_shade = f8 ;
feature.cluseter_prominence = f9;
end
