%% Numerical Tests
%% Here we do all of the numerical tests included in the paper Section 2.4.2.

%% We use only zero boundary conditions.
bdcond = [0,0];
% %% Test 1:
% %% delta2 and delta3 are 0.05 the whole time, delta1 goes from 0.04 to 0.4
% 
% N = 20; 
% a_mean = @(x) x*0 + 1; 
% da_mean = @(x) x*0 + 0; 
% b_mean = @(x) x*0 + 1;
% f_mean = @(x) x*0 + 1;
% 
% delta2 = @(x) x*0 + 0.05; 
% delta3 = @(x) x*0 + 0.05;
% 
% TEST1_RESULTS = zeros(N,7);
% 
% delta1_cell = cell(1,N);
% for k = 1:N
%     delta1_cell{k} = @(x) 0.04+0.02*(k-1); 
%     TEST1_RESULTS(k,7) = 0.04+0.02*(k-1);
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic; 
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1_cell{k},delta2,delta3,bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1_cell{k},delta2,delta3,domain,bdcond,50,10);
%     TEST1_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
%     toc;
% end
% 
% save('TEST1','TEST1_RESULTS')
% 
% %% Test 2:
% %% delta1 and delta3 are 0.05, delta2 goes from 0.04 to 0.4
% 
% N = 20; 
% a_mean = @(x) x*0 + 1; 
% da_mean = @(x) x*0 + 0; 
% b_mean = @(x) x*0 + 1; 
% f_mean = @(x) x*0 + 1;
% 
% delta1 = @(x) x*0 + 0.05; 
% delta3 = @(x) x*0 + 0.05;
% 
% TEST2_RESULTS = zeros(N,7);
% 
% delta2_cell = cell(1,N); 
% for k = 1:N
%     delta2_cell{k} = @(x) 0.04+0.02*(k-1); 
%     TEST2_RESULTS(k,7) = 0.04+0.02*(k-1);
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic; 
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2_cell{k},delta3,bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1,delta2_cell{k},delta3,domain,bdcond,50,10);
%     TEST2_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
%     toc;
% end
% 
% save('TEST2','TEST2_RESULTS')
% 
% %% Test 3:
% %% delta1 and delta2 are 0.05, delta3 goes from 0.04 to 0.4
% 
% N = 20;
% a_mean = @(x) x*0 + 1;
% da_mean = @(x) x*0 + 0;
% b_mean = @(x) x*0 + 1;
% f_mean = @(x) x*0 + 1;
% 
% delta1 = @(x) x*0 + 0.05;
% delta2 = @(x) x*0 + 0.05;
% 
% TEST3_RESULTS = zeros(N,7);
% 
% delta3_cell = cell(1,N);
% for k = 1:N
%     delta3_cell{k} = @(x) x*0 + 0.02*(k-1)+0.04;
%     TEST3_RESULTS(k,7) = 0.04+0.02*(k-1);
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic;
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2,delta3_cell{k},bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1,delta2,delta3_cell{k},domain,bdcond,50,10);
%     TEST3_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx];
%     toc;
% end
% 
% save('TEST3','TEST3_RESULTS')

%% Test 4:
%% High value for alpha = 10
%% delta2 and delta3 are 0.05, delta1 goes from 0.4 to 4.4
% N = 20;
% TEST4_RESULTS = zeros(N,7);
% 
% a_mean = @(x) x*0 + 10; 
% da_mean = @(x) x*0 + 0; 
% b_mean = @(x) x*0 + 1;
% f_mean = @(x) x*0 + 1;
% 
% delta2 = @(x) x*0 + 0.05; 
% delta3 = @(x) x*0 + 0.05;
% 
% delta1_cell = cell(1,N);
% for k = 1:N
%     delta1_cell{k} = @(x) 0.2*(k-1) + 0.4; 
%     TEST4_RESULTS(k,7) = 0.2*(k-1) + 0.4;
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic; 
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1_cell{k},delta2,delta3,bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1_cell{k},delta2,delta3,domain,bdcond,50,10);
%     TEST4_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
%     toc;
% end
% 
% save('TEST4','TEST4_RESULTS')
% 
%% Test 5:
%% High value for alpha = 10
%% delta1 is 0.5 and delta3 is 0.05, delta2 goes from 0.04 to 0.44
N = 20; 

TEST5_RESULTS = zeros(N,7);


a_mean = @(x) x*0 + 10; 
da_mean = @(x) x*0 + 0; 
b_mean = @(x) x*0 + 1;
f_mean = @(x) x*0 + 1;

