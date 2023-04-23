%GŁÓWNY RDZEŃ PROGRAMU WYKONUJĄCY OBLICZENIA
clear all
clc
close all

%Wskazanie czlonu, dla ktorego wyznaczone zostaną predkosci i przyspieszenia katowe 
body_number = 10;
wskaz_punkt = 'M';


t0 = 0;
tk = 0.01;
h = 0.01;
t=t0;
i=0;

[W,q] = PobierzDane();
Fi = Fi(W,q,t);

while (t<=tk)

    %przyblizenie startowe z przykładu 2.6
    q(:,1:3) = q(:,1:3) + q(:,4:6)*h + q(:,7:9)*((h*h)/2);
    q = NewRaph(W,q,t);

    Ft = Fi_t(W,q,t);
    J = Jacob(W,q,t);
    q_prim = -J\Ft;
    q(1:end-1,4:6) = reshape(q_prim,[3,size(q,1)-1])';

    Acc = acc(W,q,t);
    q_bis = J\Acc;
    q(1:end-1,7:9) = reshape(q_bis,[3,size(q,1)-1])';

    t = t + h;


    if(i == 0)
        [t_point_xy,t_point_v_xy,t_point_a_xy] = TrackPoint(q,W,wskaz_punkt);
        plot_dq = q(body_number,6);
        plot_ddq = q(body_number,9);
        plot_t = t;
    end

    [point_xy,point_v_xy,point_a_xy] = TrackPoint(q,W,wskaz_punkt);
 
    t_point_xy = [t_point_xy;point_xy];
    t_point_v_xy = [t_point_v_xy;point_v_xy];
    t_point_a_xy = [t_point_a_xy;point_a_xy];

    plot_dq = [plot_dq,q(body_number,6)];
    plot_ddq = [plot_ddq,q(body_number,9)];
    plot_t = [plot_t,t];
    i = i + 1;

    data{i} = 1000.*q; 
end

disp('INFO: Wykonano pomyslnie!')

%POSTPROCESSING



figure('Name', 'Angular Velocity of Selected Body');
plot(plot_t, 180/pi*plot_dq)
grid on
tytul1 = ['Prędkość kątowa ciała ', num2str(body_number)];
title(tytul1)
xlabel('czas [s]')
ylabel('Prędkość kątowa [deg/s]')

figure('Name', 'Angular Acceleration of Selected Body');
plot(plot_t, 180/pi*plot_ddq)
grid on
tytul2 = ['Przyspieszenie kątowe ciała ', num2str(body_number)];
title(tytul2)
xlabel('czas [s]')
ylabel('Przyspieszenie kątowe [deg2/s]')

figure('Name', 'Współrzędna X wybranego punktu mechanizmu');
plot(plot_t, 1000*t_point_xy(:,1))
grid on
title3 = ['Współrzędna X punktu ',wskaz_punkt, ' w funkcji czasu'];
title(title3)
xlabel('czas [s]')
ylabel('Współrzędna X [mm]')

figure('Name', 'Współrzędna Y punktu wybranego punktu mechanizmu');
plot(plot_t, 1000*t_point_xy(:,2))
grid on
tytul4 = ['Współrzędna Y punktu ', wskaz_punkt, ' w funkcji czasu'];
title(tytul4)
xlabel('czas [s]')
ylabel('Współrzędna Y [mm]')

figure('Name', 'Składowa X prędkości wybranego punktu mechanizmu');
plot(plot_t, 1000*t_point_v_xy(:,1))
grid on
tytul5 = ['Składowa X prędkości liniowej punktu ',wskaz_punkt ,' mechanizmu'];
title(tytul5)
xlabel('czas [s]')
ylabel('składowa X prędkości [m/s]')

figure('Name', 'Składowa Y prędkości wybranego punktu mechanizmu');
plot(plot_t, 1000*t_point_v_xy(:,2))
grid on
tytul6 = ['Składowa Y prędkości liniowej punktu ',wskaz_punkt ,' mechanizmu'];
title(tytul6)
xlabel('czas [s]')
ylabel('składowa Y prędkości [m/s]')

figure('Name', 'Składowa X przyspieszenia wybranego punktu mechanizmu');
plot(plot_t, 1000*t_point_a_xy(:,1))
grid on
tytul7 = ['Składowa X przyspieszenia liniowego punktu ', wskaz_punkt, ' mechanizmu'];
title(tytul7)
xlabel('czas [s]')
ylabel('składowa X przyspieszenia [m/s2]')

figure('Name', 'Składowa Y przyspieszenia wybranego punktu mechanizmu');
plot(plot_t, 1000*t_point_a_xy(:,2))
grid on
tytul8 = ['Składowa Y przyspieszenia liniowego punktu ', wskaz_punkt, ' mechanizmu'];
title(tytul8)
xlabel('czas [s]')
ylabel('składowa Y przyspieszenia [m/s2]')


