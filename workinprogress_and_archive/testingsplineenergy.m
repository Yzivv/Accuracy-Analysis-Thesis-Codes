% splinetesting

ai = [1,2.4; 2,3.4; 1,2.5; 2.0,2.6];
bi = [2,2.4; 3,3.4; 2.4,2.5; 2.7,2.9];
fi = [11.0,15.0; -5,-6; -10,-16; 6,10];
x = linspace(0,1,5);

[u_cells, du_cells] = SetPieceConst2(ai,bi,fi,x,4,300,[0,0]);

real_ans = energyAB(linspace(0,1),u_cells{1},du_cells{1},u_cells{2},du_cells{2});

[u_splines, du_splines] = splinecells(u_cells, du_cells,30);


n = length(u_splines{1}.breaks)-1;
breaks = u_splines{1}.breaks;

ucoefs = u_splines{1}.coefs - u_splines{2}.coefs;
ducoefs = du_splines{1}.coefs - du_splines{2}.coefs;

ucnew = zeros(n,7);
ducnew = zeros(n,7);

for i = 1:n
    ucnew(i,:) = conv(ucoefs(i,:),ucoefs(i,:));
    ducnew(i,:) = conv(ducoefs(i,:),ducoefs(i,:));
end

usplint = mkpp(breaks,ucnew);
dusplint = mkpp(breaks,ducnew);

int1 = quadgk(@(t)ppval(usplint,t),breaks(1),breaks(end),'Waypoints',breaks);
int2 = quadgk(@(t)ppval(dusplint,t),breaks(1),breaks(end),'Waypoints',breaks);

spline_ans = sqrt(int1+int2);