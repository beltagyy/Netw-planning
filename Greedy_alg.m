first=distances;
wall_loss=6.*((first.*1000)./5)+30;
S=Pt-10.*log10(NRB)+Gt+Gr-20.*log10(f)-10.*pathloss_exp.*log10((first)*1000)-(wall_loss+30)+28;
B=180000;
%background noise in dbm = N
N=-174+10.*log10(B);
%the Rate/RB for each user k connected to RRH h (CKH)
for i=1:100
rmt(i,1)=B.*log2(1+10^((S(i,1)/N)/10));
end
for i=1:100
rmt(i,2)=B.*log2(1+10^((S(i,2)/N)/10));
end
for i=1:100
rmt(i,3)=B.*log2(1+10^((S(i,3)/N)/10));
end
for i=1:100
rmt(i,4)=B.*log2(1+10^((S(i,4)/N)/10));
end
for i=1:100
rmt(i,5)=B.*log2(1+10^((S(i,5)/N)/10));
end
for i=1:100
rmt(i,6)=B.*log2(1+10^((S(i,6)/N)/10));
end
format longG
UserRate= 2*10^6; %2 Mbps
resource_user=ceil(UserRate./rmt);
%ending calc.
mean(resource_user);
ss=sum(resource_user);
cost=round(10*rem(ss/10,1));
%All combinations of rbsgenerated up there%
[RBSused,RRHnum] = min(ss);
find(resource_user(1,:)>1);
find(resource_user(2,:)>1);
find(resource_user(3,:)>1);
find(resource_user(4,:)>1);
find(resource_user(5,:)>1);
find(resource_user(6,:)>1);
find(resource_user(7,:)>1);
find(resource_user(8,:)>1);
find(resource_user(9,:)>1);
find(resource_user(10,:)>1);
%getting logical places of values less than 2 rbs
b=resource_user<2;

bb=0;
for j=1:1:100

for i=1:6

valll=min(resource_user(j,i));
end
bb=bb+valll;

end
aa=zeros(1,6); %optimal sol.
ee=zeros(1,6); % add heuristic
  if( bb>35) 
      addi=bb-35;
          ee(:,1)=35;
          ee(:,2)=ee(:,2)+addi;
  end   
   if( ee(:,2)>35) 
      addi=ee(:,2)-35;
          ee(:,2)=35;
          ee(:,3)=ee(:,3)+addi;
   end   

  if( ee(:,3)>35) 
      addi=ee(:,3)-35;
          ee(:,3)=35;
          ee(:,4)=ee(:,4)+addi;
  end
  if( ee(:,4)>35) 
      addi=ee(:,4)-35;
          ee(:,4)=35;
          ee(:,5)=ee(:,5)+addi;
  end
  
  if( ee(:,5)>35) 
      addi=ee(:,5)-35;
          ee(:,5)=35;
          ee(:,6)=ee(:,6)+addi;
  end
  
  
  cost_assumed=[1,1,1,2,2,3];
  ee_cost=zeros(1,6);
   for i=1:6
   if(ee(1,i)>0)
    ee_cost(1,i)=ee(1,i)+cost_assumed(1,i);
   end
   end
  sum(ee_cost)
  
  
  
  

  

  
  % fitting each rrh by the maximum Q=35 as in constraints using local search
% with neighbours 
  if( sum(resource_user(:,1))>35) 
    additional=sum(resource_user(:,1))-35;
    aa(:,1)=35;
    aa(:,2)=aa(:,2)+additional;
   end
    if( sum(aa(:,2))>35) 
    additional=sum(aa(:,2))-35;
    aa(:,2)=35;
    aa(:,3)=aa(:,3)+additional;
    end
    locc=zeros(100,6);
    vall=zeros(100,6);
   for i=1:35
   [val,loc] = min(resource_user(i,:));
   locc(i)=locc(i)+loc;
    vall(i)=vall(i)+val;
   end
   for i=36:70
     [val,loc] = min(resource_user(i,:));
     locc(i,2)=locc(i,2)+loc  ;
     vall(i,2)=vall(i,2)+val;
   end
    for i=70:100
     [val,loc] = min(resource_user(i,:));
     locc(i,3)=locc(i,3)+loc  ;
     vall(i,3)=vall(i,3)+val;
   end
   ww=sum(vall);
   cost_tot=zeros(1,6);
   cost_tot=cost_tot+cost;
   for i=1:6
   if(ww(1,i)>0)
    ww(1,i)=ww(1,i)+cost_tot(1,i);
   end
   end
   totalcost=sum(ww); %%optimal value%%%
   stem(resource_user)
   lgd = legend({'RRH 1','RRH 2','RRH 3','RRH 4','RRH 5','RRH 6'},'FontSize',12,'TextColor','blue');
   xlabel("Users");
   ylabel("RBs");