[u sigma v]=svd(weight);
k=100;

u_k=u(:,1:k);
sigma_k=sigma(1:k,1:k);
v_k=v(1:k,:);

%%query
new_matrix_query=zeros(k,10);
for i=1:225
    qu=weight_query(:,i);
    new_query=qu'*u_k*inv(sigma_k);
    new_matrix_query(:,i)=new_query;
end
%%% comput similarity
 for i=1:225
     a=new_matrix_query(:,i);
     s_q=norm(a);
     for j=1:1400
         zarb=a'*v_k(:,j);
         s_d=norm(v_k(:,j));
         sim_lsi(i,j)=zarb/(s_q*s_d);
     end
 end
 precion_lsi=[];
 recall_lsi=[];
 F_measer=[];
 %%% p_recall
 rank=[10,50,100,500];
 for i=1:225
     x=[];
     bb=[];
     aa=[];
     relevent=[];
     
     [bb aa]=sort(sim_lsi(i,:),'descend');
     [x,y]=find(data_query(:,1)==i);
     relevent=data_query(x,2);
     num_relevent=length(relevent);
     for j=1:1
     ind=[];
     r=rank(j);
     ind=find(ismember(aa(1,1:r),relevent));
     retrive_relevent=length(ind);
     precion_lsi(i,j)=retrive_relevent/r;
     recall_lsi(i,j)=retrive_relevent/num_relevent;
     F_measer(i,j)=(2*(precion_lsi(i,j)*recall_lsi(i,j)))/(recall_lsi(i,j)+precion_lsi(i,j));
     end
 end
     


F_measer(isnan(F_measer)) = 0;



for i=1:1
    avg_precion_lsi(i)=(sum(precion_lsi(:,i)))/225;
    avg_recall_lsi(i)=(sum(recall_lsi(:,i)))/225;
    avg_f(i)=(sum(F_measer(:,i)))/10;
end

