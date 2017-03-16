kpks = zeros(1,SizeofCal);

%fac(n+1) = factorial(n)
fac(1)=1;
fac(2)=1;
for fa=3:1:Np+1;
    %fac(fa) = fac(fa-1) * (fa-1);
    fac(fa) = sqrt(2*pi*(fa-1)) * ((fa-1)/exp(1))^(fa-1);
end



for k=1:1:Np-1;
    %pajvjk1=1;%ones(1,10001);
    %pajvjk2=1;%ones(1,10001);

    for jj=0:1:s-1;
        spjm1 = zeros(1,SizeofCal);
        hj1 = (t-r-u).*Np;%(max(0 , Np.*(t-r-jj-1) - u*Np*((1-(1/(u*Np)))^((jj+1)*Np)) ) );%
        pj1 = ( (1-(1/(u*Np))).^hj1 );
        %h1(1,jj+1)=hj1;
        %p1(1,jj+1)=pj1;

        for m=0:1:k-1;
            spjm1 = spjm1 + ( ( (fac(Np+1) ) / (fac(m+1) * fac(Np-m+1) ) ) .* (pj1.^m) .* ((1-pj1).^(Np-m)) );
            %s1(jj+1,m+1)=spjm1;
        end
        
        if jj==0
            pajvjk1 = 1-spjm1;
        else
            pajvjk1 = pajvjk1.*(1-spjm1);
        end
        %pa1(1,jj+1)=pajvjk1;
    end

    for jj=0:1:s-1;
        spjm2 = zeros(1,SizeofCal);
        hj2 = (t-r-u)*Np;%(max(0 , Np.*(t-r-jj-1) - u*Np*((1-(1/(u*Np)))^((jj+1)*Np)) ) );%
        pj2 = ( (1-(1/(u*Np))).^hj2 );
        %h2(1,jj+1)=hj2;
        %p2(1,jj+1)=pj2;

        for m=0:1:k;
            spjm2 = spjm2 + ( ( (fac(Np+1) ) / (fac(m+1) * fac(Np-m+1) ) ) .* (pj2.^m) .* ((1-pj2).^(Np-m)) );
            %s2(jj+1,m+1)=spjm2;
        end
        
        if jj==0
            pajvjk2 = 1-spjm2;
        else
            pajvjk2 = pajvjk2.*(1-spjm2);
        end
       % pa2(1,jj+1)=pajvjk2;
    end
    
    kpks = kpks+(k.*(pajvjk1-pajvjk2));
    %kp(1,k);
end
A_cc=Np./(Np-kpks);