%fac(1)=1;
%fac(2)=1;
%for fa=3:1:65;
%    fac(fa) = fac(fa-1) * (fa-1);
%end

%for t=0:1:64;
%    test(t+1) = factorial(t)-fac(t+1);
%end

%max(test)

FID = fopen('test.txt','a+');
for test=1:1:10;
    test
    clearvars -except FID
    t=[1:1:4];
%fprintf(FID,'test\n');
fprintf(FID,'%f\t%f\t%f\t%f\n',t(1),t(2),t(3),t(4));
end
fclose(FID);

%for testcount=1:1:100;
%    testcount
%    compare;
%    pause(10);
%end
