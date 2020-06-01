pkg load io;
fecha = {'28/03', '30/03', '31/03', '03/04', '05/04', '07/04', '09/04', '17/04', '01/05', '03/05'};
timeFormat='dd/mm';
xdatenum=datenum(fecha,timeFormat);

datos = xlsread('DatosArgentina.xlsx');

%y = Ae^(Bx)
%log(y) = log(A) + Bx
%Aplicar log a la entrada y
%log(A) = c0 -> c0 = exp(C0)
%B = c1
[c0,c1] = ajuste_lineal(xdatenum,log(datos(:,2)));
c0 = exp(c0);

hold on

scatter(xdatenum,datos(:,2))
plot(xdatenum,c0*exp(xdatenum*c1));
datetick('x',timeFormat,'keepticks')

hold off