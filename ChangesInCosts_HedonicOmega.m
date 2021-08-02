%%Full Script for NPV with changing time intervals for discount rate%%
%%----------------Costs and Volume are changing-------------------%%
%--------------------------------------------------------------------%
%% Input Parameters%%
%%---Benefit Distribution (BD) Input Parameters---%%
%---Community Alongshore distances
D=25670;                %total distance of LBI, NJ
DtotalPER=0.715;        %total alongshore distance percentage of SB+LBT+BH project
Dtotal=D*DtotalPER;     %total alongshore distance of SB+LBT+BH project
DsbPER=0.0845;          %total alongshore distance perecentage of Ship Bottom
Dsb=D*DsbPER;           %total alongshore distance of Ship Bottom   
DlbtPER=0.5117;         %total alongshore distance percentage of Long Beach Township (excluding Brant Beach & North region of Division D)
Dlbt=D*DlbtPER;         %total alongshore distance of Long Beach Township
DbhPER=0.1188;          %total alongshore distance percentage of Beach Haven
Dbh=D*DbhPER;           %total alongshore distance of Beach Haven
Davg=(Dsb+Dbh)/2;
DavgPER=DtotalPER/3;
% Dsb=2175;
Dlava=4700;
Dbb=1475;
Dwild=2400;
Dcape=1425;
%-----Total Sum of PVs 2017-----%
PVsb=879512000;         %total $sum of Ship Bottom properties
PVlbt=5164216465;       %total $sum of Long Beach Township properties
PVbh=1219111700;        %total $sum of Beach Haven properties
PV=PVsb+PVlbt+PVbh;     %total $sum of properties for entire dataset SB+LBT+BH
PVavg=(PVbh+PVsb)/2;
PVlow=158000000;
PVsb20=1000628600;      %total $sum of Ship Bottom properties in 2020
PVlava=1915425384;    %total $sum of Lavallette properties in 2020
PVwild=906877000;     %total $sum of Wildwood properties in 2020
PVcape=442939200; 
PVbb=133693900;

