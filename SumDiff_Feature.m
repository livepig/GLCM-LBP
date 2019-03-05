function feature = SumDiff_Feature(ps , pd ,gray_level)
% 
% Sum and Difference Histograms for Texture Classification
% IEEE TRANSACTIONS ON PATTERN ANALYSIS AND MACHINE INTELLIGENCE 
% author£ºMichael Unser
% year:1986
% 

%% computer features
ps = ps';
pd = pd';

i = 2:1:gray_level*2 ;
j = 1-gray_level:1:gray_level-1 ;

% mean f1
mean = 0.5*i*ps;
% f2
%variance = 1/2 *( ((i-2*mean).^2)*ps + (j.^2)*pd );
mean2 = j*pd; % mean2 ºãÎª0
variance = 1/2 *( ((i-2*mean).^2)*ps + ((j-mean2).^2)*pd );

%Energy f3
energy = (ps'*ps) * (pd'*pd);
%correlation f4
a = 0.5*( ((i-2*mean).^2)*ps - (j.^2)*pd );
%correlation = a /(variance);
correlation = a;
correlation = correlation/variance;

% entropy f5
non_zero_ps = ps(ps>0);
non_zero_pd = pd(pd>0);
entropy = -non_zero_ps'*log2(non_zero_ps) - non_zero_pd'*log2(non_zero_pd);
%contrast f6
contrast = (j.^2)*pd;
%Homogeneity f7
homogeneity = 1./(1+j.^2) * pd;

%cluster shade f8
cluster_shade = (i-2*mean).^3 *ps;
%cluseter prominence f9
cluseter_prominence = (i-2*mean).^4 *ps;



feature=[mean,variance,energy,correlation,entropy,contrast,homogeneity,cluster_shade,cluseter_prominence];
%f3--f7
%feature=[variance,energy,correlation,entropy,contrast,homogeneity,cluster_shade];

