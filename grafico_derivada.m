pkg load io;

fecha = {'28/03', '30/03', '31/03', '03/04', '05/04', '07/04', '09/04', '17/04', '01/05', '03/05'};
timeFormat='dd/mm';
xdatenum=datenum(fecha,timeFormat);

lugar = 'Argentina';
datoAMostrar = 'Muertos';
datos = xlsread(['Datos',lugar,'.xlsx']);

xparseo = [0;2;3;6;8;10;12;20;34;36];
[c0,c1] = ajuste_lineal(xparseo,log(datos(:,elegirDato(datoAMostrar(1)))));

derivadas = [deriv_centrada_exp(xparseo,0.01,c0,c1)];
disp(derivadas);

coef_muerte = derivadas;

for i=1;size(derivadas)(1),
  coef_muerte(1) = coef_muerte(1)/(exp(c0)*exp(xparseo(i)*c1));
endfor
disp(coef_muerte);
media_coef = mean(coef_muerte);
disp(media_coef);


hold on

scatter(xdatenum,datos(:,elegirDato(datoAMostrar(1))),'DisplayName',[datoAMostrar,' en ',lugar])
plot(xdatenum,exp(c0)*exp(xparseo*c1),'DisplayName','Tendencia');
plot(xdatenum,derivadas,'DisplayName','Derivada');
datetick('x',timeFormat,'keepticks');

xlabel('Fecha');
ylabel('Cantidad');
legend('Location','southeast');
hold off
