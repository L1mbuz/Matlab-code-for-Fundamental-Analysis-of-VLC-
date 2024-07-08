clc;
clear;
theta =70;
 m = - log10 (2) / log10 ( cosd ( theta )); 
l_x =5; l_y =5; l_z =3; 
I_0=0.73;
 x = linspace (0 , l_x , l_x*40 );
 y = linspace (0 , l_y , l_x*40 );
 [ XR , YR ]= meshgrid (x , y ); 
 h=1.65;
 LED_origin_x=1;LED_origin_y=1;
 E_hor_sum=0;
 for i=1:60
     for j=1:60
  LED_x=LED_origin_x+(i-1)*0.01;LED_y=LED_origin_y+(j-1)*0.01;
 D_d = sqrt (( LED_x - XR ) .^2+( LED_y - YR ) .^2+ h ^2) ;
 cosphi = h ./ D_d ; 
 E_hor_sum=E_hor_sum+(I_0 *  cosphi.^(m+1)) ./(D_d.^2);
     end
 end
 E2=rot90(E_hor_sum,1);
  E3=rot90(E_hor_sum,2);
 E4=rot90(E_hor_sum,3);
 E_total=E_hor_sum+E2+E3+E4;
meshc(x,y,E_total);
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Illuminance(lx)');
max_lluminance=max(max(E_total))
min_lluminance=min(min(E_total))


