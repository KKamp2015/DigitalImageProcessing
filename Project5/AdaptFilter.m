function A=AdaptFilter(X)
    eta=100;
    ml=mean(X,'all');
    L=var(cast(X,'double'),0,"all")^2;
    g=X(ceil(length(X)/2),ceil(length(X)/2));
    A=g-(((eta/L)*g)-ml);
end
