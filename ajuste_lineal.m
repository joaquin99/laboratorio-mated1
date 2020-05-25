function [c0,c1] = ajuste_lineal(x,y)
sumx = 0;
sumy = 0;
sumxy = 0;
sumx2 = 0;
for i = 1:size(x)(1),
    disp(x(i));
    disp(y(i));
    sumx = sumx + x(i);
    sumy = sumy + y(i);
    sumxy = sumxy + x(i)*y(i);
    sumx2 = sumx2 + x(i)*x(i);
endfor
xm = sumx/size(x)(1);
ym = sumy/size(x)(1);
c1 = (size(x)(1)*sumxy - sumx*sumy)/(size(x)(1)*sumx2 - sumx*sumx);
c0 = ym - c1*xm;
end

