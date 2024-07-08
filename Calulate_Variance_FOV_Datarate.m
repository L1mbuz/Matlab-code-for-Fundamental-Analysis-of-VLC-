function [SNR_average] = Calulate_Variance_FOV_Datarate(FOV,Datarate,shortest_D)
theta =70;
m = - log10 (2) / log10 ( cosd ( theta )); 
l_x =5; l_y =5;
Nx=l_x*10;
Ny=l_x*10;
x = linspace (0 , l_x , Nx );
y = linspace (0 , l_y , Ny );
[ XR , YR ]= meshgrid (x , y ); 
A =0.0001;
Ts=1;
h=1.65;
n=1.5;
FOV_re=FOV;
P_t=20e-3;
Rb = Datarate;
T=1/Rb;
c=3e8;
H_0_ISI=0;
 LED_origin_x=1;LED_origin_y=1;
g=( n ^2) /( sind ( FOV_re ).^2) ;
 H_0=0;
H_0_ISI(Nx,Nx)=0;
H_0_signal(Nx,Nx)=0;
%%%%%%%%%%%%%%%%%ISI
  for i=1:60
     for j=1:60
  LED_x=LED_origin_x+(i-1)*0.01;LED_y=LED_origin_y+(j-1)*0.01;
 D_d = sqrt (( LED_x - XR ) .^2+( LED_y - YR ) .^2+ h ^2) ;
 cosphi = h ./ D_d ; 
 receiver_angle = acosd ( cosphi ) ;
 temp=((m+1) * A .*  cosphi.^(m+1) * Ts*g) ./(2* pi .* D_d .^2) ;
temp ( find ( abs ( receiver_angle ) > FOV_re ) ) =0;
t=(D_d-shortest_D)/c;
t( find( t>=T ) )=T;
 H_0=H_0+temp;
 H_0_ISI=H_0_ISI+temp.*(t./T);
 H_0_signal=H_0_signal+temp.*(1-t./T);
     end
 end
 
 
 P_r=H_0*P_t;
 P_r_ISI=H_0_ISI*P_t;
  P_r_signal=H_0_signal*P_t;
  P2=rot90( P_r,1);
  P3=rot90( P_r,2);
 P4=rot90( P_r,3);
 P_r_total=P_r+P2+P3+P4;
  P2=rot90( P_r_ISI,1);
  P3=rot90( P_r_ISI,2);
 P4=rot90( P_r_ISI,3);
 P_ISI_total=P_r_ISI+P2+P3+P4;
  P2=rot90( P_r_signal,1);
  P3=rot90( P_r_signal,2);
 P4=rot90( P_r_signal,3);
 P_signal_total=P_r_signal+P2+P3+P4;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I2 = 0.562;
Ibg=5100e-6;
gamma = 0.54;
q = 1.60E-19;
k=1.38E-23;
Tk=295;
yeta=112E-8;
G=10;
 FET=1.5;
 I3=0.0868;
B =Rb; 
gm=30e-3;
% Shot-noise variance 
omega_shot = 2 * q * gamma * P_r_total*B+2*q*Ibg*I2*B; 
%Thermal noise variance
omega_thermal = (8*pi*k*Tk*yeta*A*I2*B^2)/G  +(16*pi^2*k*Tk*FET*yeta^2*A^2*I3*B^3)/gm ;
% Total noise variance 
omega_total = omega_shot + omega_thermal + gamma^2*P_ISI_total.^2; 
% SNR %
SNR = (gamma^2 * P_signal_total .^2)./ omega_total;
SNRdB = 10*log10(SNR);

SNR_average=mean(SNRdB,'all');


end

