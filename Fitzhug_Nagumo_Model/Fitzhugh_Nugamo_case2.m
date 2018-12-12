close all;
clear
clc
% %------------------------------------------------------------------------%
% % Assignment 2
% % FitzHugh-Nagumo neuron model
% % Getting the Phase Graph at Iext == 0 
% %------------------------------------------------------------------------%
a = 0.5; 
b = 0.1; 
r = 0.1; 
Iext = 0;
I_1 = 0;
I_2 = 1;
syms v w;
dt = 0.1;
v = 0.6;
v_0 = v;
w = 0;
w_0 = w;
epsilon = 0.001;
k = 1;
niter = 50000;
for Iext = 0:epsilon:1
 v = 0.6; 
 w = 0;
 t = 0;
for i = 1:niter
    dotv = (v(i) * (a - v(i)) * (v(i) - 1) - w(i) + Iext) * dt;
    dotw = (b * v(i) - r * w(i)) * dt;
    v(i+1) = v(i) + dotv;
    w(i+1) = w(i) + dotw;
    t(i+1) = t(i) + dt;
end
j=1;
TotalPeaks=zeros;
[peaks, locs]=findpeaks(v);
for temp=1:length(peaks)
if peaks(temp) >=0.5 % (Thresholding it by 0.5) minimum potential value at which a waveform is considered AP.
TotalPeaks(j)=peaks(temp);
j=j+1;
end
end
if TotalPeaks ~= 0
PeaksNo(k)=length(TotalPeaks);
else
PeaksNo(k)=0;
end

k=k+1
end
%ploting the behaviour of no. of action potential for the given external current
figure(4);
X=0:epsilon:1;
graph1 = plot(X,PeaksNo*1000/(niter/100));
set(graph1, 'LineWidth',1.5)
xlabel('External Current (I_{ext})');
xlim([0 1.2]);
ylabel('Firing (Discharge) Rate')
hold on;


for l=2:length(PeaksNo) %to define I1, I2
if PeaksNo(l)>PeaksNo(l-1)+20 
 I1=(l-1)*epsilon;
end
if PeaksNo(l)>20 && PeaksNo(l)<PeaksNo(l-1)
 I2=(l-1)*epsilon;
end
end
I1
I2
graph2 = plot([I1,I1],[0,500],'r');
set(graph2, 'LineWidth',1.5);
text(I1(1),-10,'I1');
text(I2(1),-10,'I2');
text(0.8,250,'I1 = 0.3300');
graph3 = plot([I2,I2],[0,500],'g');
set(graph3, 'LineWidth',1.5);
text(0.8,210,'I2 = 0.7670');


