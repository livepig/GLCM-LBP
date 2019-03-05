function uniformPattern = myULBP(grayImage)
     [rows,columns] = size(grayImage);
     uniformPattern = uint8(zeros(rows,columns)) ;
     vec = zeros(1,256);
     
     for i = 0:255
        tmp_binary = de2bi(i,8);
        transition = sum( diff(tmp_binary)~=0 );
        transition =transition + abs(tmp_binary(1)-tmp_binary(8));
        transition = double(transition);
        if transition <=2
            vec(i+1)= i;
        else
            vec(i+1)= 256;
        end
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
            uniformPattern(i,j) = vec(value+1);
        end
     end
end