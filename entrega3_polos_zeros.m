clear;
clear all;
clc;
%% Entrega 3 - PMR3523 Controle Moderno
% Cálculo de Polos e Zeros
% Ângelo Bianco Yanagita - 6649978
% Diôgo Cavalcante Rodrigues Lopes - 11180872
% 
% 
% As equações utilizadas são:
% 
% 
% 
% Sendo as variáveis:
% 
% 
% 
% $$\begin{array}{l}x={\left\lbrack \begin{array}{cccccc}x_g  & y_g  & \psi 
% \; & u & v & r\end{array}\right\rbrack }^T \\u={\left\lbrack \begin{array}{ccc}F_x  
% & F_y  & F_z \end{array}\right\rbrack }^T \\y={\left\lbrack \begin{array}{ccc}x_g  
% & y_g  & \psi \;\end{array}\right\rbrack }^T \end{array}$$
% 
% Considerando os parâmetros do navio de suporte à plataforma Maersk Handler:  
% 
% 
% 
% 
% 
% 

m = 7240e3;
izz = 2750e6;
m11 = 640e3;
m22 = 6400e3;
m66 = 1560e6;
m26 = 7900e3;
%% 
% Linearização de acordo com as seguintes condições:
% 
% 
% 
% 
% 
% e entradas nos esforços propulsores todas nulas.

syms xg psi u v r Fx Fy Fz v_dot_lin r_dot_lin

xg_dot = u*cos(psi) - v*sin(psi)
yg_dot = u*sin(psi) + v*cos(psi)
psi_dot = r
u_dot = (Fx + (m*xg + m26)*r^2 + (m + m22)*v*r)/(m+m11)
v_dot = (Fy -(m*xg + m26)*r_dot_lin - (m + m11)*u*r)/(m+m22)
r_dot = (Fz - (m*xg + m26)*(v_dot_lin + u*r) - (m22 - m11)*u*v)/(izz + m66)
%% 
% Linearizando as equações:

lin_xg_dot = taylor(xg_dot, [u, v, psi], 0 , 'Order', 2)

lin_yg_dot = taylor(yg_dot, [u, v, psi], 0 , 'Order', 2)

lin_psi_dot = taylor(psi_dot, r , 0 , 'Order', 2)

lin_u_dot = taylor(u_dot, [xg, r, v, Fx], 0 , 'Order', 2)

lin_v_dot = taylor(v_dot, [xg, r_dot_lin, u, r, Fy], 0 , 'Order', 2)

lin_r_dot = taylor(r_dot, [xg, v_dot_lin, u, r, v, Fz], 0 , 'Order', 2)
%% 
% Substituindo o termo $\dot{\;r_{\textrm{lin}} }$ no termo $\dot{\;v_{\textrm{lin}} 
% }$, tem-se:
% 
% $$\dot{\;v_{\textrm{lin}} } =\frac{\;F_y }{13640000}-\frac{395}{682}\left(\frac{\;F_z 
% }{4310000000}-\frac{79}{43100}\dot{\;v_{\textrm{lin}} } \right)$$

a= 395/682;
b = 79/43100;
c = a*b
d = a/4310000000
%% 
% $$\dot{\;v_{\textrm{lin}} } -0,0011\dot{\;v_{\textrm{lin}} } =\frac{\;F_y 
% }{13640000}-d*F_z$$

e = 1/(13640000*0.9989)
f = d/0.9989
%% 
% $$\dot{\;v_{\textrm{lin}} } =e*F_y -f*F_z$$
% 
% Fazendo a substituição do termo $\dot{\;v_{\textrm{lin}} }$ no termo $\dot{\;r_{\textrm{lin}} 
% }$ tem-se:
% 
% $$\dot{\;r_{\textrm{lin}} } =\frac{F_z }{4310000000}-\frac{\;79}{43100}\left(e*F_y 
% -f*F_z \right)$$

g = (79/43100)*e
h = (79/43100)*f
i = (1/4310000000)+h
%% 
% $$\dot{\;r_{\textrm{lin}} } =-g*F_y \;+\;i*F_z$$
% 
% Colocando os termos na forma matricial do espaço de estados:
% 
% $$\begin{array}{l}\delta \dot{x} =A\delta x\left(t\right)+B\delta u\left(t\right)\\\;\delta 
% y=C\delta x\left(t\right)+D\delta u\left(t\right)\;\end{array}$$
% 
% 
% 
% $$A=\left\lbrack \begin{array}{cccccc}0 & 0 & 0 & 1 & 0 & 0\\0 & 0 & 0 & 0 
% & 1 & 0\\0 & 0 & 0 & 0 & 0 & 1\\0 & 0 & 0 & 0 & 0 & 0\\0 & 0 & 0 & 0 & 0 & 0\\0 
% & 0 & 0 & 0 & 0 & 0\end{array}\right\rbrack$$ $$B=\left\lbrack \begin{array}{ccc}0 
% & 0 & 0\\0 & 0 & 0\\0 & 0 & 0\\1,269*{10}^{-7}  & 0 & 0\\0 & e & -f\\0 & -g 
% & i\end{array}\right\rbrack$$ $$C=\left\lbrack \begin{array}{cccccc}1 & 0 & 
% 0 & 0 & 0 & 0\\0 & 1 & 0 & 0 & 0 & 0\\0 & 0 & 1 & 0 & 0 & 0\end{array}\right\rbrack$$ 
% $$D=\left\lbrack \begin{array}{c}0\end{array}\right\rbrack$$
% 
% 
% 
% Definindo as características do modelo:

A = [0 0 0 1 0 0
     0 0 0 0 1 0
     0 0 0 0 0 1
     0 0 0 0 0 0
     0 0 0 0 0 0
     0 0 0 0 0 0];
 
B = [0 0 0 
    0 0 0
    0 0 0
    1.269e-07 0 0
    0 e -f
    0 -g i];

C = [1 0 0 0 0 0
    0 1 0 0 0 0 
    0 0 1 0 0 0];

D = zeros(3,3);
%% Polos e zero do sistema:

polos_do_sistema = eig(A)
% A) Polos do sistema: ${\left\lbrack 0\;0\;0\;0\;0\;0\right\rbrack }^T$
% 
% B) Matriz de Transferência $G\left(S\right)$:

%Matriz adjunta
syms s

sI = [s 0 0 0 0 0
    0 s 0 0 0 0 
    0 0 s 0 0 0
    0 0 0 s 0 0
    0 0 0 0 s 0
    0 0 0 0 0 s]

sI_A = sI-A
adjunta = adjoint(sI_A)

%Determinante

determinante = det(sI_A)

%Zeros da MF
numerador = C*adjunta*B
zeros_MF = det(C*adjunta*B)

G = (C*adjunta*B)/determinante;

G_numeric = vpa((C*adjunta*B)/determinante)
% C) Pólos da Matriz de Transferência
% 
% 
% Como o determinante da Matriz de Transferência (MF) é $s^6$, *os polos da 
% MF são:* ${\left\lbrack 0\;0\;0\;0\;0\;0\right\rbrack }^T$
% 
% 
% D) Zero de transmissão
% Verificando os zeros de transmissão:

zero_de_transmissao = tzero(A,B,C,D)
%% 
% Não há zeros de transmissão.
% 
% 
% E) Verificando os zeros do sistema:

zeros_sistema = vpa(determinante*det(G))
%% 
% Portanto, não há zero no sistema.