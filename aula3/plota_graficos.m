function i=plota_graficos(psi_linear, yg_non_linear, xg_non_linear, xg_linear, yg_linear, psi_non_linear,i)
 figure(i)
 plot(xg_linear.Data,yg_linear.Data,xg_non_linear.Data,yg_non_linear.Data);
 title({'Resposta em malha aberta do deslocamento dos dois sistemas', ''});
 xlabel('Eixo x (m)');
 ylabel('Eixo y (m)');
 legend('Sistema linearizado','Sistema não-linear')
 i= i+1;

 figure(i)

 plot(psi_linear.Time,psi_linear.Data,psi_non_linear.Time,psi_non_linear.Data);
 title({'Resposta em malha aberta da guinada dos dois sistemas', ''});
 xlabel('Tempo (s)');
 ylabel('Resposta (rad)');
 legend('Sistema linearizado','Sistema não-linear')
 i= i+1;
end

