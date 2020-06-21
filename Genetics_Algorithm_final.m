%Genetics
constraintsatisfied=false;
while(constraintsatisfied==false) %Loop to satisfy constraint of max number of RBS in an RRH <= 30
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
%distance calculation for each USER an rrh:-
distances = pdist2(mt(:, 1:2), rh(:, 1:2));
% first=distances;
%GENETICS ALGORITHM
%FIRST CONSTRAINT: EACH USER CONNECTS TO ONE RRH
NumberOfUsers=10;
n = NumberOfUsers*6; %Number of users multiplied by 6 rrh's
finished=false;
while(finished~=true)
    i = 1;
    value=true;
RandomSolutions = int32(randi([0, 1], [1, n]));       
while (i < n+1) %n+1
  j = 0;
  sumOfOnes = 0;
  while (j < 6) 
    sumOfOnes = sumOfOnes +RandomSolutions(i);
    j=j+1;
    i=i+1;
  end
  if (sumOfOnes ~= 1) 
    value = false;
    break;
  end
end
finished= value;
end
%First valid solution generated
Solution1= RandomSolutions;
Solution1 = reshape(Solution1,6,NumberOfUsers)';% 6 RRHS 7 USERS
%Check 2nd Constraint: Max numbers in an RRH less than or equal Q
% for i = 1:length(location)
%        if(location(i)==1)
%            rrh1=rrh1+
%        end
% end
[row,col]=find(Solution1==1);
output1 = [row, col];
finished=false;
while(finished~=true)
    i = 1;
    value=true;
RandomSolutions = int32(randi([0, 1], [1, n]));       
while (i < n+1) %n+1
  j = 0;
  sumOfOnes = 0;
  while (j < 6) 
    sumOfOnes = sumOfOnes +RandomSolutions(i);
    j=j+1;
    i=i+1;
  end
  if (sumOfOnes ~= 1) 
    value = false;
    break;
  end
end
finished= value;
end
%2nd Valid solution generated
Solution2= RandomSolutions;
Solution2 = reshape(Solution2,6,NumberOfUsers)'; %6 RRHS 5 USERS
[row,col]=find(Solution2==1);
output2 = [row, col];
%RB CALCULATION for accepte solutions
Pt= 5 ; %dBm  Max Transmit Power
NRB= 25; % Max Number of resource blocks per BBU
%gains in db ... we change them from db to dbm
Gr=0+30;
Gt=0+30;
%frequnecy in mhz
f=2350;
pathloss_exp=3;
Rbsallusers= zeros(NumberOfUsers,6);
wall_loss=6.*((distances.*1000)./5)+30;
S=Pt-10.*log10(NRB)+Gt+Gr-20.*log10(f)-10.*pathloss_exp.*log10((distances)*1000)-(wall_loss+30)+28;
B=180000;
%background noise in dbm = N
N=-174+10.*log10(B);
%the Rate/RB for each user k connected to RRH h (CKH)
for i=1:NumberOfUsers
Rbsallusers(i,1)=B.*log2(1+10^((S(i,1)/N)/10));
end
for i=1:NumberOfUsers
Rbsallusers(i,2)=B.*log2(1+10^((S(i,2)/N)/10));
end
for i=1:NumberOfUsers
Rbsallusers(i,3)=B.*log2(1+10^((S(i,3)/N)/10));
end
for i=1:NumberOfUsers
Rbsallusers(i,4)=B.*log2(1+10^((S(i,4)/N)/10));
end
for i=1:NumberOfUsers
Rbsallusers(i,5)=B.*log2(1+10^((S(i,5)/N)/10));
end
for i=1:NumberOfUsers
Rbsallusers(i,6)=B.*log2(1+10^((S(i,6)/N)/10));
end
 UserRate2= 2*10^6; %2 Mbps
 %Rbsallusers=ceil(Rbsallusers./UserRate2);
 Rbsallusers=ceil(UserRate2./Rbsallusers);
 %%cal. rbs sol1
 %Initialize 6 RRHS
rrh1=0;
rrh2=0;
rrh3=0;
rrh4=0;
rrh5=0;
rrh6=0;
rbs_val1=zeros(length(output1),1);
%Checking which RRH each user connects to at random then incrementing then
%adding the User's RBS in the RRH
for i=1:length(output1)
rbs_val1(i)=Rbsallusers(output1(i,1),output1(i,2));
if(output1(i,2)==1)
    rrh1=rrh1+Rbsallusers(output1(i,1),output1(i,2));
end
if(output1(i,2)==2)
    rrh2=rrh2+Rbsallusers(output1(i,2),output1(i,2));
end
if(output1(i,2)==3)
    rrh3=rrh3+Rbsallusers(output1(i,1),output1(i,2));
end
if(output1(i,2)==4)
    rrh4=rrh4+Rbsallusers(output1(i,1),output1(i,2));
end
if(output1(i,2)==5)
    rrh5=rrh5+Rbsallusers(output1(i,1),output1(i,2));
end
if(output1(i,2)==6)
    rrh6=rrh6+Rbsallusers(output1(i,1),output1(i,2));
end
end
%CHECKING 2ND CONSTRAINT EACH RRH have maxium RBS Q
 if(rrh1<=30&&rrh2<=30&&rrh3<=30&&rrh4<=30&&rrh5<=30&&rrh6<=30)
     temp1= 1;
 end