%-----omega or MIP coefficients-----%
omegaPW=0.0636698;        %total Marginal Implicit Price (MIP) value for all properties in dataset SB+LBT+BH
omegasb=0.1572;         %MIP of Ship Bottom
omegalbt=0.0134;        %MIP of Long Beach Township
omegabh=0.2071;         %MIP of Beach Haven
%%---Benefit (BD) totals for communities-----%
BD=PV*omegaPW;            %total BD for all communities
BDsb=PVsb*omegasb;      %total BD for SB
BDlbt=PVlbt*omegalbt;   %total BD for LBT
BDbh=PVbh*omegabh;      %total BD for BH
%%---Populations per community---%
Popsb=1325;             %SB population
Poplbt=5312;            %LBT population
Popbh=1241;             %BH population
Pop=Popsb+Poplbt+Popbh; %ALL COMMUNITIES population
%%---Benefits per household---%%%
BDpop=BD/Pop;           %ALL COMMUNITIES
BDpopsb=BDsb/Popsb;     %Ship Bottom
BDpoplbt=BDlbt/Poplbt;  %Long Beach Township
BDpopbh=BDbh/Popbh;     %Beach Haven
%%---Benefits per meter alongshore---%%%
BDD=BD/Dtotal;           %ALL COMMUNITIES
BDDsb=BDsb/Dsb;         %Ship Bottom
BDDlbt=BDlbt/Dlbt;      %Long Beach Township
BDDbh=BDbh/Dbh;         %Beach Haven
%%---------------------------------------------%%
%%---Cost Distribution (CD) Input Parameters---%%
%%---------------------------------------------%%
%%---Nourishment Volume for entire LBI project, per episode
VolLOW=60;     %total estimation of volume per episode LOWER LIMIT (USACE2014) - 2mcy - roughly 60m^2 for each meter alongshore
VolHIGH=300;    %total estimation of volume per episode UPPER LIMIT - roughly 300m^2 (278.25m^2 when we consider top portion of dune added) for each meter alongshore
VolDOUBLE=120;
Volavg=100*D;     %total estimation for EXAMPLE assuming 100m^2 per meter of alongshore beach nourished per episode
VolEX=1000*D;     %1st Extreme Example
VolEXT=2000*D;    %2nd Extreme Example
%%---Intial estimation of events (USACE - 113th Congress)
Events=7; %7 events throughout the 50yr time horizon
%%---VOLUMETOTALS
totalLOWvol=VolLOW*Events;
totalHIGHvol=VolHIGH*Events;
totalDOUBLEvol=VolDOUBLE*Events;
totalAVGvol=Volavg*Events;
totalEXTvol=VolEXT*Events;
%%-------------------------------%%
%%-------------------------------%%
%%---Nourishment Volume for each community TOTAL over 50years
TOTVOLprojectLOW=(VolLOW*DtotalPER*Events);
TOTVOLsbLOW=(VolLOW*DsbPER*Events);
TOTVOLlbtLOW=(VolLOW*DlbtPER*Events);
TOTVOLbhLOW=(VolLOW*DbhPER*Events);
%%---Nourishment Volume for each community TOTAL over 50years
TOTVOLprojectHIGH=(VolHIGH*DtotalPER*Events);
TOTVOLsbHIGH=(VolHIGH*DsbPER*Events);
TOTVOLlbtHIGH=(VolHIGH*DlbtPER*Events);
TOTVOLbhHIGH=(VolHIGH*DbhPER*Events);
%%---LOWER Nourishment Volume for each community TOTAL per meter over 50years
VolNmLOW=(TOTVOLprojectLOW/Dtotal);
VolNsbmLOW=(TOTVOLsbLOW/Dsb);
VolNlbtmLOW=(TOTVOLlbtLOW/Dlbt);
VolNbhmLOW=(TOTVOLbhLOW/Dbh);
%%---HIGHER Nourishment Volume for each community TOTAL per meter over 50years
VolNmHIGH=(TOTVOLprojectHIGH/Dtotal);
VolNsbmHIGH=(TOTVOLsbHIGH/Dsb);
VolNlbtmHIGH=(TOTVOLlbtHIGH/Dlbt);
VolNbhmHIGH=(TOTVOLbhHIGH/Dbh);
%%---Cost-Share percentage of contributions from local communities
LocalContributionFed=0.125;  %represents Fed gov't contributing 50%
%%---Discount rate------%
% discount=0.06875; fig=8;
discount=0.03;  fig=9;
% discount=0.01;  fig=10;
% discount=0.001; fig=11;
% discount=0; fig=12;
%%--Munciple Tax Rate per Community 2017--%%
TAXsb=0.0034;
TAXlbt=0.00236;
TAXbh=0.00406;
TAXlava=0.00311;
TAXbb=0.00481;
%%---Total Time interval of Project---%%
T=50;
%%-------------------------------------------%%
%%-------Initial parameters for check--------%%
%%-------------------------------------------%%
%%---Starting Nourishment Cost (2016 value)
Cost=22.06; %starting cost 2016 (weeksmarine)
% Cost=41.13; %min cost for lbt to reach Net Loss, beyond continues neg.
% Cost=47.98; %test runs
%% External Loop Vectors for Storage
run=100;
% time=linspace(1,50,run);
% it=length(time);
time=1:1:50;
it=length(time);
cost=linspace(22.06,100,run);
ic=length(cost);
omega=linspace(0,0.05,run);
io=length(omega);
%% Building Result Matrix for regime plot
result_matrix_CDsum=zeros(ic,io);         %by doing it,1 this turns it into a column
result_vector_CD=zeros(ic,1);  
result_matrix_BD=zeros(ic,io);
DIS=zeros(1,it);
TOTVOL=zeros(1,it);
CD=zeros(1,it);
Benefit=zeros(1,it);

result_matrix_CDsumsb=zeros(ic,io);         %by doing it,1 this turns it into a column
result_vector_CDsb=zeros(ic,1);   
result_matrix_BDsb=zeros(ic,io);
DIS=zeros(1,it);
TOTVOL=zeros(1,it);
CD=zeros(1,it);
Benefit=zeros(1,it);

