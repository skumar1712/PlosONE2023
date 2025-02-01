clear ;

cd C:\Users\sandeep.kumar\Desktop\MATLAB\Case4\X0\
ii = 1 ; 
timespan = [0.0, 10] ;
for j = 1 : 101
    T = readtable(['Case1X0t0.' num2str(j-1, '%02d') '.csv'],'NumHeaderLines',3);
    T1 = table2array(T) ;
    U = T1(:,2:4) ;
    X = T1(:,5:7) ;
    n = length(X(:,1)) ;
    ind = (ii-1)*n+1:ii*n ;
    X1all(ind,1) = X(:,1); 
    X2all(ind,1) = X(:,2); 
    X3all(ind,1) = X(:,3); 
    
    U1all(ind,1) = U(:,1); 
    U2all(ind,1) = U(:,2); 
    U3all(ind,1) = U(:,3); 
     
    ii = ii + 1 ;
end  

time = sort(repmat((timespan(1) : 0.1 : timespan(end)).',[n,1])) ;

myfile = 'VarCase1PlaneX0_t10.mat' ;
% save(myfile, 'U', 'X', 'U1all', 'U2all', 'U3all', 'X1all', 'X2all', 'X3all', 'y', 'z', 'u2q', 'u3q') ;
save(myfile, 'U1all', 'U2all', 'U3all', 'X1all', 'X2all', 'X3all', 'time') ;

% myfile = 'test.mat' ;
% save(myfile, 'U2all', 'U3all', 'X2all', 'X3all') ;
