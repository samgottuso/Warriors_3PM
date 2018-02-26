%%sgottus1 Intro Computing Project
%%Import/setup
importdata('warriors_data.csv');
warriorsdata=importdata('warriors_data.csv');
warriorsnumbs=(warriorsdata.data);
threepointpercent=warriorsnumbs(1:82,8);
assists=warriorsnumbs(1:82,14);
steals=warriorsnumbs(1:82,15);
warriorstextdata=(warriorsdata.textdata);
%%Seperating data into different variables
gamenum=warriorstextdata(3:84,2);
rawwin=warriorstextdata(3:84,6);;
morethanavg3=find(threepointpercent>.354);
lessthanavg3=find(threepointpercent<.354);
assistsoveravg=find(assists>22.29);
assistsunderavg=find(assists<22.29);
stealsoveravg=find(steals>7.85);
stealsunderavg=find(steals<7.85);
winloss_edit=[1:24,26:30,32:38,40,42:52,54:60,62:68,70:75,77,79:82];
lossloss_edit=[25,31,39,41,53,61,69,76,78];
%%Finding interesect between stat and games that were won/lost
mta3_w= intersect(morethanavg3,winloss_edit); 
mta3_l= intersect(morethanavg3,lossloss_edit);
lta3_w= intersect(lessthanavg3,winloss_edit);
lta3_l= intersect(lessthanavg3,lossloss_edit);
aoa_w= intersect(assistsoveravg,winloss_edit);
aoa_l= intersect(assistsoveravg,lossloss_edit);
aua_w= intersect(assistsunderavg,winloss_edit);
aua_l= intersect(assistsunderavg,lossloss_edit);
soa_w= intersect(stealsoveravg,winloss_edit);
soa_l= intersect(stealsoveravg,lossloss_edit);
sua_w= intersect(stealsunderavg,winloss_edit);
sua_l= intersect(stealsunderavg,lossloss_edit);
%showing percentage of wins while having more or less than the league
%average variable
aa3wp=length(mta3_w)/(length(winloss_edit));
ua3wp=length(lta3_w)/(length(winloss_edit));
aa3lp=length(mta3_l)/(length(lossloss_edit));
ua3lp=length(lta3_l)/(length(lossloss_edit));
aaawp=length(aoa_w)/(length(winloss_edit));
uaawp=length(aua_w)/(length(winloss_edit));
aaalp=length(aoa_l)/(length(lossloss_edit));
uaalp=length(aua_l)/(length(lossloss_edit));
aaswp=length(soa_w)/(length(winloss_edit));
uaswp=length(sua_w)/(length(winloss_edit));
aaslp=length(soa_l)/(length(lossloss_edit));
uaslp=length(sua_l)/(length(lossloss_edit));
%%Calculating probabilities (numeric analysis)
morelikelytowin3=aa3wp/ua3wp;
morelikelytolose3=ua3lp/aa3lp;
morelikelytowina=aaawp/uaawp;
morelikelytolosea=uaalp/aaalp;
morelikelytowinsteal=aaswp/uaswp;
morelikelytolosesteal=uaslp/aaslp;

%%Creating Plot for Winning
winz=[morelikelytowin3,morelikelytowina,morelikelytowinsteal];
bar([winz])
title('Characteristic Most Important to Winning','Color','b','Fontsize',20)
set(gca,'XTickLabel',{'Three Point Percentage','Assists Per Game','Steals Per Game'})
xlabel('Statistic to be Measured','color','b','Fontsize',16)
ylabel('Statistical Win Share','color','b','Fontsize',16)
legend('Chance that win came when performing above league average','Location','northwest')

%%Creating Plot for Losing
losez=[morelikelytolose3,morelikelytolosea,morelikelytolosesteal];
figure;bar([losez])
title('Characteristic Most Predictive of Losing','Color','b','Fontsize',20)
set(gca,'XTickLabel',{'Three Point Percentage','Assists Per Game','Steals Per Game'})
xlabel('Statistic to be Measured','color','b','Fontsize',16)
ylabel('Statistical Win Share','color','b','Fontsize',16)
legend('Chance that loss came when performing below league average','Location','northwest')
maximumwins=max(winz)
maximumlosses=max(losez)
minwins=min(winz)
minlosses=min(losez)
%%Writting Data to Text File
fopen('warriorsresults.txt','w');
formatSpec='When the Warriors assist at a rate above the league average, they are %4.3f times more likely to win compared to when they shoot above league average, or have more steals than the league average. . \n When the Warriors shoot below league average they are %4.2f times more likely to lose compared to when they assist or steal at a rate below league average.';
fprintf(formatSpec,maximumwins,maximumlosses)

