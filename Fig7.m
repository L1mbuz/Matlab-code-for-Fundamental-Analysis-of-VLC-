clc;
clear all;
theta =70;
m = - log10 (2) / log10 ( cosd ( theta )); 
l_x =5; l_y =5; l_z =1.65; 
I_0=0.73;
Nx=l_x*10;
Ny=l_y*10;
Nz=l_z*10;
 x = linspace (0 , l_x ,Nx  );
 y = linspace (0 , l_y ,Ny  );
 z=linspace (0 , l_z ,Nz  );
 
 receive_x=0.01;receive_y=0.01;
A =0.0001;
Ts=1;
n=1.5;
rho=1;
FOV_re=60;
P_t=0.02;
g=( n ^2) /( sind ( FOV_re ).^2) ;
position_LED=[1.25,1.25,l_z];
dAwall=l_z*l_x/(Nx*Nz);
H_0(1,3600*4)=0;
t(1,3600*4)=0;
h=1.65;
LED_origin_x=[1,1,3.5,3.5];LED_origin_y=[1,3.5,1,3.5];
c=3e8;
l=1;
%%%%%%%%%%%%
 H_0=0;
 for n=1:4
 for i=1:60
     for j=1:60
  LED_x=LED_origin_x(n)+(i-1)*0.01;LED_y=LED_origin_y(n)+(j-1)*0.01;
 D_d = sqrt (( LED_x - receive_x ) .^2+( LED_y - receive_y ) .^2+ h ^2) ;
 cosphi = h ./ D_d ; 
 receiver_angle = acosd ( cosphi ) ;
 temp=((m+1) * A .*  cosphi.^(m+1) * Ts*g) ./(2* pi .* D_d .^2) ;
temp ( find ( abs ( receiver_angle ) > FOV_re       ) ) =0;
H_0(l)=temp;
 t(l)=D_d/c *10^9;
 l=l+1;
     end
 end
 end
 
H_0=H_0/max(H_0);
 plot([0:floor(t(1)),t],[zeros(1,ceil(t(1))),H_0]);
 xlabel("t/ns");ylabel("LOS Impulse Response")
 axis([0 20 0 1])
 
 
 


