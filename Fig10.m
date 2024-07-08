clc 
clear
Data_rate=[10^5,10^6,10^7,10^8,10^9,10^10,10^11,10^12];
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
P_t=20e-3;
Rb = 100e6;
T=1/Rb;
c=3e8;
H_0_ISI=0;
 LED_origin_x=1;LED_origin_y=1;
g=( n ^2) /( sind ( FOV_re ).^2) ;
 H_0=0;
 %%%%%%%%%%%%%%%%%%第一个到达信号所走距离
for ii=1:100
    for jj=1:100
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
  %%%%%%%%%%%%%%%%%%%%%%%
       shot_LED(1,1:8)=0;
       ISI(1,1:8)=0;
  for n=1:8
[shot_LED(n),ISI(n)] = Calulate_Variance_Datarate(Data_rate(n),shortest_D);
  end
  myColors = {'k','#f06464'};
  yyaxis right
    plot(1:8,shot_LED)
  p.Color = myColors{2};
  hold on
    yyaxis left
     plot(1:8,ISI)
    p.Color = myColors{1};
  xticklabels(["10^{5}" "10^{6}" "10^{7}" "10^{8}" "10^{9}" "10^{10}" "10^{11}" "10^{12}"]);
  ylabel("Mean Noise Variance")
  xlabel("Data Rate(b/s)")
  legend("ISI","Shot LED",'Location','NorthWest')
  
  
  
  
  
  
  
  
  
  