delta1 = @(x) x*0 + 0.5; 
delta3 = @(x) x*0 + 0.05;

delta2_cell = cell(1,N);
for k = 1:N
    delta2_cell{k} = @(x) 0.02*(k-1) + 0.04; 
    TEST5_RESULTS(k,7) = 0.02*(k-1) + 0.04;
end

domain = [0,1];

for k = 1:N
    tic; 
    [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2_cell{k},delta3,bdcond,domain);
    approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1,delta2_cell{k},delta3,domain,bdcond,50,10);
    TEST5_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
    toc;
end

save('TEST5','TEST5_RESULTS')

% Test 6:
% High value for alpha = 10
% delta1 is 0.5 and delta2 is 0.05, delta3 goes from 0.04 to 0.44

TEST6_RESULTS = zeros(N,7);

N = 20; 
a_mean = @(x) x*0 + 10; 
da_mean = @(x) x*0 + 0; 
b_mean = @(x) x*0 + 1;
f_mean = @(x) x*0 + 1;

delta2 = @(x) x*0 + 0.05; 
delta1 = @(x) x*0 + 0.5;

delta3_cell = cell(1,N);
for k = 1:N
    delta3_cell{k} = @(x) x*0 + 0.02*(k-1) + 0.04; 
    TEST6_RESULTS(k,7) = 0.02*(k-1) + 0.04;
end

domain = [0,1];

for k = 1:N
    tic; 
    [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2,delta3_cell{k},bdcond,domain);
    approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1,delta2,delta3_cell{k},domain,bdcond,50,10);
    TEST6_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
    toc;
end


save('TEST6','TEST6_RESULTS')


