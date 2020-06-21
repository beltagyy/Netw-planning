%function final = Planning(rrh,users)
%ploting the area... users and rrhs
%function rb= Planning(b)
clc
clear all
rec_area= rectangle('Position',[1 1 40 40]);
axis([0 50 0 50])

rec_area.FaceColor = [0 0.9 0.999];
rec_area.EdgeColor = 'b';
rec_area.LineWidth = 1.5;
hold on 
grid on
a = 1;
b = 40;
%Number of RRH'S
xrrh = (b-a).*rand(6,1) + a; %RRH
yrrh= (b-a).*rand(6,1) + a;  %RRH


plot(xrrh,yrrh,'bd','MarkerSize',10)
hold on
%Number of USERS
xusers = (b-a).*rand(100,1) + a;  %MT
yusers= (b-a).*rand(100,1) + a;   %MT
plot(xusers,yusers,'r.','MarkerSize',10)
hold off
rh=[xrrh,yrrh];
mt=[xusers,yusers];
%distance calculation for each USER an rrh:
%Generating all distances combinations and then applying local search for min distance. 
distances = pdist2(mt(:, 1:2), rh(:, 1:2));
minDistance = min(distances(:));
[rowOfA, rowOfB] = find(distances == minDistance);
[value , location]= min (distances');
distances_rrh =[];
for i=1:6

for y=1:1:6
distances_rrh(i,y)=sqrt(((rh(i)-rh(y))^2)+((rh(i,2)-rh(y,2))^2)) ;  
if distances_rrh(i,y)==0
    distances_rrh(i,y)=inf;
end

end
end
[min_distance_rrh , min_location_rrh]=min(distances_rrh);
Pt= 5 ; %dBm  Max Transmit Power
NRB= 25; % Max Number of resource blocks per BBU
%gains in db ... we change them from db to dbm
Gr=0+30;
Gt=0+30;
%frequnecy in mhz
f=2350;
pathloss_exp=3;
%we multiply distance by 1000 to change it from m to km
wall_loss=6.*((value(:).*1000)./5);
%recieved signal power that is computed in dbm (S)
S=Pt-10.*log10(NRB)+Gt+Gr-20.*log10(f)-10.*pathloss_exp.*log10((value(:)).*1000)-(wall_loss+30)+28;
%bandwidth of one LTE resource block
B=180000;
%background noise in dbm = N
N=-174+10.*log10(B);
%the Rate/RB for each user k connected to RRH h (CKH)
for i=1:100
rmt(i,1)=B.*log2(1+10^((S(i)/N)/10));
end
format longG
UserRate= 2*10^6; %2 Mbps
resource_user=ceil(UserRate./rmt);

rrh1=find(location==1);
rrh2=find(location==2);
rrh3=find(location==3);
rrh4=find(location==4);
rrh5=find(location==5);
rrh6=find(location==6);
sum_rrh1=sum(resource_user(rrh1(:)));
sum_rrh2=sum(resource_user(rrh2(:)));
sum_rrh3=sum(resource_user(rrh3(:)));
sum_rrh4=sum(resource_user(rrh4(:)));
sum_rrh5=sum(resource_user(rrh5(:)));
sum_rrh6=sum(resource_user(rrh6(:)));
resources_rrh=[sum_rrh1,sum_rrh2,sum_rrh3,sum_rrh4,sum_rrh5,sum_rrh6];
%ASSUME Q= 25
for i=1:length(resources_rrh)
    
   if(resources_rrh(i)>25) 
    additional=resources_rrh(i)-25;
    resources_rrh(i)=25;
    resources_rrh(min_location_rrh(i))=resources_rrh(min_location_rrh(i))+additional;
   end
end
sorted_distances_rrh=sort(distances_rrh);
for i=1:length(resources_rrh)
    
   if(resources_rrh(i)>25) 
    additional=resources_rrh(i)-25;
    resources_rrh(i)=25;
    [m,ii]=min(resources_rrh);
    resources_rrh(ii)=resources_rrh(ii)+additional;
   end
end

resources_rrh_not_optimal=[sum_rrh1,sum_rrh2,sum_rrh3,sum_rrh4,sum_rrh5,sum_rrh6];
%total resources used
total_rrh=sum_rrh1+sum_rrh2+sum_rrh3+sum_rrh4+sum_rrh5+sum_rrh6;
%end
figure()
stem(resource_user)
lgd = legend({'Optimal local search'},'FontSize',10,'TextColor','blue');
   xlabel("Users");
   ylabel("RBs");