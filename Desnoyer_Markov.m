alpha = t/u;

%LamE = lambertw(-alpha .* exp(-alpha));

%A_mar_lru = alpha ./ (alpha + LamE);


LamX = lambertw(-(1+(1/(2*Np))) * alpha .*exp(-(1+(1/(2*Np))) * alpha));

X0 = (1/2) - (Np./alpha) .* LamX;

A_mar_greedy = Np ./ (Np - (X0 - 1));