result_matrix_CDsumlbt=zeros(ic,io);         %by doing it,1 this turns it into a column
result_vector_CDlbt=zeros(ic,1);  
result_matrix_BDlbt=zeros(ic,io);
DIS=zeros(1,it);
TOTVOL=zeros(1,it);
CD=zeros(1,it);
Benefit=zeros(1,it);

result_matrix_CDsumbh=zeros(ic,io);         %by doing it,1 this turns it into a column
result_vector_CDbh=zeros(ic,1);  
result_matrix_BDbh=zeros(ic,io);
DIS=zeros(1,it);
TOTVOL=zeros(1,it);
CD=zeros(1,it);
Benefit=zeros(1,it);
%% Plots
% figure(1)
% for o=1:io
%     for c=1:ic
%         for t=1:it
%             %Discount Rate over time: generating an array of values for the discount rate from year 1 to year 50
%             DIS(t)=((1+discount)^time(t));
% %             CD(t)=(((cost(c)*(totalAVGvol/T)*LocalContributionFed))/DIS(t));  
%             CD(t)=(((cost(c)*((totalLOWvol*Dlava)/T)*LocalContributionFed))/DIS(t));  
%             %Cost Function: inputing the discount rate into the cost function for changing costs (c) and events (e)
%             CDsum=sum(CD);          %storing the values for the cost function CD over time, into a matrix
%         end
%         result_vector_CD(c)=CDsum;
%         Benefit(t)=PVlava*omega(o);   %storing the values for the benefit function BD over time, into a matrix
%     end
%     result_matrix_CDsum(:,o)=result_vector_CD;   %(e,:) take this whole matrix and store it
%     result_matrix_BD(:,o)=Benefit(t);
% end
% result_matrix_NB=((result_matrix_BD-result_matrix_CDsum)/T)/Dlava;
% %plot information
% pcolor(omega,cost,result_matrix_NB)
% hold on
% shading flat
% % colormap(flipud(bluewhitered))
% colormap(flipud(redblue))
% Z=result_matrix_NB;
% [X,Y]=meshgrid(omega,cost);
% set(gca,'PlotBoxAspectRatio',[1,1,1])
% set(gcf,'rend','painters')
% xlabel('Omega Values','fontsize',12)
% ylabel('Sed. Costs($/m^3)','fontsize',12)
% title('LAVA 60m^3 NB $/yr/m','fontsize',15)
% 
% figure(2)
% for o=1:io
%     for c=1:ic
%         for t=1:it
%             %Discount Rate over time: generating an array of values for the discount rate from year 1 to year 50
%             DIS(t)=((1+discount)^time(t));
% %             CD(t)=(((cost(c)*(totalAVGvol/T)*LocalContributionFed))/DIS(t));  
%             CD(t)=(((cost(c)*((totalDOUBLEvol*Dlava)/T)*LocalContributionFed))/DIS(t));  
%             %Cost Function: inputing the discount rate into the cost function for changing costs (c) and events (e)
%             CDsum=sum(CD);          %storing the values for the cost function CD over time, into a matrix
%         end
%         result_vector_CD(c)=CDsum;
%         Benefit(t)=PVlava*omega(o);   %storing the values for the benefit function BD over time, into a matrix
%     end
%     result_matrix_CDsum(:,o)=result_vector_CD;   %(e,:) take this whole matrix and store it
%     result_matrix_BD(:,o)=Benefit(t);
% end
% result_matrix_NB=((result_matrix_BD-result_matrix_CDsum)/T)/Dlava;
% %plot information
% pcolor(omega,cost,result_matrix_NB)
% hold on
% shading flat
% % colormap(flipud(bluewhitered))
% colormap(flipud(redblue))
% Z=result_matrix_NB;
% [X,Y]=meshgrid(omega,cost);
% set(gca,'PlotBoxAspectRatio',[1,1,1])
% set(gcf,'rend','painters')
% xlabel('Omega Values','fontsize',12)
% ylabel('Sed. Costs($/m^3)','fontsize',12)
% title('LAVA 120m^3 NB $/yr/m','fontsize',15)