% %% Test 7:
% %% High value for beta = 10
% %% delta2 is 0.5 and delta3 is 0.05, delta1 goes from 0.04 to 0.44
% 
% TEST7_RESULTS = zeros(N,7);
% 
% N = 20; 
% a_mean = @(x) x*0 + 1; 
% da_mean = @(x) x*0 + 0; 
% b_mean = @(x) x*0 + 10;
% f_mean = @(x) x*0 + 1;
% 
% delta2 = @(x) x*0 + 0.5; 
% delta3 = @(x) x*0 + 0.05;
% 
% delta1_cell = cell(1,N);
% for k = 1:N
%     delta1_cell{k} = @(x) 0.02*(k-1) + 0.04; 
%     TEST7_RESULTS(k,7) = 0.02*(k-1) + 0.04;
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic; 
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1_cell{k},delta2,delta3,bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1_cell{k},delta2,delta3,domain,bdcond,50,10);
%     TEST7_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
%     toc;
% end
% 
% save('TEST7','TEST7_RESULTS')
% 
% %% Test 8:
% %% High value for beta = 10
% %% delta1 is 0.05 and delta3 is 0.05, delta2 goes from 0.4 to 4.4
% 
% TEST8_RESULTS = zeros(N,7);
% 
% N = 20; 
% a_mean = @(x) x*0 + 1; 
% da_mean = @(x) x*0 + 0; 
% b_mean = @(x) x*0 + 10;
% f_mean = @(x) x*0 + 1;
% 
% delta1 = @(x) x*0 + 0.05; 
% delta3 = @(x) x*0 + 0.05;
% 
% delta2_cell = cell(1,N);
% for k = 1:N
%     delta2_cell{k} = @(x) 0.2*(k-1) + 0.4; 
%     TEST8_RESULTS(k,7) = 0.2*(k-1) + 0.4;
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic; 
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2_cell{k},delta3,bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1,delta2_cell{k},delta3,domain,bdcond,50,10);
%     TEST8_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
%     toc;
% end
% 
% save('TEST8','TEST8_RESULTS')
% 
% % Test 9:
% % High value for beta = 10
% % delta1 is 0.05 and delta2 are 0.5, delta3 goes from 0.04 to 0.44
% 
% TEST9_RESULTS = zeros(N,7);
% 
% N = 20; 
% a_mean = @(x) x*0 + 1; 
% da_mean = @(x) x*0 + 0; 
% b_mean = @(x) x*0 + 10;
% f_mean = @(x) x*0 + 1;
% 
% delta2 = @(x) x*0 + 0.5; 
% delta1 = @(x) x*0 + 0.05;
% 
% delta3_cell = cell(1,N);
% for k = 1:N
%     delta3_cell{k} = @(x) x*0 + 0.02*(k-1) + 0.04; 
%     TEST9_RESULTS(k,7) = 0.02*(k-1) + 0.04;
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic;
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2,delta3_cell{k},bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1,delta2,delta3_cell{k},domain,bdcond,50,10);
%     TEST9_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
%     toc;
% end
% 
% save('TEST9','TEST9_RESULTS')
% 
% 
% 
% %% Test 10:
% %% High value for f = 10
% %% delta2 is 0.05 and delta3 is 0.5, delta1 goes from 0.04 to 0.44
% 
% TEST10_RESULTS = zeros(N,7);
% 
% N = 20; 
% a_mean = @(x) x*0 + 1; 
% da_mean = @(x) x*0 + 0; 
% b_mean = @(x) x*0 + 1;
% f_mean = @(x) x*0 + 10;
% 
% delta2 = @(x) x*0 + 0.05; 
% delta3 = @(x) x*0 + 0.5;
% 
% delta1_cell = cell(1,N);
% for k = 1:N
%     delta1_cell{k} = @(x) 0.02*(k-1) + 0.04; 
%     TEST10_RESULTS(k,7) = 0.02*(k-1) + 0.04;
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic; 
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1_cell{k},delta2,delta3,bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1_cell{k},delta2,delta3,domain,bdcond,50,10);
%     TEST10_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
%     toc;
% end
% 
% save('TEST10','TEST10_RESULTS')
% 
% %% Test 11:
% %% High value for f = 10
% %% delta1 is 0.05 and delta3 is 0.5, delta2 goes from 0.04 to 4.4
% 
% TEST11_RESULTS = zeros(N,7);
% 
% N = 20; 
% a_mean = @(x) x*0 + 1; 
% da_mean = @(x) x*0 + 0; 
% b_mean = @(x) x*0 + 1;
% f_mean = @(x) x*0 + 10;
% 
% delta1 = @(x) x*0 + 0.05; 
% delta3 = @(x) x*0 + 0.5;
% 
% delta2_cell = cell(1,N);
% for k = 1:N
%     delta2_cell{k} = @(x) 0.02*(k-1) + 0.04; 
%     TEST11_RESULTS(k,7) = 0.02*(k-1) + 0.04;
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic; 
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2_cell{k},delta3,bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1,delta2_cell{k},delta3,domain,bdcond,50,10);
%     TEST11_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
%     toc;
% end
% 
% save('TEST11','TEST11_RESULTS')
% 
% %% Test 12:
% %% High value for f = 10
% %% delta1 is 0.05 and delta2 is 0.05, delta3 goes from 0.4 to 4.4
% 
% TEST12_RESULTS = zeros(N,7);
% 
% N = 20; 
% a_mean = @(x) x*0 + 1; 
% da_mean = @(x) x*0 + 0; 
% b_mean = @(x) x*0 + 1;
% f_mean = @(x) x*0 + 10;
% 
% delta2 = @(x) x*0 + 0.05; 
% delta1 = @(x) x*0 + 0.05;
% 
% delta3_cell = cell(1,N);
% for k = 1:N
%     delta3_cell{k} = @(x) x*0 + 0.2*(k-1) + 0.4; 
%     TEST12_RESULTS(k,7) = 0.2*(k-1) + 0.4;
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic; 
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2,delta3_cell{k},bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1,delta2,delta3_cell{k},domain,bdcond,50,10);
%     TEST12_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
%     toc;
% end
% 
% save('TEST12','TEST12_RESULTS')




