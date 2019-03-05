function rotationInvariantPattern = myRILBP(grayImage)
    [rows ,columns] = size(grayImage)  ;
    rotationInvariantPattern = uint8(zeros(rows,columns));
    pixel=zeros(1,8);
    
    %查找表
    vec = zeros(1,256);
    for i=0:255
        tmp_binary = de2bi(i,8);
        min = 256;
        for j = 1:8
            %第二维度右移j位
            value_shift = circshift(tmp_binary,[0,j]);
            value = bi2de(value_shift);
            if min > value
                min = value;
            end
        end
        vec(i+1)= min ;
    end
    
    for i = 2:rows-1
        for j = 2:columns-1
            centerPixel = grayImage(i,j);
            pixel(1)=grayImage(i-1, j-1) >= centerPixel;  
            pixel(2)=grayImage(i-1, j) >= centerPixel;   
            pixel(3)=grayImage(i-1, j+1) >= centerPixel;  
            pixel(4)=grayImage(i, j+1) >= centerPixel;     
            pixel(5)=grayImage(i+1, j+1) >= centerPixel;    
            pixel(6)=grayImage(i+1, j) >= centerPixel;      
            pixel(7)=grayImage(i+1, j-1) >= centerPixel;     
            pixel(8)=grayImage(i, j-1) >= centerPixel;
            value = (pixel(1)*2^7+pixel(2)*2^6+pixel(3)*2^5+pixel(4)*2^4+pixel(5)*2^3+pixel(6)*2^2+pixel(7)*2+pixel(8));
            rotationInvariantPattern(i,j)=vec(value+1);
            
        end
    end
    
end