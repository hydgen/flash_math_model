%FID=fopen('testNp64.txt','a+');

for i=1:1;
    i
    %pause(10);
%입력값
%clearvars -except FID
%clear
SizeofCal=1000;
u=200000;
increment = u/SizeofCal;
t=[u*2+increment:increment:u*3];
r=10;
s=500;
Np=32768;

%시간재기
%time_cc=clock;
%tic;
%Np=128;
%Hu_kpks
%elapsed_cc128_time(i)=toc;
%t_cc=etime(clock,time_cc);

%tic;
%Np=256;
%Hu_kpks
%elapsed_cc256_time(i)=toc;

%tic;
%Np=512;
%Hu_kpks
%elapsed_cc512_time(i)=toc;

%time_ud=clock;
tic;
R_Agarwal_UD
elapsed_ud_time(i)=toc;
%t_ud=etime(clock,time_ud);

%time_ev=clock;
tic;
X_Luojie_EV
elapsed_ev_time(i)=toc;
%t_ev=etime(clock,time_ev);

%time_m=clock;
tic;
Desnoyer_Markov
elapsed_mar_time(i)=toc;
%t_m=etime(clock,time_m);

%time_m=clock;
%tic;
%Yongkun_LI_locality
%elapsed_lo_time(i)=toc;
%t_m=etime(clock,time_m);



%clearvars -except elapsed_mar64_time elapsed_mar128_time elapsed_mar256_time elapsed_mar512_time

%clearvars -except elapsed_cc_time elapsed_ud_time elapsed_ev_time elapsed_mar_time
%clearvars -except elapsed_cc64_time elapsed_cc128_time elapsed_cc256_time elapsed_cc512_time

%fprintf(FID,'%f\t%f\t%f\t%f\n',elapsed_time(1),elapsed_time(2),elapsed_time(3),elapsed_time(4));

end

%fclose(FID);


figure(1);
%plot(rho,A_cc, 'k', 'LineWidth', 2);
plot(rho,A_ud, 'r', 'LineWidth', 2);
hold on;
grid on;
plot(rho,A_eva, 'g', 'LineWidth', 2);
plot(rho,A_mar_greedy, 'b', 'LineWidth', 2);
plot(rho,A_lo, 'k', 'LineWidth', 2);


%plot(rho,A_evr, 'm');
%plot(rho,A_mar_lru, 'c');

legend('Uniform Distribution','Expected Value','Markov (greedy)','Yongkun Li');
%legend('Coupon Collector','Uniform Distribution','Expected Value','Markov (greedy)');
axis([0 1 0 5]);
xlabel('Overprovisioning Factor ρ');
ylabel('Write Amplification');
title('Write Amplification, Np=64');

%figure(2);
%bar(elapsed_time);
%ylabel('Elapsed Time');