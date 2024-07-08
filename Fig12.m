clc 
clear
FOV=40:5:90;
Datarate=[50,100,200,300,400,500]*1024*1024;
theta =70;
m = - log10 (2) / log10 ( cosd ( theta )); 
l_x =5; l_y =5; l_z =3; 
I_0=0.73;
Nx=l_x*10;
Ny=l_x*10;
 x = linspace (0 , l_x , Nx );
 y = linspace (0 , l_y , Ny );
 [ XR , YR ]= meshgrid (x , y ); 
A =0.0001;
Ts=1;
 h=1.65;
n=1.5;
FOV_re=60;
P_t=20e-3;
Rb = 100e6;
T=1/Rb;
c=3e8;
H_0_ISI=0;
 LED_origin_x=1;LED_origin_y=1;
g=( n ^2) /( sind ( FOV_re ).^2) ;
 H_0=0;
for ii=1:Nx/2
    for jj=1:Ny/2
        D_d(ii,jj)=1000;
       for kk=1:60
           for ll=1:60
  LED_x=LED_origin_x+(kk-1)*0.01;LED_y=LED_origin_y+(ll-1)*0.01;
 D_d(ii,jj) = min(  D_d(ii,jj),sqrt (( LED_x - x(ii) ) .^2+( LED_y - y(jj) ) .^2+ h ^2)  ) ;
           end
       end
    end
end
shortest_D=[D_d,   rot90(D_d,3) ;
           rot90(D_d,1)   ,rot90(D_d,2)    ;];
  

       SNR_max(1:6,length(FOV))=0;
       SNR_average(1:6,length(FOV))=0;
       SNR_min(1:6,length(FOV))=0;
  for k=1:6
       for n=1:length(FOV)
[SNR_average(k,n)] = Calulate_Variance_FOV_Datarate(FOV(n),Datarate(k),shortest_D);
       end
  end
  
for k=1:6
  plot(FOV,SNR_average(k,:));
  hold on
end

legend("50Mb/s","100Mb/s","200Mb/s","300Mb/s","400Mb/s","500Mb/s")
ylabel("SNR(dB)")
xlabel("FOV(deg)")
  
  
  
  