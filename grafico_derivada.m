pkg load io;

fecha = {'28/03', '30/03', '31/03', '03/04', '05/04', '07/04', '09/04', '17/04', '01/05', '03/05'};
timeFormat='dd/mm';
xdatenum=datenum(fecha,timeFormat);

%Se leen los datos de los muertos para encontrar su derivada
lugar = 'Argentina';
datoAMostrar = 'Muertos';
datos = xlsread(['Datos',lugar,'.xlsx']);

xparseo = [0;2;3;6;8;10;12;20;34;36];
[c0,c1] = ajuste_lineal(xparseo,log(datos(:,elegirDato(datoAMostrar(1)))));

%Calculo las derivadas en cada punto, con h=0.01
derivadas = [deriv_centrada_exp(xparseo,0.01,c0,c1)];

%Coeficiente alfa de muertes
coef_muerte = derivadas;

%Para calcular alfa se divide la derivada de muertes por los infectados
datoAMostrar = 'Infectados';

for i=1;size(derivadas)(1),
  coef_muerte(1) = coef_muerte(1)/(datos(:,elegirDato(datoAMostrar(1)))(i));
endfor

%Se toma la media aritmetica de alfa
media_coef = mean(coef_muerte);

datoAMostrar = 'Muertos';

hold on

scatter(xdatenum,datos(:,elegirDato(datoAMostrar(1))),'DisplayName',[datoAMostrar,' en ',lugar])
plot(xdatenum,exp(c0)*exp(xparseo*c1),'DisplayName','Tendencia');
plot(xdatenum,derivadas,'DisplayName','Derivada');
datetick('x',timeFormat,'keepticks');

xlabel('Fecha');
ylabel('Cantidad');
legend('Location','northwest');
hold off
