function [ps,pd] = sum_diffence(src , gray_level , row_step , col_step)
% 
% Sum and Difference Histograms for Texture Classification
% IEEE TRANSACTIONS ON PATTERN ANALYSIS AND MACHINE INTELLIGENCE 
% author：Michael Unser
% year:1986
% 
%  返回:ps,ps为1xN的向量,分别表示和直方图、差直方图
%% 灰度量化
    I=double(src);
    I_max = max(max(I));
    I_min = min(min(I));
    if (I_max - I_min) > 0
        slope = gray_level / (I_max - I_min);
    end
    intercept = 1 - (slope * I_min);
    %floor 向下取整  imlincomb 线性乘
    %slope*I +intercept
    SI = floor(imlincomb(slope, I, intercept, 'double'));
    %防止越界1—gray_level
    SI(SI > gray_level) = gray_level;
    SI(SI < 1) = 1;
%%
    %sum and difference
    %sum [2,2*level] -->src[1,2*level-1]
    s_src = zeros(1,gray_level*2-1);
    % diff [-level+1,level-1] ->diff[1,2*level-1];
    d_src = zeros(1,gray_level*2-1);
    [m,n] = size(SI);
    for i = 1:m
        for j = 1:n
            intensity = SI(i,j);
            row_offset = i+row_step;
            col_offset = j+col_step;
             if row_offset>=1 && row_offset<=m && col_offset>=1 && col_offset<=n
                 intensity_offset = SI(row_offset,col_offset);
                 sum_intensity = intensity + intensity_offset;
                 dif_intensity = intensity - intensity_offset;
                 s_src(sum_intensity-1) = s_src(sum_intensity-1)+1;
                 d_src(dif_intensity+gray_level)= d_src(dif_intensity+gray_level) +1;
             end
        end
    end
    count = sum(s_src);
    ps = s_src/count;
    pd = d_src/count ;
end