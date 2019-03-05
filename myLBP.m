function localBinaryPattern = myLBP(grayImage,R,P)
%grayImage�Ҷ�ͼ��
%R�뾶
%P��Χ����ܸ���
%����LBP����ͼ
     [rows,columns] = size(grayImage);
    grayImage=double(grayImage);
    localBinaryPattern =uint32(zeros(rows,columns)) ;
    % LBP�������ʼ�ͽ���λ��
    minX=uint16(ceil(R));
    maxX=uint16(floor(double(rows)-R));
    minY=uint16(ceil(R));
    maxY=uint16(floor(double(columns)-R));
    %�Ƕ�
    angle = 2*pi/P;
    %��ֵ����
    X=1:rows;
    Y=1:columns;
    for i = minX+1:maxX-1
        for j = minY+1:maxY-1
            centerPixel = grayImage(i,j);
            lbpvalue = 0;
            for k=1:P
                %ת����doubel����
                x=double(i)-R*sin((k-1)*angle);
                y=R*cos((k-1)*angle)+double(j);
                x=round(x);
                y=round(y);
                %��ֵ �� ��  ֵ �� ��
                %pixel=interp2(Y,X,double(grayImage),x,y);
                pixel = grayImage(x,y);
                v= pixel>= centerPixel;
                lbpvalue=lbpvalue+v*2^(k-1);
            end
            localBinaryPattern(i,j)=lbpvalue;
            % 0 or 1,�����Ͻǿ�ʼ��˳ʱ��
%             pixel(1)=grayImage(i-1, j-1) >= centerPixel;  
%             pixel(2)=grayImage(i-1, j) >= centerPixel;   
%             pixel(3)=grayImage(i-1, j+1) >= centerPixel;  
%             pixel(4)=grayImage(i, j+1) >= centerPixel;     
%             pixel(5)=grayImage(i+1, j+1) >= centerPixel;    
%             pixel(6)=grayImage(i+1, j) >= centerPixel;      
%             pixel(7)=grayImage(i+1, j-1) >= centerPixel;     
%             pixel(8)=grayImage(i, j-1) >= centerPixel;
%             localBinaryPattern(i, j) = (pixel(1)*2^7+pixel(2)*2^6+pixel(3)*2^5+pixel(4)*2^4+pixel(5)*2^3+pixel(6)*2^2+pixel(7)*2+pixel(8));
        end
    end
    localBinaryPattern=localBinaryPattern(minX+1:maxX-1,minY+1:maxY-1);
end
