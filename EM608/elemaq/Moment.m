function M = Moment(F,L,pos)
    n = 1000;
    x = linspace(0,L,n+1);
    percent = pos/L;
    x1 =[zeros(1,n*percent-1) (x(percent*n:n+1)-x(percent*n))];
    M = -F*x1+F*(1-percent)*x;

end

