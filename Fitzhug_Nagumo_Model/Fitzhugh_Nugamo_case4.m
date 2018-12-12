close all;
clear
clc
%------------------------------------------------------------------------%
% Assignment 2
% FitzHugh-Nagumo neuron model
% Getting the Phase Graph at Iext == 0.01 
%------------------------------------------------------------------------%
a = 0.5; 
b = 0.01; 
r = 0.8; 
Iext = 0.01; %0.33 & 0.7670;
i = 1;
dx=0.0000001;
v1 = -0.2:dx:1.2; 
v2= -0.2:dx:1.2;
%-----------------v_nullcline---------------------------------------------%
v=v2.*(a-v2).*(v2-1)+Iext;   
%----------------w_nullcline----------------------------------------------%
w=v1.*b/r;                   
diff = abs(w-v);  
temp = [length(diff-1),1]; 
for i= 2:length(diff)-1
    temp(i) = diff(i)<diff(i+1) && diff(i)< diff(i-1);
end
intercept = find(temp==1);
pw1 = w(intercept(1));
pw2 = w(intercept(2));
pw3 = w(intercept(3));
pv1 = v1(intercept(1));
pv2 = v1(intercept(2));
pv3 = v1(intercept(3));
v_(1)= pv2 + 0.01;
w_(1)=0;
t(1)=0;
dt=0.001;
for i=1:50000
    t(i+1)=t(i)+dt;
    v_(i+1) = v_(i)+ dt*((v_(i)*(a-v_(i))*(v_(i)-1))-w_(i)+Iext);
    w_(i+1) = w_(i)+ dt*(b.*v_(i)-r*w_(i));
end

% figure(1)
% graph1 = plot (t,v_,...
%     t,w_)
% set(graph1,'LineWidth',1.5);

figure(2)
p = plot(v1, w,'r',...
         v2,v,'b',...
         v_,w_,'g',...
         pv1, pw1,'ko',...
         pv2, pw2,'ko',...
         pv3, pw3,'ko');
     hold on
set(p,'LineWidth',1.5); 
xlabel('v');
ylabel('w');
title(['Phase Plot of Bistability at I_{ext} = ',num2str(Iext),', a = ', num2str(a), ', b = ', num2str(b), ', r = ', num2str(r)]);
v_(1)= pv2-0.01; 
for i=1:500000
    t(i+1)=t(i)+dt;
    v_(i+1) = v_(i)+ dt*((v_(i)*(a-v_(i))*(v_(i)-1))-w_(i)+Iext);
    w_(i+1) = w_(i)+ dt*(b.*v_(i)-r*w_(i));
end   
graph2 = plot(v_,w_,'g')
set(graph2,'LineWidth',1.5)
x1 = pv1+0.01; 
y1 = pw1+0.01;
txt1 = 'P1';
txt1_1 = 'Stable Point';
x2 = pv2-0.02;
y2 = pw2+0.01;
txt2 ='P2';
txt2_1 = 'Saddle Point';
x3 = pv3+0.01;
y3 = pw3+0.01;
txt3 = 'P3';
txt3_1 = 'Stable Point';

text(x1,y1,txt1)
text(x2,y2,txt2)
text(x3,y3,txt3)
text(x1, y1+0.01, txt1_1)
text(x2, y2+0.01, txt2_1)
text(x3, y3+0.01, txt3_1)

v=zeros(1000,1);
w=zeros(1000,1);
