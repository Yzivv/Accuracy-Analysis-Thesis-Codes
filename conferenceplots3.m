lblue = [0.0244 0.4350 0.8755];

x = linspace(0,1);
a_mean = @(x) sin(10.*x)+3;

ylim([0,7])
hold on
delta = 1;

a_max = @(x) a_mean(x) + delta;
a_min = @(x) a_mean(x) - delta;

%t(2) = plot(x,arrayfun(a_max,x),'b');
%t(3) = plot(x,arrayfun(a_min,x),'b');

h = linspace(0.05,0.95,10);

x2 = [x, fliplr(x)];

inBetween = [arrayfun(a_max,x),fliplr(arrayfun(a_min,x))];

t(1) = fill(x2,inBetween,lblue);
t(2) = plot(x,arrayfun(a_mean,x),'g', 'LineWidth', 2);
t(3) = plot(h,arrayfun(a_max,h),'ro','LineWidth',3);
t(4) = plot(h,arrayfun(a_min,h),'ro','LineWidth',3);

lgd = legend(t([1,2,4]),{'The strip inside which elements of D_\alpha exist','Central element of D_\alpha','Network input of \alpha'});
lgd.FontSize = 23;
set(gca,'FontSize',24);