% % Test 13: oscillating alpha
% % delta2 and delta3 are 0.05, delta1 from 0.04 to 0.30
% 
% TEST13_RESULTS = zeros(N,7);
% 
% N = 20; 
% a_mean = @(x) sin(12.*x)./4 + 1; 
% da_mean = @(x) 3.*cos(12.*x);
% b_mean = @(x) x*0 + 1;
% f_mean = @(x) x*0 + 1;
% 
% delta3 = @(x) x*0 + 0.05; 
% delta2 = @(x) x*0 + 0.05;
% 
% delta1_cell = cell(1,N);
% for k = 1:N
%     delta1_cell{k} = @(x) x*0 + 0.014*(k-1) + 0.04; 
%     TEST13_RESULTS(k,7) = 0.014*(k-1) + 0.04;
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic; 
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1_cell{k},delta2,delta3,bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1_cell{k},delta2,delta3,domain,bdcond,50,50);
%     TEST13_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
%     toc;
% end
% 
% save('TEST13','TEST13_RESULTS')
% 
% 
% % Test 14: oscillating alpha
% % delta1 and delta3 are 0.05, delta2 from 0.04 to 0.3
% 
% 
% TEST14_RESULTS = zeros(N,7);
% 
% N = 20; 
% a_mean = @(x) sin(12.*x)./4 + 1; 
% da_mean = @(x) 3.*cos(12.*x);
% b_mean = @(x) x*0 + 1;
% f_mean = @(x) x*0 + 1;
% 
% delta3 = @(x) x*0 + 0.05; 
% delta1 = @(x) x*0 + 0.05;
% 
% delta2_cell = cell(1,N);
% for k = 1:N
%     delta2_cell{k} = @(x) x*0 + 0.014*(k-1) + 0.04; 
%     TEST14_RESULTS(k,7) = 0.014*(k-1) + 0.04;
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic; 
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2_cell{k},delta3,bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1,delta2_cell{k},delta3,domain,bdcond,50,50);
%     TEST14_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
%     toc;
% end
% 
% save('TEST14','TEST14_RESULTS')
% 
% 
% 
% % Test 15: oscillating alpha
% % delta1 and delta2 are 0.05, delta3 from 0.04 to 0.3
% 
% 
% TEST15_RESULTS = zeros(N,7);
% 
% N = 20; 
% a_mean = @(x) sin(12.*x)./4 + 1; 
% da_mean = @(x) 3.*cos(12.*x);
% b_mean = @(x) x*0 + 1;
% f_mean = @(x) x*0 + 1;
% 
% delta2 = @(x) x*0 + 0.05; 
% delta1 = @(x) x*0 + 0.05;
% 
% delta3_cell = cell(1,N);
% for k = 1:N
%     delta3_cell{k} = @(x) x*0 + 0.014*(k-1) + 0.04; 
%     TEST15_RESULTS(k,7) = 0.014*(k-1) + 0.04;
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic; 
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2,delta3_cell{k},bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1,delta2,delta3_cell{k},domain,bdcond,50,50);
%     TEST15_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
%     toc;
% end
% 
% save('TEST15','TEST15_RESULTS')
% 
% 
% %%%%%%%%%%%%%%%%%%%
% 
% 
% %% Test 16: oscillating beta
% %% delta2 and delta3 are 0.05, delta1 from 0.04 to 0.3
% 
% TEST16_RESULTS = zeros(N,7);
% 
% N = 20; 
% a_mean = @(x) x*0 + 1; 
% da_mean = @(x) x*0 + 0;
% b_mean = @(x) sin(12.*x)./4 + 1;
% f_mean = @(x) x*0 + 1;
% 
% delta3 = @(x) x*0 + 0.05; 
% delta2 = @(x) x*0 + 0.05;
% 
% delta1_cell = cell(1,N);
% for k = 1:N
%     delta1_cell{k} = @(x) x*0 + 0.014*(k-1) + 0.04; 
%     TEST16_RESULTS(k,7) = 0.014*(k-1) + 0.04;
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic; 
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1_cell{k},delta2,delta3,bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1_cell{k},delta2,delta3,domain,bdcond,50,50);
%     TEST16_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
%     toc;
% end
% 
% save('TEST16','TEST16_RESULTS')
% 
% 
% %% Test 17: oscillating beta
% %% delta1 and delta3 are 0.05, delta2 from 0.04 to 0.3
% 
% TEST17_RESULTS = zeros(N,7);
% 
% N = 20; 
% a_mean = @(x) x*0 + 1; 
% da_mean = @(x) x*0 + 0;
% b_mean = @(x) sin(12.*x)./4 + 1;
% f_mean = @(x) x*0 + 1;
% 
% delta3 = @(x) x*0 + 0.05; 
% delta1 = @(x) x*0 + 0.05;
% 
% delta2_cell = cell(1,N);
% for k = 1:N
%     delta2_cell{k} = @(x) x*0 + 0.014*(k-1) + 0.04; 
%     TEST17_RESULTS(k,7) = 0.014*(k-1) + 0.04;
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic; 
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2_cell{k},delta3,bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1,delta2_cell{k},delta3,domain,bdcond,50,50);
%     TEST17_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
%     toc;
% end
% 
% save('TEST17','TEST17_RESULTS')
% 
% 
% 
% %% Test 18: oscillating beta
% %% delta1 and delta2 are 0.05, delta3 from 0.04 to 0.3
% 
% TEST18_RESULTS = zeros(N,7);
% 
% N = 20; 
% a_mean = @(x) x*0 + 1; 
% da_mean = @(x) x*0 + 0;
% b_mean = @(x) sin(12.*x)./4 + 1;
% f_mean = @(x) x*0 + 1;
% 
% delta2 = @(x) x*0 + 0.05; 
% delta1 = @(x) x*0 + 0.05;
% 
% delta3_cell = cell(1,N);
% for k = 1:N
%     delta3_cell{k} = @(x) x*0 + 0.014*(k-1) + 0.04; 
%     TEST18_RESULTS(k,7) = 0.014*(k-1) + 0.04;
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic; 
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2,delta3_cell{k},bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1,delta2,delta3_cell{k},domain,bdcond,50,50);
%     TEST18_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
%     toc;
% end
% 
% save('TEST18','TEST18_RESULTS')
% 
% 
% 
% 
% %%%%%%%%%%%%
% 
% 
% %% Test 19: oscillating f
% %% delta2 and delta3 are 0.05, delta1 from 0.04 to 0.3
% 
% TEST19_RESULTS = zeros(N,7);
% 
% N = 20; 
% a_mean = @(x) x*0 + 1; 
% da_mean = @(x) x*0 + 0;
% b_mean = @(x) x*0 + 1;
% f_mean = @(x) sin(12.*x)./4 + 1;
% 
% delta3 = @(x) x*0 + 0.05; 
% delta2 = @(x) x*0 + 0.05;
% 
% delta1_cell = cell(1,N);
% for k = 1:N
%     delta1_cell{k} = @(x) x*0 + 0.014*(k-1) + 0.04; 
%     TEST19_RESULTS(k,7) = 0.014*(k-1) + 0.04;
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic; 
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1_cell{k},delta2,delta3,bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1_cell{k},delta2,delta3,domain,bdcond,50,50);
%     TEST19_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
%     toc;
% end
% 
% save('TEST19','TEST19_RESULTS')
% 
% 
% %% Test 20: oscillating f
% %% delta1 and delta3 are 0.05, delta2 from 0.04 to 0.3
% 
% TEST20_RESULTS = zeros(N,7);
% 
% N = 20; 
% a_mean = @(x) x*0 + 1; 
% da_mean = @(x) x*0 + 0;
% b_mean = @(x) x*0 + 1;
% f_mean = @(x) sin(12.*x)./4 + 1;
% 
% delta3 = @(x) x*0 + 0.05; 
% delta1 = @(x) x*0 + 0.05;
% 
% delta2_cell = cell(1,N);
% for k = 1:N
%     delta2_cell{k} = @(x) x*0 + 0.014*(k-1) + 0.04; 
%     TEST20_RESULTS(k,7) = 0.014*(k-1) + 0.04;
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic; 
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2_cell{k},delta3,bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1,delta2_cell{k},delta3,domain,bdcond,50,50);
%     TEST20_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
%     toc;
% end
% 
% save('TEST20','TEST20_RESULTS')
% 
% 
% 
% %% Test 21: oscillating f
% %% delta1 and delta2 are 0.05, delta3 from 0.04 to 0.3
% 
% TEST21_RESULTS = zeros(N,7);
% 
% N = 20; 
% a_mean = @(x) x*0 + 1; 
% da_mean = @(x) x*0 + 0;
% b_mean = @(x) x*0 + 1;
% f_mean = @(x) sin(12.*x)./4 + 1;
% 
% delta2 = @(x) x*0 + 0.05; 
% delta1 = @(x) x*0 + 0.05;
% 
% delta3_cell = cell(1,N);
% for k = 1:N
%     delta3_cell{k} = @(x) x*0 + 0.014*(k-1) + 0.04; 
%     TEST21_RESULTS(k,7) = 0.014*(k-1) + 0.04;
% end
% 
% domain = [0,1];
% 
% for k = 1:N
%     tic; 
%     [lower_bound, B_1, B_2, B_3, B_4] = diameter_bounds(a_mean,da_mean,b_mean,f_mean,delta1,delta2,delta3_cell{k},bdcond,domain);
%     approx = adaptbruteforce(a_mean,b_mean,f_mean,delta1,delta2,delta3_cell{k},domain,bdcond,50,50);
%     TEST21_RESULTS(k,1:6) = [lower_bound,B_1,B_2,B_3,B_4,approx]; 
%     toc;
% end
% 
% save('TEST21','TEST21_RESULTS')


%% Test 22: oscillating delta1
%% 












