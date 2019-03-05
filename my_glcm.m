%SI 范围 [1,gray_level]
function [G,SI] = my_glcm(src , gray_level , row_step , col_step)
    G = zeros(gray_level);
    slope = 0;
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
    %防止越界
    SI(SI > gray_level) = gray_level;
    SI(SI < 1) = 1;
    
    [m,n] = size(SI);
    for i = 1:m
        for j = 1:n
            intensity = SI(i,j);
            row_offset = i+row_step;
            col_offset = j+col_step;
            if row_offset>=1 && row_offset<=m && col_offset>=1 && col_offset<=n
                intensity_offset = SI(row_offset,col_offset);
                G(intensity,intensity_offset) = G(intensity,intensity_offset)+1;
            end
        end
    end
end