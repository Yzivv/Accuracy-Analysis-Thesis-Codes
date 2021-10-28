%% Plotting for conference

x1 = [0,1];
x2 = 0.1:0.2:1;

a = [1,1;3,3];
a_mean = [2,2];
f_mean = [4.5,4.5];
f = [3,3;6,6];

n1 = [1,1,1,1,1];
n2 = [3,3,3,3,3];
n3 = [6,6,6,6,6];

subplot(1,2,1);
h(1) = plot(x1,a(1,:),'b','LineWidth',2);
hold on
h(2) = plot(x1,a(2,:),'b','LineWidth',2);
ylim([0,10]);
h(3) = plot(x2,n1,'ro','LineWidth',2);
h(4) = plot(x2,n2,'ro','LineWidth',2);
%h(5) = plot(x1,a_mean,'g','LineWidth',2);
legend(h([1,3]),{'Bounds for coefficient \alpha','Network input of \alpha'})


subplot(1,2,2);
h(1) = plot(x1,f(1,:),'b','LineWidth',2);
hold on
h(2) = plot(x1,f(2,:),'b','LineWidth',2);
ylim([0,10]);
h(3) = plot(x2,n2,'ro','LineWidth',2);
h(4) = plot(x2,n3,'ro','LineWidth',2);
%h(5) = plot(x1,f_mean,'g','LineWidth',2);
legend(h([1,3]),{'Bounds for coefficient f','Network input of f'});