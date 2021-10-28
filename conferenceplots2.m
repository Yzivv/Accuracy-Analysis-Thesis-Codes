%% More plotting for conference

arang = [1,3];
brang = [1,3];
frang = [3,10];

maxdelta1 = 0.3;
maxdelta2 = 0.3;
maxdelta3 = 0.3;

a_mean = rand(4,1).*(arang(2)-arang(1)) + arang(1);
b_mean = rand(4,1).*(brang(2)-brang(1)) + brang(1);
f_mean = rand(4,1).*(frang(2)-frang(1)) + frang(1);

delta1 = rand(4,1).*a_mean*0.3;
delta2 = rand(4,1).*b_mean*0.3;
delta3 = rand(4,1).*f_mean*0.3;

a = [a_mean-delta1, a_mean+delta1];
b = [b_mean-delta2, b_mean+delta2];
f = [f_mean-delta3, f_mean+delta3];



x1 = [0,0.25];
x2 = [0.25,0.5];
x3 = [0.5,0.75];
x4 = [0.75, 1.0];
ne = [0.125,0.375,0.625,0.875];

x = [x1;x2;x3;x4];

subplot(1,3,1)
for k=1:4
    hold on
    h(1) = plot(x(k,:),[a(k,1),a(k,1)],'b','LineWidth',3);
    plot(x(k,:),[a(k,2),a(k,2)],'b','LineWidth',3);
end
h(2) = plot(ne,a(:,1),'ro','LineWidth',4);
plot(ne,a(:,2),'ro','LineWidth',4);
ylim([0,6])
lgd = legend(h([1,2]),{'Bounds for coefficient \alpha','Network input of \alpha'});
lgd.FontSize = 30;
set(gca,'FontSize',24);

subplot(1,3,2)
for k=1:4
    hold on
    h(1) = plot(x(k,:),[b(k,1),b(k,1)],'b','LineWidth',3);
    plot(x(k,:),[b(k,2),b(k,2)],'b','LineWidth',3);
end
h(2) = plot(ne,b(:,1),'ro','LineWidth',4);
plot(ne,b(:,2),'ro','LineWidth',4);
ylim([0,6])
lgd = legend(h([1,2]),{'Bounds for coefficient \beta','Network input of \beta'});
lgd.FontSize = 30;
set(gca,'FontSize',24);

subplot(1,3,3)
for k=1:4
    hold on
    h(1) = plot(x(k,:),[f(k,1),f(k,1)],'b','LineWidth',3);
    plot(x(k,:),[f(k,2),f(k,2)],'b','LineWidth',3);
end
h(2) = plot(ne,f(:,1),'ro','LineWidth',4);
plot(ne,f(:,2),'ro','LineWidth',4);
ylim([0,16]);
lgd = legend(h([1,2]),{'Bounds for coefficient f','Network input of f'});
lgd.FontSize = 30;
set(gca,'FontSize',24);


xx = linspace(0,1,5);
sol_intervals = 8;
func_amount = 30;
bdcond = [0,0];
[u_cells, du_cells] = SetPieceConst2(a,b,f,xx,sol_intervals,func_amount,bdcond);
figure()

%% Turning the examples into spline functions for integration.
%% Here using 100 piece fit which is very accurate. Input is 101 so that we have 100 pieces.
[u_splines, du_splines] = splinecells(u_cells,du_cells,101);
breaks = u_splines{1}.breaks;

%% Brute force calculation of the maximum energy distance in the solution cloud

am = transpose(mean(a,2));
bm = transpose(mean(b,2));
a_mean_extended = transpose(repelem(am,25));
b_mean_extended = transpose(repelem(bm,25));
[I,I_mat] = MaxEnergySpline2(breaks,u_splines,du_splines,a_mean_extended,b_mean_extended);

%% Setting the values of the max and min coefficient functions at the looking points

PlotSet(u_cells,linspace(0,1),'no');
%annotation('textbox', [0.75, 0.1, 0.1, 0.1], 'String', "Diam(S(D)) \approx " + I)
look = ne;
value = FindValsConst(a,b,f,xx,ne);
val = [value(1,:),value(2,:),value(3,:),value(4,:),value(5,:),value(6,:)];
[sprintf('%1.1f,', val(1:end-1)), sprintf('%1.1f', val(end))]

