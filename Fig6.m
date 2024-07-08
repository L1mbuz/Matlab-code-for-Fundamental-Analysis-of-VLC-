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
 [ XR , YR ]= meshgrid (x , y ); 
A =0.0001;
Ts=1;
n=1.5;
rho=1;
FOV_re=60;
P_t=0.02;
g=( n ^2) /( sind ( FOV_re ).^2) ;
position_LED=[1.25,1.25,l_z];
dAwall=l_z*l_x/(Nx*Nz);
dH_0(Nx,Ny)=0;
h=1.65;
LED_origin_x=1;LED_origin_y=1;
%%%%%%%%%%%%
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
 P_LOS=H_0*P_t;
  P2=rot90( P_LOS,1);
  P3=rot90( P_LOS,2);
 P4=rot90( P_LOS,3);
 P_LOS_total=P_LOS+P2+P3+P4;

%%%%%%%%%%%%%%%%%%%%%%%%%以x=0为方向的墙面
normV_Wall =[1,0,0];
for i=1:Nx
for j=1:Ny
receive_point=[x(i),y(j),0];

for k=1:Ny
for l=1:Nz
reflection_point=[0,y(k),z(l)];

D1=norm(position_LED-reflection_point);

cos_phi=abs(reflection_point(3)-position_LED(3))/D1;
V_led_reflection=reflection_point-position_LED;
cos_alpha= abs(dot(V_led_reflection,normV_Wall))/( norm(V_led_reflection)*norm(normV_Wall));
D2=norm(reflection_point-receive_point);
V_reflection_receive=reflection_point-receive_point;
cos_beta= abs(dot(V_reflection_receive,normV_Wall))/( norm(V_reflection_receive)*norm(normV_Wall));
cos_psi=abs(reflection_point(3)-receive_point(3))/D2;
if (  (acosd(cos_psi)<=FOV_re)   )
    temp=(m+1)*A*rho*dAwall*cos_phi^m*cos_alpha*cos_beta*Ts*g*cos_psi/(2*pi^2*D1^2*D2^2);
dH_0(i,j)=dH_0(i,j)+(m+1)*A*rho*dAwall*cos_phi^m*cos_alpha*cos_beta*Ts*g*cos_psi/(2*pi^2*D1^2*D2^2);
% if( temp~=0)
%     temp
% end
end
end
end
end
i
end
%%%%%%%%%%%%%%%%%%%%%%%%%以y=0为方向的墙面
normV_Wall =[0,1,0];
for i=1:Nx
for j=1:Ny
receive_point=[x(i),y(j),0];
for k=1:Ny
for l=1:Nz
reflection_point=[x(k),0,z(l)];
D1=norm(position_LED-reflection_point);
cos_phi=abs(reflection_point(3)-position_LED(3))/D1;
V_led_reflection=reflection_point-position_LED;
cos_alpha= abs(dot(V_led_reflection,normV_Wall))/( norm(V_led_reflection)*norm(normV_Wall));
D2=norm(reflection_point-receive_point);
V_reflection_receive=reflection_point-receive_point;
cos_beta= abs(dot(V_reflection_receive,normV_Wall))/( norm(V_reflection_receive)*norm(normV_Wall));
cos_psi=abs(reflection_point(3)-receive_point(3))/D2;
if (  acosd(cos_psi)<=FOV_re   )
dH_0(i,j)=dH_0(i,j)+(m+1)*A*rho*dAwall*cos_phi^m*cos_alpha*cos_beta*Ts*g*cos_psi/(2*pi^2*D1^2*D2^2);
end
end
end
end
i
end
%%%%%%%%%%%%%%%%%%%%%%%%%以x=5为方向的墙面
normV_Wall =[1,0,0];
for i=1:Nx
for j=1:Ny
receive_point=[x(i),y(j),0];

for k=1:Ny
for l=1:Nz
reflection_point=[5,y(k),z(l)];
D1=norm(position_LED-reflection_point);
cos_phi=abs(reflection_point(3)-position_LED(3))/D1;
V_led_reflection=reflection_point-position_LED;
cos_alpha= abs(dot(V_led_reflection,normV_Wall))/( norm(V_led_reflection)*norm(normV_Wall));
D2=norm(reflection_point-receive_point);
V_reflection_receive=reflection_point-receive_point;
cos_beta= abs(dot(V_reflection_receive,normV_Wall))/( norm(V_reflection_receive)*norm(normV_Wall));
cos_psi=abs(reflection_point(3)-receive_point(3))/D2;
if (  acosd(cos_psi)<=FOV_re    )
dH_0(i,j)=dH_0(i,j)+(m+1)*A*rho*dAwall*cos_phi^m*cos_alpha*cos_beta*Ts*g*cos_psi/(2*pi^2*D1^2*D2^2);
end
end
end
end
i
end
%%%%%%%%%%%%%%%%%%%%%%%%%以y=5为方向的墙面
normV_Wall =[0,1,0];
for i=1:Nx
for j=1:Ny
receive_point=[x(i),y(j),0];
for k=1:Ny
for l=1:Nz
reflection_point=[x(k),5,z(l)];
D1=norm(position_LED-reflection_point);
cos_phi=abs(reflection_point(3)-position_LED(3))/D1;
V_led_reflection=reflection_point-position_LED;
cos_alpha= abs(dot(V_led_reflection,normV_Wall))/( norm(V_led_reflection)*norm(normV_Wall));
D2=norm(reflection_point-receive_point);
V_reflection_receive=reflection_point-receive_point;
cos_beta= abs(dot(V_reflection_receive,normV_Wall))/( norm(V_reflection_receive)*norm(normV_Wall));
cos_psi=abs(reflection_point(3)-receive_point(3))/D2;
if (  acosd(cos_psi)<=FOV_re    )
dH_0(i,j)=dH_0(i,j)+(m+1)*A*rho*dAwall*cos_phi^m*cos_alpha*cos_beta*Ts*g*cos_psi/(2*pi^2*D1^2*D2^2);
end
end
end
end
i
end
 P_reflection=dH_0*P_t*3600;
  P2=rot90( P_reflection,1);
  P3=rot90( P_reflection,2);
 P4=rot90( P_reflection,3);
 P_reflection_total=(P_reflection+P2+P3+P4);
 P_total=P_reflection_total+P_LOS_total;
 P_total_dbm=10*log10( P_total*1000);
 meshc(x,y,P_total_dbm);
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Received Power(dbm)');
 P_LOS_dbm=10*log10( P_LOS_total*1000);
sum( sum(P_LOS_dbm) )/2500
sum( sum(P_total_dbm) )/2500
max( max(P_LOS_dbm) )
max( max(P_total_dbm) )

