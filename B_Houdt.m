%mean field by Benny
%Changhyun Park
clear;

%test value
N=128; %N of blocks
U=120;%N of user-visible block
b=64; %N of pages of each block
d=10; %d-choice GC
rho = U/N;

%gc policy
%d-choice=0
%random=1
%random++=2
gcp=2;

%A = b/(b- X);
%X=sigma j=0~b (j*p_j);


%X_n^N(t)임시값
%추후 수정하기, 현재 임시값.
for n=1:N;
    XnN(n)=randi(b);
end


%M_i^N(t)
%MiNt= (1/N) * sigma n=1~N (1 [XnN(t)=i]), i=0~b;
%X_n^N(t): the numver of valid pages on blocknumber n at time t
for i=1:b;
    sum1(i)=0;

    for n=1:N;
        if XnN(n)==i;
            sum1(i) = 1;
        end
    end
end
MiNt(i) = (1/N) * sum(sum1);


%MNt= sigma i=0~b (MiNt*ei);
%e(i)=i-th unit vector
for i=1:b;
    %sum0(i)=0;
    %sum0(i) = MiNt(i) * e(i);   
end



        

%m_i; -> m(i); the fraction of blocks containing exactly i valid pages
    %추후 수정이 필요함. 현재는 임의의 값.
for i=0:b;
    m(i+1)=1/(b+1);
end
while sum(m)==1;
    for i=0:b;
       m(i+1)=1/(b+1); 
    end
end


%GC 정책에 따른 p_i(m) -> {p_m(i)} 값 계산식
%d-choice GC
%p_j_m=(sigma l=j~b (m_l))^d - (sigma l=j+1~b (m_l))^d;
if gcp==0;
    for j=0:b;
        sum_mj_d1=0;
        sum_mj_d2=0;
        for l=j:b;
            sum_mj_d1=sum_mj_d1+m(l+1);
        end
        for l=j+1:b;
            sum_mj_d2=sum_mj_d2+m(l+1);
        end
        p_m(j+1) = sum_mj_d1^d - sum_mj_d2^d;
    end

elseif gcp==1;   
%random GC (p_j(m)=m_j)
    for j=0:b;
        p_m(j+1) = m(j+1);
        %fb(m) = (1-m_b)-( ((1-rho)/rho)*b*m_b );
        %fi(m) = ((1-rho)/rho) * ((i+1)*m_(i+1)-i*m(i)) - m(i);
    end

elseif gcp==2;
%random++ GC
    for j=0:b;

        if j <= floor(b*rho);
           set_ran_pp_pjm=1;
        else
           set_ran_pp_pjm=0;
        end

        sum_mj_rp=0;

        for l=1:floor(b*rho);
           sum_mj_rp=sum_mj_rp+m(l+1);
        end

        p_m(j+1) = (m(j+1) * set_ran_pp_pjm) / sum_mj_rp;
    end
end

%drift
%fN(m)=sigma i/=i' (m(i) * PiiNm * (e_i' - e_i)
%for i=1:b;
%end

%fb(m)=(1-p_b(m))-(sigma j=1~b (p_(b-j)(m)j)*((b*m_b)/(b*rho))


%sigma j=1~b (p_(b-j)(m)j
for j=1:b;
    %sum_fb=0;
    %p(b-j);
    sum_fb(j) = (p_m(b-j+1)*j);
end
f_m(b) = (1-p_m(b))-(sum(sum_fb))*((b*m(b))/(b*rho));

%fi(m)=(((i+1)m_(i+1)-i*m(i))/(b*rho)) * (sigma j=1~b (p_(b-j)(m)j) - p_i(m)


%sigma j=1~b (p_(b-j)(m)j
for i=0:b-1;
    for j=1:b;
        %sum_fi=0;
        %p(b-j);
        sum_fi(j) = + (p_m(b-j+1)*j);
    end
    %m(i); probability of blocks contain i valid pages
    f_m(i+1) = (((i+1)*m(i+1+1)-i*m(i+1))/(b*rho)) * (sum(sum_fi)) - p_m(i+1);
end



%equation (3)
%P_i,i'^N(m)
%P_iiNm= P[XnN(t+1)=i'|XnN(t)=i,MNt=m]
%P_iiNm= (p_i(m)/(m(i)*N)) * B0(b-i, i/b rho N) 1[i'=b]
%        +1[i'=i-1][sigma j=1~b(p_(b-j)(m)*B1(j,i/b rho N))
%            +p_i(m)(1-(1/(m(i)*N))) B1(b-i,i/b rho N)] + o(1/N);
%i'=>i_.

for i=0:b; 
    %for i_=0:b;
        %if i_==b;
        i_=b;

            %B0(b-i, i/b rho N)    
            p_bi = i/(b*rho*N);
            n_bi = b-i;
            j_bi = 0;
            bino0 = factorial(n_bi)/(factorial(j_bi) * factorial(n_bi-j_bi)) * p_bi^j_bi * (1-p_bi)^(n_bi-j_bi);

            P_iiNM(i+1,2) = (p_m(i+1) / (m(i+1)*N)) * bino0;

        
        %elseif i_== i-1;
    if i~=0;
        i_=i-1;
            clear sum_iiN;
            %[sigma j=1~b(p_(b-j)(m)*B1(j,i/b rho N))+p_i(m)(1-(1/(m(i)*N)) B1(b-i,i/b rho N)]           
            for j=1:b;
                if j~=b-i;
                    %B1(j,i/b rho N)
                    p_bi = i/(b*rho*N);
                    n_bi = j;
                    j_bi = 1;
                    bino1(j) = factorial(n_bi)/(factorial(j_bi) * factorial(n_bi-j_bi)) * p_bi^j_bi * (1-p_bi)^(n_bi-j_bi);

                    sum_iiN(j) = p_m(b-j+1) * bino1(j);
                end
            end

            %B1(b-i,i/b rho N)
            p_bi = i/(b*rho*N);
            n_bi = b-i;
            j_bi = 1;
            
            if n_bi-j_bi >= 0;
                bino2(i_+1) = factorial(n_bi)/(factorial(j_bi) * factorial(n_bi-j_bi)) * p_bi^j_bi * (1-p_bi)^(n_bi-j_bi);
            else
                bino2(i_+1) = factorial(n_bi)/(factorial(j_bi) * factorial(0)) * p_bi^j_bi * (1-p_bi)^(n_bi-j_bi);
            end
                
            P_iiNM(i+1,1) = sum(sum_iiN) + p_m(i+1)*(1-(1/(m(i+1)*N))) * bino2(i_+1);
    end
        %end
    %end
 end
    
    
%ODE
%d-choice

%random
%A=b/(b-sigma i=0~b i mu i) = 1/1-rho


%random++

