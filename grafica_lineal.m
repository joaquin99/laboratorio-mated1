pkg load io;
fecha = {'28/03', '30/03', '31/03', '03/04', '05/04', '07/04', '09/04', '17/04', '01/05', '03/05'};
timeFormat='dd/mm';
xdatenum=datenum(date,timeFormat);

datos = xlsread('DatosArgentina.xlsx');
[c0,c1] = ajuste_lineal(xdatenum,datos(:,2));

hold off

scatter(xdatenum,datos(:,2))
plot(xdatenum,c1*xdatenum+c0);
datetick('x',timeFormat,'keepticks')

hold on

