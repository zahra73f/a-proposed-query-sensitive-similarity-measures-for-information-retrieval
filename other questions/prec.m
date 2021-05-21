function [ precion_lsi ] = prec( v_k,w,test,data_query,num_test)
%PREC Summary of this function goes here
%   Detailed explanation goes here
for h=1:1400
           zarb=test.*v_k(:,h).*w; 
           %s_d=norm(v_k(:,h));
           sim_lsi_test(1,h)=sum(zarb);
         
end         
     x=[];
     bb=[];
     aa=[];
     relevent=[];
     
     [bb aa]=sort(sim_lsi_test(1,:),'descend');
     [x,y]=find(data_query(:,1)==num_test);
     relevent=data_query(x,2);
     num_relevent=length(relevent);
    
     ind=[];
     r=10;
     ind=find(ismember(aa(1,1:r),relevent));
     retrive_relevent=length(ind);
     precion_lsi=retrive_relevent/r;

end

