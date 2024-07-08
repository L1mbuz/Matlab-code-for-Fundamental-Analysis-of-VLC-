function [shot_LED,ISI] = Calulate_Variance_Datarate(Data_rate,shortest_D)
theta =70;
m = - log10 (2) / log10 ( cosd ( theta )); 
l_x =5; l_y =5;
x = linspace (0 , l_x , l_x*40 );
y = linspace (0 , l_y , l_x*40 );
[ XR , YR ]= meshgrid (x , y ); 
A =0.0001;
Ts=1;
h=1.65;
n=1.5;
FOV_re=60;
P_t=20e-3;
Rb = Data_rate;
T=1/Rb;
c=3e8;
H_0_ISI=0;
 LED_origin_x=1;LED_origin_y=1;
g=( n ^2) /( sind ( FOV_re ).^2) ;
 H_0=0;
H_0_ISI(200,200)=0;
H_0_signal(200,200)=0;
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
  P2=rot90( P_r,1);
  P3=rot90( P_r,2);
 P4=rot90( P_r,3);
 P_r_total=P_r+P2+P3+P4;
  P2=rot90( P_r_ISI,1);
  P3=rot90( P_r_ISI,2);
 P4=rot90( P_r_ISI,3);
 P_ISI_total=P_r_ISI+P2+P3+P4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gamma = 0.54;
q = 1.60E-19;
B =Rb; 

omega_ISI=gamma^2*P_ISI_total.^2;
% Shot-noise variance 
omega_shot_LED = 2 * q * gamma * P_r_total*B;
%Thermal noise variance

shot_LED=mean(omega_shot_LED,'all');
ISI=mean(omega_ISI,'all');


end