% figure(3)
% subplot(2,2,1)
% for o=1:io
%     for c=1:ic
%         for t=1:it
%             Discount Rate over time: generating an array of values for the discount rate from year 1 to year 50
%             DIS(t)=((1+discount)^time(t));
%             CD(t)=(((cost(c)*(totalAVGvol/T)*LocalContributionFed))/DIS(t));  
%             CD(t)=(((cost(c)*((totalHIGHvol*Dlbt)/T)*LocalContributionFed))/DIS(t));  
%             Cost Function: inputing the discount rate into the cost function for changing costs (c) and events (e)
%             CDsum=sum(CD);          %storing the values for the cost function CD over time, into a matrix
%         end
%         result_vector_CD(c)=CDsum;
%         Benefit(t)=PVlbt*omega(o);   %storing the values for the benefit function BD over time, into a matrix
%     end
%     result_matrix_CDsum(:,o)=result_vector_CD;   %(e,:) take this whole matrix and store it
%     result_matrix_BD(:,o)=Benefit(t);
% end
% result_matrix_NB=((result_matrix_BD-result_matrix_CDsum)/T)/Dlbt;
% plot information
% pcolor(omega,cost,result_matrix_NB)
% hold on
% shading flat
% colormap(flipud(bluewhitered))
% colormap(flipud(redblue))
% Z=result_matrix_NB;
% [X,Y]=meshgrid(omega,cost);
% set(gca,'PlotBoxAspectRatio',[1,1,1])
% set(gcf,'rend','painters')
% xlabel('Omega Values','fontsize',12)
% ylabel('Sed. Costs($/m^3)','fontsize',12)
% title('LBT 300m^3 NB $/yr/m','fontsize',15)
% 
% figure(4)
% subplot(2,2,2)
% for o=1:io
%     for c=1:ic
%         for t=1:it
%             Discount Rate over time: generating an array of values for the discount rate from year 1 to year 50
%             DIS(t)=((1+discount)^time(t));
%             CD(t)=(((cost(c)*(totalAVGvol/T)*LocalContributionFed))/DIS(t));  
%             CD(t)=(((cost(c)*((totalHIGHvol*Dlava)/T)*LocalContributionFed))/DIS(t));  
%             Cost Function: inputing the discount rate into the cost function for changing costs (c) and events (e)
%             CDsum=sum(CD);          %storing the values for the cost function CD over time, into a matrix
%         end
%         result_vector_CD(c)=CDsum;
%         Benefit(t)=PVlava*omega(o);   %storing the values for the benefit function BD over time, into a matrix
%     end
%     result_matrix_CDsum(:,o)=result_vector_CD;   %(e,:) take this whole matrix and store it
%     result_matrix_BD(:,o)=Benefit(t);
% end
% result_matrix_NB=((result_matrix_BD-result_matrix_CDsum)/T)/Dlava;
% plot information
% pcolor(omega,cost,result_matrix_NB)
% hold on
% shading flat
% colormap(flipud(bluewhitered))
% colormap(flipud(redblue))
% Z=result_matrix_NB;
% [X,Y]=meshgrid(omega,cost);
% set(gca,'PlotBoxAspectRatio',[1,1,1])
% set(gcf,'rend','painters')
% xlabel('Omega Values','fontsize',12)
% ylabel('Sed. Costs($/m^3)','fontsize',12)
% title('LAVA 300m^3 NB $/yr/m','fontsize',15)
% 
% figure(5)
% subplot(2,2,3)
% for o=1:io
%     for c=1:ic
%         for t=1:it
%             Discount Rate over time: generating an array of values for the discount rate from year 1 to year 50
%             DIS(t)=((1+discount)^time(t));
%             CD(t)=(((cost(c)*(totalAVGvol/T)*LocalContributionFed))/DIS(t));  
%             CD(t)=(((cost(c)*((totalHIGHvol*Dwild)/T)*LocalContributionFed))/DIS(t));  
%             Cost Function: inputing the discount rate into the cost function for changing costs (c) and events (e)
%             CDsum=sum(CD);          %storing the values for the cost function CD over time, into a matrix
%         end
%         result_vector_CD(c)=CDsum;
%         Benefit(t)=PVwild*omega(o);   %storing the values for the benefit function BD over time, into a matrix
%     end
%     result_matrix_CDsum(:,o)=result_vector_CD;   %(e,:) take this whole matrix and store it
%     result_matrix_BD(:,o)=Benefit(t);
% end
% result_matrix_NB=((result_matrix_BD-result_matrix_CDsum)/T)/Dwild;
% plot information
% pcolor(omega,cost,result_matrix_NB)
% hold on
% shading flat
% colormap(flipud(bluewhitered))
% colormap(flipud(redblue))
% Z=result_matrix_NB;
% [X,Y]=meshgrid(omega,cost);
% set(gca,'PlotBoxAspectRatio',[1,1,1])
% set(gcf,'rend','painters')
% xlabel('Omega Values','fontsize',12)
% ylabel('Sed. Costs($/m^3)','fontsize',12)
% title('Wildwood 300m^3 NB $/yr/m','fontsize',15)

