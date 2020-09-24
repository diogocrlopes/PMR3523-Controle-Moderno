function [i]=plota_graficos(psi_linear, yg_non_linear, xg_non_linear, xg_linear, yg_linear, psi_non_linear,i, title_str_xy,title_str_yaw)
    figure(i)
    h=plot(xg_linear.Data,yg_linear.Data,xg_non_linear.Data,yg_non_linear.Data);
    set(h, {'color'}, {'b';'r'});
    title(title_str_xy,'Interpreter','latex');
    xlabel('Eixo x (m)');
    ylabel('Eixo y (m)');
    legend('Sistema linearizado','Sistema n\~ao-linear')
    i= i+1;
    
    figure(i)
    
    h=plot(psi_linear.Time,psi_linear.Data,psi_non_linear.Time,psi_non_linear.Data);
    set(h, {'color'}, {'b';'r'});
    title(title_str_yaw,'Interpreter','latex');
    xlabel('Tempo (s)');
    ylabel('Yaw (rad)');
    legend('Sistema linearizado','Sistema n\~ao-linear')
    i= i+1;
end