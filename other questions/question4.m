indeces = randperm(n);
collection1 = stem(indeces(1:50000),1);
collection2 = stem(indeces(50000:83000),1);
n1=size(collection1,1);
n2=size(collection2,1);
vocab1=unique(collection1);
vocab2=unique(collection2);
v1=size(vocab1,1);
v2=size(vocab2,1);
syms x y
eqn1 = log(x)+y*log(n1) == log(v1);
eqn2 = log(x)+y*log(n2) == log(v2);
% solve(eqn, x)
% eqns = [sin(x)^2 == cos(y), 2*x == y];
sol = solve([eqn1,eqn2],x,y);
xSol = sol.x;
ySol = sol.y;