figure(5)
subplot(1,2,1)
for o=1:io
    for c=1:ic
        for t=1:it
            %Discount Rate over time: generating an array of values for the discount rate from year 1 to year 50
            DIS(t)=((1+discount)^time(t));
%             CD(t)=(((cost(c)*(totalAVGvol/T)*LocalContributionFed))/DIS(t));  
            CD(t)=(((cost(c)*((totalLOWvol*2000)/T)*LocalContributionFed))/DIS(t));  
            %Cost Function: inputing the discount rate into the cost function for changing costs (c) and events (e)
            CDsum=sum(CD);          %storing the values for the cost function CD over time, into a matrix
        end
        result_vector_CD(c)=CDsum;
        Benefit(t)=1000000000*omega(o);   %storing the values for the benefit function BD over time, into a matrix
    end
    result_matrix_CDsum(:,o)=result_vector_CD;   %(e,:) take this whole matrix and store it
    result_matrix_BD(:,o)=Benefit(t);
end
result_matrix_NB=((result_matrix_BD-result_matrix_CDsum)/T)/2000;
%plot information
pcolor(omega,cost,result_matrix_NB)
hold on
shading flat
% colormap(flipud(bluewhitered))
colormap(flipud(redblue))
Z=result_matrix_NB;
[X,Y]=meshgrid(omega,cost);
set(gca,'PlotBoxAspectRatio',[1,1,1])
set(gcf,'rend','painters')
xlabel('Omega Values','fontsize',12)
ylabel('Sed. Costs($/m^3)','fontsize',12)
title('Beachfront Community 60m^3 NB $/yr/m','fontsize',15)

subplot(1,2,2)
for o=1:io
    for c=1:ic
        for t=1:it
            %Discount Rate over time: generating an array of values for the discount rate from year 1 to year 50
            DIS(t)=((1+discount)^time(t));
%             CD(t)=(((cost(c)*(totalAVGvol/T)*LocalContributionFed))/DIS(t));  
            CD(t)=(((cost(c)*((totalHIGHvol*2000)/T)*LocalContributionFed))/DIS(t));  
            %Cost Function: inputing the discount rate into the cost function for changing costs (c) and events (e)
            CDsum=sum(CD);          %storing the values for the cost function CD over time, into a matrix
        end
        result_vector_CD(c)=CDsum;
        Benefit(t)=1000000000*omega(o);   %storing the values for the benefit function BD over time, into a matrix
    end
    result_matrix_CDsum(:,o)=result_vector_CD;   %(e,:) take this whole matrix and store it
    result_matrix_BD(:,o)=Benefit(t);
end
result_matrix_NB=((result_matrix_BD-result_matrix_CDsum)/T)/2000;
%plot information
pcolor(omega,cost,result_matrix_NB)
hold on
shading flat
% colormap(flipud(bluewhitered))
colormap(flipud(redblue))
Z=result_matrix_NB;
[X,Y]=meshgrid(omega,cost);
set(gca,'PlotBoxAspectRatio',[1,1,1])
set(gcf,'rend','painters')
xlabel('Omega Values','fontsize',12)
ylabel('Sed. Costs($/m^3)','fontsize',12)
title('Beachfront Community 300m^3 NB $/yr/m','fontsize',15)