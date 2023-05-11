%%%%%%%%%%%%%%
x=1900:2099;
rand('seed',10);
y1=rand(200,1);
y1=y1*100;
x0=linspace(1,10,200)';
y2=-(x0-3).*(x0-5.5).*(x0-9);
y3=934;
y=y1+y2+y3+2;
y(182:end)=y(182:end)+60;
y(1:150)=y(1:150)+30;
a=y(1990-1900:2050-1900);
b=1000+rand(size(a))*10;
y(1990-1900:2050-1900)=b;
data=y;
save('D:\ToE\output_data\test_pixel_data.mat','data');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd D:\ToE\figures
load('test_pixel_data.mat','data');
%%smooth  running mean
width=11; %the moving-window years
data=nanfastsmooth(data,width,1);
%data=smooth(data,width);
%%smooth

%%cal FirstWS and EndWS
tic
[ToE,ToD]=Cal_WS(data,1000)
toc %the executing time for only one pixel or a watershed
%%cal FirstWS and EndWS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%plot the results
close all
figure('unit','centimeters','Position',[0 0 55 30]);

h1=plot(x(1:end-10),y(1:end-10),'c','Linewidth',1);
hold on
line([1900 2090],[1000 1000])
set(gca,'XMinorTick','on')%最小刻度
set(gca,'YMinorTick','on')%最小刻度
%%%%%%%%%%%%%%
xi = 1900:0.1:2089;
yi = interp1(x(1:end-10),data(1:end-10),xi,'linear'); %only show 19000-2090
hold on
h2=area(xi,yi,1000,'FaceColor','b','FaceAlpha',1);%
h3=area(xi,bsxfun(@min, yi, 1000),'FaceColor','r','FaceAlpha',1);
h4=plot(x(1:end-10),data(1:end-10),'Linestyle','-','Marker','none','color','k','Linewidth',2);
%%%%%%%%%%%%
xlim = get(gca,'XLim');
ylim = get(gca,'YLim');
x1=0+(ToE-xlim(1))/diff(xlim);
x2=0+(ToD-xlim(1))/diff(xlim);
% Add labels
%
line([ToE ToE],[1000 1.01*mean(ylim)],'linestyle','-','color','r','Linewidth',2.0)
text(ToE,1.01*mean(ylim),num2str(ToE),'rotation',90,'Color','r','FontName','Arial','FontSize',14,'fontweight','bold');
%
line([ToD ToD],[1000 1.01*mean(ylim)],'linestyle','-','color','b','Linewidth',2.0)
text(ToD,1.01*mean(ylim),num2str(ToD),'rotation',90,'Color','b','FontName','Arial','FontSize',14,'fontweight','bold');
%
line([ToE ToE],[940 1000],'linestyle','--','color','r','Linewidth',2.0)
line([ToE+4 ToE+4],[940 1000],'linestyle','--','color','r','Linewidth',2.0)
%
line([ToD ToD],[940 1000],'linestyle','--','color','b','Linewidth',2.0)
line([2089 2089],[940 1000],'linestyle','--','color','b','Linewidth',2.0)
%%%%%%%%%%%%%%%%%%%%%
text('Units','normalized','Position',[x1, 0.85],'String',['FirstWS: ',num2str(ToE)],'rotation',0,'Color','r','FontName','Arial','FontSize',16,'fontweight','bold');
text('Units','normalized','Position',[x2-0.2, 0.85],'String',['EndWS: ',num2str(ToD)],'rotation',0,'Color','b','FontName','Arial','FontSize',16,'fontweight','bold');
%%%
set(gca,'FontSize',14,'FontName','Times New Roman','fontweight','bold')
set(gca,'Xlim',[1900 2090],'xtick',[1900:10:2090],'xticklabel',[1900:10:2090])
ylabel ('Water availability per capita (m^3/person/yr)','Fontsize',16,'fontweight','bold'); 
xlabel ('Year','Fontsize',16,'fontweight','bold');

text('Units','normalized','Position',[x1, 0.22],'String','At least five years','rotation',0,'Color','k','FontName','Arial','FontSize',16,'fontweight','bold');
text('Units','normalized','Position',[x2, 0.22],'String','Last until 2090','rotation',0,'Color','k','FontName','Arial','FontSize',16,'fontweight','bold');

lgd=legend([h1,h4,h3,h2],{'Water availability per capita (Not smoothed)','Water availability per capita (Smoothed 11 yr)','Water scarcity','Non-water scarcity'},'Location','north','FontSize',18,'FontWeight','bold','NumColumnsMode','manual','NumColumns',2);
lgd.Box='off';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%save pic
exportgraphics(gcf,'test_FirstWS&EndWS.jpg','Resolution',350);% no white 
%%%%%%%%%%%%%%%%%%%%%
