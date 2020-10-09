function [freq] = bode_sys_plot(c,G_numeric)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
syms s 

x=[1 2 2 3];
y=[1 2 3 3];
    
[nf, df] = numden(G_numeric(y(c),x(c)));

tfn = sym2poly(nf);
tfd = sym2poly(df);

H = tf(tfn, tfd);

options = bodeoptions;
options.FreqUnits = 'Hz';
figure(c);

if c==1
    [mag,phase,wout]=bode(H,0.00001:0.01:30);

elseif c==2

    [mag,phase,wout]=bode(H,0.00001:0.01:200);

else
    [mag,phase,wout]=bode(H,0.00001:0.01:10);
end



bode(H,options)
grid on

differ=abs(20*log(mag(:,:,1))+3);
freq=wout(1);

for i=2:length(mag(:,:))
    differ_i=abs(20*log(mag(:,:,i))+3);
    if differ_i<differ
        freq=wout(i)/(2*pi);
        differ=differ_i;
    end
end

end

