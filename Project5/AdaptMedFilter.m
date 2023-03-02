function A=AdaptMedFilter(X)
    zmin=min(X,[],'all');
    zmax=max(X,[],'all');
    zmed=median(X,'all');
    zxy=X(ceil(length(X)/2),ceil(length(X)/2));
    if zmed==zmin || zmed==zmax
        if length(X)==7
            A=zmed;
        else
            A=-99;
        end
    else
        if zmed==zmin || zmed==zmax
            A=zmed;
        else
            A=zxy;
        end
    end

end