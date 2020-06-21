clc
clear vars
clear global
close all
format longG

avg_bbus=zeros(1,1000);
for p=1:1:1000
%ploting the area and mts and rrh
rec_area= rectangle('Position',[1 1 40 40]);
axis([0 50 0 50])

rec_area.FaceColor = [0 0.9 0.999];
rec_area.EdgeColor = 'b';
rec_area.LineWidth = 1.5;
hold on 
grid on
a = 1;
b = 40;

xrrh = (b-a).*rand(14,1) + a;
yrrh= (b-a).*rand(14,1) + a;


plot(xrrh,yrrh,'bd','MarkerSize',10)
hold on
xmt = (b-a).*rand(50,1) + a;
ymt= (b-a).*rand(50,1) + a;
plot(xmt,ymt,'r.','MarkerSize',10)
hold off
rh=[xrrh,yrrh];
mt=[xmt,ymt];
%distance calculation for each mt an rrh:- 
distances = pdist2(mt(:, 1:2), rh(:, 1:2));
minDistance = min(distances(:));
[rowOfA, rowOfB] = find(distances == minDistance);
[value , location]= min (distances');
%%%distance between rrhs :-
%rh(1,2)
distances_rrh =[];
for i=1:14

for y=1:14
distances_rrh(i,y)=sqrt(((rh(i)-rh(y))^2)+((rh(i,2)-rh(y,2))^2)) ;  
if distances_rrh(i,y)==0
    distances_rrh(i,y)=inf;
end

end
end
[min_distance_rrh , min_location_rrh]=min(distances_rrh);
%__________________________________________________________________________________%
%another way to calculate min distance :
%distances_rrh=((repmat(xrrh,1,length(xrrh))-repmat(xrrh',length(xrrh),1)).^2 +......
 %   (repmat(yrrh,1,length(xrrh))-repmat(yrrh',length(xrrh),1)).^2).^0.5;
%distances_rrh(distances_rrh==0)=inf;
%Xrrh=repmat(xrrh',length(xrrh),1)
%distances_rrh=((repmat(xrrh,1,length(xrrh))-repmat(xrrh',length(xrrh),1)).^2 +......
 %   (repmat(yrrh,1,length(xrrh))-repmat(yrrh',length(xrrh),1)).^2).^0.5;
%distances_rrh(distances_rrh==0)=inf;
%Xrrh=repmat(xrrh',length(xrrh),1)
%___________________________________________________________________________________%
%calculating the rate for each mt
%bandwidth=B (khz)

B=180000;
%background noise in dbm = N
N=-174+10.*log10(B);
%Service power in dbm =S
Pt=5; % max transmit power
Nrb=25; %total number of resourse block
%gains in db ... we change them from db to dbm
Gr=0+30;
Gt=0+30;
%frequnecy in mhz
f=2350;
pathloss_exp=3;
%we multiply distance by 1000 to change it from m to km
wall_loss=6.*((value(:).*1000)./5);
%recieved signal power that is computed in dbm (S)
S=Pt-10.*log10(Nrb)+Gt+Gr-20.*log10(f)-10.*pathloss_exp.*log10((value(:)).*1000)-wall_loss+28;
%Rate the could be provide to each terminal
format longG
for i=1:50
rmt(i,1)=B.*log2(1+10^((S(i)/N)/10));
end
format longG
%disp(rmt);
Default_rate=2.*10^6;
%rmtt=rmt.'; this line changes from row to column.
%clalculating the required blocks for each mt
resource_user=rmt./Default_rate;
%figure()
%stem(resource_user,'R');
%getting mt coneccted to each rrh from 1 to 10

rrh1=find(location==1);
rrh2=find(location==2);
rrh3=find(location==3);
rrh4=find(location==4);
rrh5=find(location==5);
rrh6=find(location==6);
rrh7=find(location==7);
rrh8=find(location==8);
rrh9=find(location==9);
rrh10=find(location==10);
rrh11=find(location==11);
rrh12=find(location==12);
rrh13=find(location==13);
rrh14=find(location==14);
%sum of resources for rrh
sum_rrh1=sum(resource_user(rrh1(:)));
sum_rrh2=sum(resource_user(rrh2(:)));
sum_rrh3=sum(resource_user(rrh3(:)));
sum_rrh4=sum(resource_user(rrh4(:)));
sum_rrh5=sum(resource_user(rrh5(:)));
sum_rrh6=sum(resource_user(rrh6(:)));
sum_rrh7=sum(resource_user(rrh7(:)));
sum_rrh8=sum(resource_user(rrh8(:)));
sum_rrh9=sum(resource_user(rrh9(:)));
sum_rrh10=sum(resource_user(rrh10(:)));
sum_rrh11=sum(resource_user(rrh11(:)));
sum_rrh12=sum(resource_user(rrh12(:)));
sum_rrh13=sum(resource_user(rrh13(:)));
sum_rrh14=sum(resource_user(rrh14(:)));
resources_rrh=[sum_rrh1,sum_rrh2,sum_rrh3,sum_rrh4,sum_rrh5,sum_rrh6,sum_rrh7,sum_rrh8,sum_rrh9,sum_rrh10,sum_rrh11,sum_rrh12,sum_rrh13,sum_rrh14];
%realocation in the second closest rrh:
for i=1:length(resources_rrh)
    
   if(resources_rrh(i)>25) 
    additional=resources_rrh(i)-25;
    resources_rrh(i)=25;
    resources_rrh(min_location_rrh(i))=resources_rrh(min_location_rrh(i))+additional;
   end
end
resources_rrh_not_optimal=[sum_rrh1,sum_rrh2,sum_rrh3,sum_rrh4,sum_rrh5,sum_rrh6,sum_rrh7,sum_rrh8,sum_rrh9,sum_rrh10,sum_rrh11,sum_rrh12,sum_rrh13,sum_rrh14];
%total resources used
total_rrh=sum_rrh1+sum_rrh2+sum_rrh3+sum_rrh4+sum_rrh5+sum_rrh6+sum_rrh7+sum_rrh8+sum_rrh9+sum_rrh10+sum_rrh11+sum_rrh12+sum_rrh13+sum_rrh14;
%each bbu contains 25 rsource block
bbu_ff_online=0; %%bbu first fit number!
%%%%First Fit Approach (Online)%%%
resources_rrh=ceil(resources_rrh);
bbu_recent_ff_online=zeros(1,1);
for i=1:1:length(resources_rrh)
   flag=false;
   for j=1:1:length(bbu_recent_ff_online)
       if bbu_recent_ff_online(j)+resources_rrh(i)<=25
           bbu_recent_ff_online(j)=bbu_recent_ff_online(j)+resources_rrh(i);
           flag=true;
           break;
       end
    end
       if flag==false
           bbu_recent_ff_online(j+1)=resources_rrh(i);
       end
       bbu_recent_ff_online;
 end
 bbu_ff_online=length(bbu_recent_ff_online);
%%%First Fit approach ((OFF-line))
  %_____________________________%
sorted_resources_rrh=sort(resources_rrh);
bbu_ff_offline=0;
bbu_recent_ff_offline=zeros(1,1);
for i=1:1:length(sorted_resources_rrh)
   flag=false;
   for j=1:1:length(bbu_recent_ff_offline)
       if bbu_recent_ff_offline(j)+sorted_resources_rrh(i)<=25
           bbu_recent_ff_offline(j)=bbu_recent_ff_offline(j)+sorted_resources_rrh(i);
           flag=true;
           break;
       end
    end
       if flag==false
           bbu_recent_ff_offline(j+1)=sorted_resources_rrh(i);
       end
       bbu_recent_ff_offline;
end
bbu_ff_offline=length(bbu_recent_ff_offline);
%%%Best Fit approach (Online)%%%
%_._._._._._._._._._._.%\
bbu_bf_online=0;
bbu_recent_bf_online=zeros(1,10);
for i=1:1:10
    dif=0;
    mindif=0;
    index=1;
    for j=10:-1:1
        mindif=25;
        dif=25-bbu_recent_bf_online(j);
        if(dif<=mindif&&dif>=resources_rrh(i))
            
            mindif=dif;
            index=j;
        end
    end
    bbu_recent_bf_online(index)=bbu_recent_bf_online(index)+resources_rrh(i);
end
bbu_bf_online=nnz(bbu_recent_bf_online);

%%Best Fit approach (offline)%%
%here we use the sorted resources as we used in ff offline%
bbu_bf_offline=0;
bbu_recent_bf_offline=zeros(1,10);
diff=zeros(1,1);
resourcess=sort(resources_rrh);
for i=1:1:10
    dif=0;
    mindif=0;
    index=1;
    for j=10:-1:1
        mindif=25;
        dif=25-bbu_recent_bf_offline(j);
        if(dif<=mindif&&dif>=resourcess(i))
            
            mindif=dif;
            index=j;
        end
    end
    bbu_recent_bf_offline(index)=bbu_recent_bf_offline(index)+resourcess(i);
end
bbu_bf_offline=nnz(bbu_recent_bf_offline);
%---------------------------------%
% avg_bbu= bbu_bf_online+bbu_ff_online;
% avg_bbu=avg_bbu/2;
avg_bbus(p)=ceil( (bbu_bf_online+bbu_ff_online)./2);
end
global Final14;
Final14=ceil(sum(avg_bbus)./1000)
