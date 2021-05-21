rank=[10,50,100,500];
 for i=1:10
     x=[];
     bb=[];
     aa=[];
     relevent=[];
     
     [bb aa]=sort(sim(i,:),'descend');
     [x,y]=find(data_query(:,1)==i);
     relevent=data_query(x,2);
     num_relevent=length(relevent);
     for j=1:4
     ind=[];
     r=rank(j);
     ind=find(ismember(aa(1,1:r),relevent));
     retrive_relevent=length(ind);
     precion(i,j)=retrive_relevent/r;
     recall(i,j)=retrive_relevent/num_relevent;
     F_meas(i,j)=(2*(precion(i,j)*recall(i,j)))/(recall(i,j)+precion(i,j));
     end
 end
 F_meas(isnan(F_meas)) = 0;    




% rank=[10,50,100,500];
% 
%      x=[];
%      bb=[];
%      aa=[];
%      [bb aa]=sort(sim(1,:),'descend');
%      [x,y]=find(data_query(:,1)==3);
%      relevent=data_query(x,2);
%      for j=1:4
%      r=10;
%      ind=find(ismember(aa(1,1:100),relevent));
%      retrive_relevent=length(ind);
%      num_relevent=length(relevent);
%      precion(i,j)=retrive_relevent/r;
%      recall(i,j)=retrive_relevent/num_relevent;
%      end
% 
%      

for i=1:4
    avg_precion(i)=(sum(precion(:,i)))/10;
    avgfm(i)=(sum(F_meas(:,i)))/10;
    avg_recall(i)=(sum(recall(:,i)))/10;
end

for i=1:10
    avg_precion2(i)=(sum(precion(i,:)))/4;
end
    