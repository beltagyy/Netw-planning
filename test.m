
x=resource_user; %5x2 metrix
n=length(x);
%iteration 1
mon0=x(:,1);
%%%%%%%%%%%%%%%%%
mon1=zeros(100,1);
mon2=zeros(100,1);
mon3=zeros(100,1);
mon4=zeros(100,1);
mon5=zeros(100,1);

%compare rrh1 & rrh2 iteration 2 1
for i=1:100
  j=2;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon1(i,1)=mini;
end
%compare rrh1 & rrh3 iteration 2 2

for i=1:100
  j=3;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon2(i,1)=mini;
end
%compare rrh1 & rrh4 iteration 2 3

for i=1:100
  j=4;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon3(i,1)=mini;
end
%compare rrh1 & rrh5 iteration 2 4

for i=1:100
  j=5;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon4(i,1)=mini;
end
%compare rrh1 & rrh6 iteration 2 5

for i=1:100
  j=6;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon5(i,1)=mini;
end

sum_iter1=sum(mon0);
sum_iter21=sum(mon1);
sum_iter22=sum(mon2);
sum_iter23=sum(mon3);
sum_iter24=sum(mon4);
sum_iter25=sum(mon5);
iter2=[sum_iter21; sum_iter22; sum_iter23;  sum_iter24; sum_iter25 ];
iterr2(1,1:5)={'mon1', 'mon2','mon3',  'mon4', 'mon5'};

[va,lo]=min(iter2);
iter2_reduced=iterr2(lo);
iteration2_reduced=eval(cell2mat(iter2_reduced));
mon21=zeros(100,1);
mon22=zeros(100,1);
mon23=zeros(100,1);
mon24=zeros(100,1);
mon25=zeros(100,1);

%replacing with the reduced value
x(:,1)=iteration2_reduced;
%3rd iteration
for i=1:100
  j=2;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon21(i,1)=mini;
end
for i=1:100
  j=3;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon22(i,1)=mini;
end
for i=1:100
  j=4;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon23(i,1)=mini;
end
for i=1:100
  j=5;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon24(i,1)=mini;
end

for i=1:100
  j=6;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon25(i,1)=mini;
end

sum_iter31=sum(mon21);
sum_iter32=sum(mon22);
sum_iter33=sum(mon23);
sum_iter34=sum(mon24);
sum_iter35=sum(mon25);
iter3=[sum_iter31; sum_iter32; sum_iter33;  sum_iter34; sum_iter35 ];
iterr3(1,1:5)={'mon21', 'mon22','mon23',  'mon24', 'mon25'};

[va,lo]=min(iter3);
iter3_reduced=iterr3(lo);
iteration3_reduced=eval(cell2mat(iter3_reduced));
%replacing with reduced values
x(:,1)=iteration3_reduced;
%4th iteration
mon31=zeros(100,1);
mon32=zeros(100,1);
mon33=zeros(100,1);
mon34=zeros(100,1);
mon35=zeros(100,1);

for i=1:100
  j=2;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon31(i,1)=mini;
end
for i=1:100
  j=3;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon32(i,1)=mini;
end
for i=1:100
  j=4;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon33(i,1)=mini;
end
for i=1:100
  j=5;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon34(i,1)=mini;
end
for i=1:100
  j=6;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon35(i,1)=mini;
end
sum_iter41=sum(mon31);
sum_iter42=sum(mon32);
sum_iter43=sum(mon33);
sum_iter44=sum(mon34);
sum_iter45=sum(mon35);
iter4=[sum_iter41; sum_iter42; sum_iter43;  sum_iter44; sum_iter45 ];
iterr4(1,1:5)={'mon31', 'mon32','mon33',  'mon34', 'mon35'};

[va,lo]=min(iter4);
iter4_reduced=iterr4(lo);
iteration4_reduced=eval(cell2mat(iter4_reduced));
%replacing with reduced values
x(:,1)=iteration4_reduced;
%5th iteration
mon41=zeros(100,1);
mon42=zeros(100,1);
mon43=zeros(100,1);
mon44=zeros(100,1);
mon45=zeros(100,1);
for i=1:100
  j=2;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon41(i,1)=mini;
end
for i=1:100
  j=3;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon42(i,1)=mini;
end
for i=1:100
  j=4;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon43(i,1)=mini;
end
for i=1:100
  j=5;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon44(i,1)=mini;
end
for i=1:100
  j=6;
  mini=x(i,1) ; 

if(mini>x(i,j) ) 
  mini=x(i,j);
end
  mon45(i,1)=mini;
end
sum_iter51=sum(mon41);
sum_iter52=sum(mon42);
sum_iter53=sum(mon43);
sum_iter54=sum(mon44);
sum_iter55=sum(mon45);
iter5=[sum_iter51; sum_iter52; sum_iter53;  sum_iter54; sum_iter55 ];
iterr5(1,1:5)={'mon41', 'mon42','mon43',  'mon44', 'mon45'};

[va,lo]=min(iter5);
iter5_reduced=iterr4(lo);
iteration5_reduced=eval(cell2mat(iter5_reduced));

total_rbs_add=sum(iteration5_reduced)
aa=zeros(1,6); %optimal sol.
ee=zeros(1,6); % add heuristic
  if( total_rbs_add>35) 
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
  