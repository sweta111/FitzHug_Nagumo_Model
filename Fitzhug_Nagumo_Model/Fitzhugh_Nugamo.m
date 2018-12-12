close all;
clear
clc
%------------------------------------------------------------------------%
% Assignment 2
% FitzHugh-Nagumo neuron model
% Getting the Phase Graph at Iext == 0 
%------------------------------------------------------------------------%
a = 0.5; 
b = 0.1; 
r = 0.1; 
Iext = 0;
% Iext = 0.01;
% Iext = 0.8495;
% Iext = 0.5485;
syms v w;
%-----------------v_nullcline---------------------------------------------%
dotv = v * (a - v) * (v - 1) - w + Iext;
figure(1)
h1 = ezplot(dotv==0);
hold on
%----------------w_nullcline----------------------------------------------%
dotw = b * v - r * w;
h2 = ezplot(dotw==0);
title(['Phase Plot Superimposed at I_{ext} = ',num2str(Iext),', a = ', num2str(a), ', b = ', num2str(b), ', r = ', num2str(r)]);
set(h1, 'color','b','LineWidth',1.5);
set(h2, 'color','r','LineWidth',1.5);
xlim([-1 2]);
ylim([-1 2]);
% xlim([-0.2 1.5]);
% ylim([-0.2 0.4]);
xlabel('v');
ylabel('w');
legend('v-nullcline','w-nullcline')
hold off

%------------------------------------------------------------------------%
% Finding the trajectory on the phase plane at Iext == 0 
% V(0) > a  and ? (0)= 0
%------------------------------------------------------------------------%
dt = 0.1;
v = 0.4;
v_0 = v;
w = 0;
w_0 = w;
figure(2)
h1 = ezplot(dotv==0);
hold on
h2 = ezplot(dotw==0);
title(['Trajectory on the phase plane at I_{ext} = ',num2str(Iext),', a = ', num2str(a),', v = ', num2str(v),', w = ', num2str(w), ', b = r = ', num2str(b)]);
set(h1, 'color','b','LineWidth',1.5);
set(h2, 'color','r','LineWidth',1.5);
xlim([-1 2]);
ylim([-1 2]);
% xlim([-0.2 1.5]);
% ylim([-0.2 0.4]);
xlabel('v');
ylabel('w');

for i = 1:1:1000
    deltav = (v(i) * (a - v(i)) * (v(i) - 1) - w(i) + Iext) * dt;
    deltaw = (b * v(i) - r * w(i)) * dt;
    v(i+1) = v(i) + deltav;
    w(i+1) = w(i) + deltaw;
end
graph1 = plot(v,w,'g');
set(graph1, 'LineWidth',2);
% text(0.56,0.56,'(Unstable Point)');
% legend('v-nullcline','w-nullcline','trajectory')
hold off

%------------------------------------------------------------------------%
% Finding the V(t) vs t and W(t) vs t plots at Iext == 0 
%------------------------------------------------------------------------%
dt = 0.01;
v = 0.4;
v_0 = v;
w = 0;
w_0 = w;
t = 0;
for i = 1:1:50000
    deltav = (v(i) * (a - v(i)) * (v(i) - 1) - w(i) + Iext) * dt;
    deltaw = (b * v(i) - r * w(i)) * dt;
    v(i+1) = v(i) + deltav;
    w(i+1) = w(i) + deltaw;
    t(i+1) = t(i) + dt;
end 
    figure(3)
    graph2 = plot(smooth(t),smooth(v),'b');
    set(graph2, 'LineWidth',1.5);
    hold on
    graph3 = plot(smooth(t),smooth(w),'r');
    set(graph3, 'LineWidth',1.5);
    legend('V(t) vs t','W(t) vs t');
    

