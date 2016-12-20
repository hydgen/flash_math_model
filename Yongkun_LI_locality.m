%cost_d
%cost_i_d
%cost_a_d

%A_i
S=(t-u)./t; %spare factor(the proportion of reserved blocks)
%S_prime
k=Np; %the number of pages per block

%r_i
%f_i
f_a = 1; %active region

S_prime = S ./ ( (1-S).*f_a + S );

%sigma넣기
%cost_d 확인하기
%cost_d = ( ((k-cost_d)*r_i) / (e^(A_i)-1)) )

%A_i = ( r_i * (k - cost_d )) / ((1-S_prime)* k * f_i )

cost_d = -lambertw (-(1 ./ (1-S_prime)) .* exp(-(1 ./ (1-S_prime))) ) ./ (1 ./ ((1-S_prime).*k));


A_lo= Np ./ (Np-cost_d);