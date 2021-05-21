data_query=load('cranqrel');
q=data_query(:,1);
q_uniqe=unique(q);
rank=[100,200];
for fi=1:2
    
    
    
 for i=1:225
     term_doc_tf=[]
    term_doc_idf=[];
    weight_n=[];
    weight_query_n=[];
    term_query_tf=[];
     neiber1=[];
     neiber2=[];
     neiber3=[];
     neiber4=[];
     neiber5=[];
     sim_doc1=[];
     sim_doc2=[];
     sim_doc3=[];
     sim_doc4=[]
     sim_doc5=[];
     relevent_query=[];
     
     
     
     x=[];
     bb=[];
     index=[];
     relevent=[];
     
     [bb index]=sort(sim(i,:),'descend');
     doc_sim(i,1:rank(1,fi))=index(1,1:rank(1,fi));
     for j=1:rank(1,fi)
         doctemp=doc{1,index(j)};
         new_doc{1,j}=doctemp;
     end
     
         
  [term uniq_stem1]=vocab(index(1,1:rank(1,fi)),rank(1,fi));   
%   term= size(uniq_stem,1);
[weight_n ,weight_query_n ] = weight_all( term,uniq_stem1,rank(1,fi),new_doc,query_stem );
 %%%find relevent in retrived
  c=[];
  c=find(ismember(q,i));
  relevent_query=data_query(c,2);
  docc=doc_sim(i,1:rank(1,fi));
  exist_relevent=find(ismember(docc,relevent_query));
  find_relevent=docc(1,exist_relevent);
  n_relevent=length(find_relevent);
  %%%formol 1
  sim_doc1=[];
  sim_doc2=[];
  sim_doc3=[];
  sim_doc4=[];
  neiber1=zeros(n_relevent,5);
  sq=[];
  cc=[];
  a=[];
  for rel=1:n_relevent
       a=weight_n(:,exist_relevent(1,rel));
       s_d1=norm(a);
       sq=weight_query_n(:,i);
       s_q=norm(sq);
        mm=0;
        kk=0;
      for nn=1:rank(1,fi)
         
       if (nn~=exist_relevent(1,rel))
           %%cos formol 1
         zarb=a'*weight_n(:,nn);
         s_d=norm(weight_n(:,nn));
         mm=mm+1;
         sim_doc1(rel,mm)=zarb/(s_d1*s_d); 
         %% fomol 2
         for gg=1:term
             if (weight_n(gg,nn)~=0 & (weight_n(gg,exist_relevent(1,rel)))~=0)
               cc(gg,1)=(weight_n(gg,nn)+weight_n(gg,exist_relevent(1,rel)))/2;
             else
               cc(gg,1)=0;
             end
         end
         kk=kk+1;
         sim_doc2(rel,kk)= cosinos(cc,sq);
         sim_doc3(rel,kk)= cosinos(a,weight_n(:,nn))*cosinos(cc,sq);
         sim_doc5(rel,kk)= (1/3)*(cosinos(a,weight_n(:,nn))+cosinos(a,sq)+cosinos(weight_n(:,nn),sq));
         sim_doc4(rel,kk)= 0.5*cosinos(a,weight_n(:,nn)) +(0.5*cosinos(cc,sq));
       end
       
      
      end
  yyy=1
  [bb ind1]=sort(sim_doc1(rel,:),'descend');
  neiber1(rel,:)=ind1(1,1:5);
  %%2
  [bb ind2]=sort(sim_doc2(rel,:),'descend');
  neiber2(rel,:)=ind2(1,1:5);
  %%3
  [bb ind3]=sort(sim_doc3(rel,:),'descend');
  neiber3(rel,:)=ind3(1,1:5);
  %%5
  [bb ind5]=sort(sim_doc5(rel,:),'descend');
  neiber5(rel,:)=ind5(1,1:5);
  %%4
  [bb ind4]=sort(sim_doc4(rel,:),'descend');
  neiber4(rel,:)=ind4(1,1:5);
  
  end
  rr=find(ismember(neiber1,relevent_query));
  bbb=length(rr);
   n_rr(i,fi)=bbb;
  num_q1(i,fi)=bbb/n_relevent;
  %%2
  rr2=find(ismember(neiber2,relevent_query));
  bbb2=length(rr2);
   n_rr2(i,fi)=bbb2;
  num_q2(i,fi)=bbb2/n_relevent;
  %%3
  rr3=find(ismember(neiber3,relevent_query));
  bbb3=length(rr3);
    n_rr3(i,fi)=bbb3;
  num_q3(i,fi)=bbb3/n_relevent;
  %%5
  rr5=find(ismember(neiber3,relevent_query));
  bbb5=length(rr5);
  n_rr5(i,fi)=bbb5;
  num_q5(i,fi)=bbb5/n_relevent;
  %%
  rr4=find(ismember(neiber4,relevent_query));
  bbb4=length(rr4);
  n_rr4(i,fi)=bbb4;
  num_q4(i,fi)=bbb4/n_relevent;
 
 
 
 
 v=1
    
end
 %%%reweighting
end
 