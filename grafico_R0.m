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

datoAMostrar = 'Muertos';

cotaInf = [0.05/(1/2+coef_muerte)];
cotaSup = [0.9/(1/20+coef_muerte)];
R0 = R0 = [(cotaInf+cotaSup)/2];


hold on
%plot(xdatenum,coef_muerte,'DisplayName','Tendencia');
%plot(xdatenum,cotaInf,'DisplayName','Cota inferior');
%plot(xdatenum,cotaSup,'DisplayName','Cota superior');
plot(xdatenum,R0,'DisplayName','RO')

errorbar(xdatenum,R0,R0-cotaInf,cotaSup-R0);

datetick('x',timeFormat,'keepticks');

xlabel('Fecha');
ylabel('Coeficiente');
legend('Location','northwest');
hold off
