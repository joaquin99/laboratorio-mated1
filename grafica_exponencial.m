pkg load io;

fecha = {'28/03', '30/03', '31/03', '03/04', '05/04', '07/04', '09/04', '17/04', '01/05', '03/05'};
parseoDatos = [0;2;3;6;8;10;12;20;34;36];
timeFormat='dd/mm';
xdatenum=datenum(fecha,timeFormat);

lugar = 'Argentina';
datoAMostrar = 'Muertos';

datos = xlsread(['Datos',lugar,'.xlsx']);
[c0,c1] = ajuste_lineal(parseoDatos,log(datos(:,elegirDato(datoAMostrar(1)))));

hold on

scatter(xdatenum,datos(:,elegirDato(datoAMostrar(1))),'DisplayName',[datoAMostrar,' en ',lugar])
plot(xdatenum,exp(c0)*exp(c1*parseoDatos),'DisplayName','Tendencia');
datetick('x',timeFormat,'keepticks')

xlabel('Fecha');
ylabel('Cantidad');
legend('Location','southeast');

hold off
