function  rk= ACF_k(x,k)
% Autocorrelation at Lag k
N=length(x);
cross_sum = zeros(N-k,1) ;
xbar=mean(x);
for i = 1:N-k
    cross_sum(i) = (x(i)-xbar)*(x(i+k)-xbar) ;
end

xvar = (x-xbar)*(x-xbar)' ;

rk = sum(cross_sum) / xvar ;