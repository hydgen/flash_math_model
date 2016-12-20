alpha = t/u;
%rho = (t-u)/u;

LamA = lambertw(-alpha .* exp(-alpha));
%LamR = lambertw((-1-rho) .* exp(-1-rho));

A_eva = -alpha ./ (-alpha - LamA);
%A_evr = (-1-rho) ./ (-1-rho - LamR);

%Aev = Np/x