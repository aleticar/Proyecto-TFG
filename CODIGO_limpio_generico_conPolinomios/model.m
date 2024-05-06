function f=model(X,Y,orden)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[dim1,dim2]=size(X);
%%%%%%%%%%%%%%%%%%%%
Xaux=X;
X=[ones(dim1,1)];
for i=1:orden   
 X=[X Xaux.^i];
end
%a=inv(X'*X)*X'*Y;
a=X\Y;
f=X*a;
