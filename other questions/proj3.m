[u sigma v]=svd(weight);
k=100;

u_k=u(:,1:k);
sigma_k=sigma(1:k,1:k);
v_k=v(1:k,:);
w=rand(100,1);
w(1:100,1)=0.00001;
%%query1
new_matrix_query=zeros(k,10);
for i=1:225
    qu=weight_query(:,i);
    new_query=qu'*u_k*inv(sigma_k);
    new_matrix_query(:,i)=new_query;
end
beta=10;
for iter=1:20
    for i=1:225
        
        test= new_matrix_query(:,i);
        num_test=i;
        indexx=1:1:225;
        indexx(indexx==i)=[];
        train= new_matrix_query(:,indexx);
        for j=1:224
           a=new_matrix_query(:,j);
           s_q=norm(a);
         for h=1:1400
           zarb=a.*v_k(:,h).*w; 
          % s_d=norm(v_k(:,h));
           sim_lsi_w(j,h)=sum(zarb);
         
         end
         x=[];
     bb=[];
     aa=[];
     relevent=[];
     [bb aa]=sort(sim_lsi_w(j,:),'descend');
     [x,y]=find(data_query(:,1)==indexx(j,1));
     relevent=data_query(x,2);
     num_relevent=length(relevent);
     ind=find(ismember(aa(1,1:10),relevent));
     retrive_relevent=length(ind);
     index= aa(1,ind);
     d11=v_k(:,aa(1,11));
     for b=1:100
         mo_w=0;
        for kk=1:length(index)
          zarb1=a(b,1)*v_k(b,index(kk));
          zarb2=a(b,1)*d11(b,1);
          ma=a.*d11.*w;
          so=a.*v_k(:,index(kk)).*w;
          summ=(zarb1)-(zarb2);
          mo=summ/(sum(ma))^2;
          z=sum(so)/sum(ma);
          mo1=(beta*exp(beta*(1-z)))/(1+exp(beta*(1-z)));
          mo_total=mo*mo1;
          mo_w=mo_w+mo_total;
        end
        w(b,1)=w(b,1) + 0.1*mo_w;
     end
 end
    
    precion_lsi(i) = prec( v_k,w,test,data_query,num_test)  
end
    avg_prec(iter)=sum(precion_lsi)/225
    precion_lsi=[];
end
  
            
            
          
          
          
       








