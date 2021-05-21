for i=1:4300
    fer(i)=sum(ttt(i,:));
end
 fer=sort(fer,'descend');
s=0;

sum1=0;
i=1;
nnn=floor(n/2);
while (sum1<nnn)
    
    sum1=sum1+fer(1,i);
    i=i+1;
end
    
    