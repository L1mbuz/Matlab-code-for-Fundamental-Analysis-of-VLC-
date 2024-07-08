clc;
clear all;
theta =70;
m = - log10 (2) / log10 ( cosd ( theta )); 
l_x =5; l_y =5; l_z =3; 
I_0=0.73;
 x = linspace (0 , l_x , l_x*40 );
 y = linspace (0 , l_y , l_x*40 );
 [ XR , YR ]= meshgrid (x , y ); 
A =0.0001;
Ts=1;
 h=1.65;
n=1.5;
FOV_re=60;
P_t=0.02;
 LED_origin_x=1;LED_origin_y=1;
g=( n ^2) /( sind ( FOV_re ).^2) ;
 H_0=0;
 for i=1:60
     for j=1:60
  LED_x=LED_origin_x+(i-1)*0.01;LED_y=LED_origin_y+(j-1)*0.01;
 D_d = sqrt (( LED_x - XR ) .^2+( LED_y - YR ) .^2+ h ^2) ;
 cosphi = h ./ D_d ; 
 receiver_angle = acosd ( cosphi ) ;
 temp=((m+1) * A .*  cosphi.^(m+1) * Ts*g) ./(2* pi .* D_d .^2) ;
temp ( find ( abs ( receiver_angle ) > FOV_re ) ) =0;
 H_0=H_0+temp;
     end
 end
 P_r=H_0*P_t;
  P2=rot90( P_r,1);
  P3=rot90( P_r,2);
 P4=rot90( P_r,3);
 P_r_total=P_r+P2+P3+P4;
 P_r_total_dbm=10*log10(P_r_total*1000);
 meshc(x,y,P_r_total_dbm);
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Received Power(dbm)');
axis ([ 0 5 0 5 -3 5]) ;
max( max(P_r_total_dbm) )
