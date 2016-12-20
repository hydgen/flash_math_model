%mean field by Benny
clear;

N %N of blocks
U %N of user-visible block
b %N of pages of each block
rho = U/N;

A = b/(b- X);
%X=sigma j=0~b (j*p_j);

%MNt= sigma i=0~b (MiNt*ei);
%e(i)=i-th unit vector
for i=0:b;
    %sum0(i)=0;
    sum0(i) = MiNt(i) * e(i);   
end

%X_n^N(t)임시값
for n=1:N;
    XnN(n)=randi(N);
end

%MiNt= (1/N) * sigma n=1~N (1 [XnN(t)=i]), i=0~b;
for i=1:b;
    sum1(i)=0;

    for n=1:N;
        if XnN(n)==i; %X_n^N(t): the numver of valid pages on blocknumber n at time t
            sum1(i) = 1;
        end
    end
end
MiNt(i) = (1/N) * sum(sum1);


%P_iiNm= P[XnN(t+1)=i'|XnN(t)=i,MNt=m]
%P_iiNm= (p_i(m)/(m(i)*N)) * B0(b-i, i/b rho N) 1[i'=b]
%        +1[i'=i-1][sigma j=1~b(p_(b-j)(m)*B1(j,i/b rho N))
%            +p_i(m)(1-(1/(m(i)*N))) B1(b-i,i/b rho N)] + o(1/N);
%i와 i' 변수 이름 수정하기

if i'==b;

    %B0(b-i, i/b rho N)    
    p_bi = i/(b*rho*N);
    n_bi = b-i;
    j_bi = 0;
    bino0 = (factorial(n_bi)/(factorial(j_bi)) * factorial(n_bi-j_bi))) * p_bi^j_bi * (1-p_bi)^(n_bi-j_bi);
    
    P_iiNM = (pm(i) / (m(i)*N)) * bino0;
    
elseif i'==i-1;

    %[sigma j=1~b(p_(b-j)(m)*B1(j,i/b rho N))+p_i(m)(1-(1/(m(i)*N)) B1(b-i,i/b rho N)]           
    for j=1:b;
        if j==b-i;
            %B1(j,i/b rho N)
            p_bi = i/(b*rho*N);
            n_bi = j;
            j_bi = 1;
            bino1 = (factorial(n_bi)/(factorial(j_bi)) * factorial(n_bi-j_bi))) * p_bi^j_bi * (1-p_bi)^(n_bi-j_bi);

            sum_iiN(j) = pm(b-j) * bino1;
        end
    end
    
    %B1(b-i,i/b rho N)
    p_bi = i/(b*rho*N);
    n_bi = b-i;
    j_bi = 1;
    bino2 = (factorial(n_bi)/(factorial(j_bi)) * factorial(n_bi-j_bi))) * p_bi^j_bi * (1-p_bi)^(n_bi-j_bi);
   
    P_iiNM = sum(sum_iiN) + pm(i)*(1-(1/(m(i)*N))) * bino2;
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
    sum_fb(j) = (p(b-j)*m*j);
end
fb(m) = (1-p_b(m))-(sum(sum_fb))*((b*m_b)/(b*rho));

%fi(m)=(((i+1)m_(i+1)-i*m(i))/(b*rho)) * (sigma j=1~b (p_(b-j)(m)j) - p_i(m)

%sigma j=1~b (p_(b-j)(m)j
for j=1:b;
    %sum_fi=0;
    %p(b-j);
    sum_fi(j) = + (p(b-j)*m*j);
end
%m(i); probability of blocks contain i valid pages
fi(m) = (((i+1)*m(i+1)-i*m(i))/(b*rho)) * (sum(sum_fi)) - p_i(m);


%m_i; -> m(i); the fraction of blocks containing exactly i valid pages
%추후 수정이 필요함.

while sum(m)~=1;
    for i=1:b;
       m(i)=1/b; 
    end
end


%아래는 GC 정책에 따른 p_i(m) {pm(i)} 값 계산식
%d-choice
%p_j_m=(sigma l=j~b (m_l))^d - (sigma l=j+1~b (m_l))^d;
sum_mj_d1=0;
sum_mj_d2=0;
for l=j:b;
    sum_mj_d1=sum_mj_d1+m(l);
end
for l=j+1:b;
    sum_mj_d2=sum_mj_d2+m(l);
end
p_j_m = sum_mj_d1^d - sum_mj_d2^d

%random (p_j(m)=m_j)
p_j_m = m(j);
%fb(m) = (1-m_b)-( ((1-rho)/rho)*b*m_b );
%fi(m) = ((1-rho)/rho) * ((i+1)*m_(i+1)-i*m(i)) - m(i);

%random++
if j <= floor(b*rho);
   set_ran_pp_pjm=1;
else
   set_ran_pp_pjm=0;
end

sum_mj_rp=0;
for l=0:floor(b*rho);
   sum_mj_rp=sum_mj_rp+m(l);
end

p_j_m = (m(j) * set_ran_pp_pjm) / sum_mj_rp;



%ODE
%d-choice
%random
%random++