sum(rbs_val1);
%Cal.Rbs sol2
rrh1=0;
rrh2=0;
rrh3=0;
rrh4=0;
rrh5=0;
rrh6=0;
 rbs_val2=zeros(length(output2),1);
 %Checking which RRH each user connects to at random then incrementing then
%adding the User's RBS in the RRH
 for i=1:length(output2)
 rbs_val2(i)=Rbsallusers(output2(i,1),output2(i,2));
 if(output1(i,2)==1)
    rrh1=rrh1+Rbsallusers(output1(i,1),output1(i,2));
end
if(output1(i,2)==2)
    rrh2=rrh2+Rbsallusers(output1(i,2),output1(i,2));
end
if(output1(i,2)==3)
    rrh3=rrh3+Rbsallusers(output1(i,1),output1(i,2));
end
if(output1(i,2)==4)
    rrh4=rrh4+Rbsallusers(output1(i,1),output1(i,2));
end
if(output1(i,2)==5)
    rrh5=rrh5+Rbsallusers(output1(i,1),output1(i,2));
end
if(output1(i,2)==6)
    rrh6=rrh6+Rbsallusers(output1(i,1),output1(i,2));
end
 end
 %CHECKING IF 2ND CONSTRAINT IS SATISFIED
  if(rrh1<=30&&rrh2<=30&&rrh3<=30&&rrh4<=30&&rrh5<=30&&rrh6<=30)
      temp2= 1;
  end
 sum(rbs_val2);
%CROSSOVER
A1 = Solution1(1:round(NumberOfUsers/2), :);
A2 = Solution1(round(NumberOfUsers/2)+1:NumberOfUsers, :);
B1 = Solution2(1:round(NumberOfUsers/2), :);
B2 = Solution2(round(NumberOfUsers/2)+1:NumberOfUsers, :);
%First Cross
Cross1=cat(1,A1,B2);
[row,col]=find(Cross1==1);
output3 = [row, col];
%Calculate RB's for First Cross
rrh1=0;
rrh2=0;
rrh3=0;
rrh4=0;
rrh5=0;
rrh6=0;
rbs_val3=zeros(length(output3),1);
%Checking which RRH each user connects to at random then incrementing then
%adding the User's RBS in the RRH
for i=1:length(output3)
rbs_val3(i)=Rbsallusers(output3(i,1),output3(i,2));
if(output1(i,2)==1)
    rrh1=rrh1+Rbsallusers(output1(i,1),output1(i,2));
end
if(output1(i,2)==2)
    rrh2=rrh2+Rbsallusers(output1(i,2),output1(i,2));
end
if(output1(i,2)==3)
    rrh3=rrh3+Rbsallusers(output1(i,1),output1(i,2));
end
if(output1(i,2)==4)
    rrh4=rrh4+Rbsallusers(output1(i,1),output1(i,2));
end
if(output1(i,2)==5)
    rrh5=rrh5+Rbsallusers(output1(i,1),output1(i,2));
end
if(output1(i,2)==6)
    rrh6=rrh6+Rbsallusers(output1(i,1),output1(i,2));
end
end
%CHECKING IF 2ND CONSTRAINT IS SATISFIED
 if(rrh1<=30&&rrh2<=30&&rrh3<=30&&rrh4<=30&&rrh5<=30&&rrh6<=30)
     temp3=1;
 end
sum(rbs_val3);
% Second Cross
Cross2=cat(1,B1,A2);
[row,col]=find(Cross2==1);
output4 = [row, col];
%Calculate RB'S for Second Cross
rrh1=0;
rrh2=0;
rrh3=0;
rrh4=0;
rrh5=0;
rrh6=0;
rbs_val4=zeros(length(output4),1);
%Checking which RRH each user connects to at random then incrementing then
%adding the User's RBS in the RRH
for i=1:length(output4)
rbs_val4(i)=Rbsallusers(output4(i,1),output4(i,2));
if(output1(i,2)==1)
    rrh1=rrh1+Rbsallusers(output1(i,1),output1(i,2));
end
if(output1(i,2)==2)
    rrh2=rrh2+Rbsallusers(output1(i,2),output1(i,2));
end
if(output1(i,2)==3)
    rrh3=rrh3+Rbsallusers(output1(i,1),output1(i,2));
end
if(output1(i,2)==4)
    rrh4=rrh4+Rbsallusers(output1(i,1),output1(i,2));
end
if(output1(i,2)==5)
    rrh5=rrh5+Rbsallusers(output1(i,1),output1(i,2));
end
if(output1(i,2)==6)
    rrh6=rrh6+Rbsallusers(output1(i,1),output1(i,2));
end
end
%CHECKING IF 2ND CONSTRAINT IS SATISIFIED
 if(rrh1<=30&&rrh2<=30&&rrh3<=30&&rrh4<=30&&rrh5<=30&&rrh6<=30)
     temp4=1;
 end
sol1=sum(rbs_val1);
sol2=sum(rbs_val2);
sol3=sum(rbs_val3);
sol4=sum(rbs_val4);
n=[sol1,sol2,sol3,sol4];
best_sol_GA=min(n);
best_sol_GA100=best_sol_GA*(100/NumberOfUsers);
if(temp1==1&&temp2==1&&temp3==1&&temp4==1)
    constraintsatisfied=true;
end
end