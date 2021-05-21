fid = fopen('cranfield1400');
%  doc=cell(756,1400);
test_total=textscan(fid, '%s', 'delimiter', ' ');
fclose(fid);
test_total=test_total{1,1};
pat = '<[^>]*>';
% ss={'m.','+','.','1','2','3','4','5','6','7','8','9','0'};
%     remain = str{1}
   
   stop=importdata('stopwords.txt');
%    stop = {'if',' ','and','else',',','however','dvd','the','i','u','but','am','is','r','are','was','were','am','have','has','do','she','he','.',':',';','(',')','"','0','1','2','3','4','5','6','7','8','9','/','txt','music','book','books','camera','health','cd','the','it','they','it','these','that','those','there','this','can','could','be','would','they','on','in','one','of','at','two','to','three','four','five','six','seven','eight','nine','ten','which','what','where','when','!','@','#','$','%','&','*','me','us','ur','yours','her','him','them','its','still','yet','a','an','why','please','oh','god','or','on','of','and','so','then','also','hi','bye','by','how','be','being','with','other','mine','my','do','does','not','our','as','wont','nothing','?','.','all','none','before','after','you','s','for','because','cause','will','did','didnt','now','till','from','since','yet','still','...','??','!!','!!!','had','been'};
counter = find(ismember(lower(test_total),lower(stop)));
test_total(counter) = [];
test_total=regexprep(test_total, pat, '#');

stop1=['*',')','(',',','/','\','?','-','=','$','''','.','_','[',']','#','&','+',' ','','1','2','3','4','5','6','7','8','9','0'];

for j=1:length(stop1)
    IndexC=strfind(test_total,stop1(j));
    Index=find(not(cellfun('isempty', IndexC)));
    test_total(Index) =[];
end
siz=size(test_total,1)
doc{1400}=test_total;
arr=zeros(1400,4);
for j=1:1400
x=j;
xstr=num2str(x);
xarray=zeros(1,4);
if numel(xstr)==1
    s1='000';
     xstr1 =strcat(s1,xstr) ;
end
if numel(xstr)==2
    s1='00';
     xstr1 =strcat(s1,xstr) ;
end 
 if numel(xstr)==3
    s1='0';
     xstr1 =strcat(s1,xstr) ;
 end
 if numel(xstr)==4
    xstr1=xstr;
 end
 
  for i=1:4
    
      xarray(i)=str2num(xstr1(i));
      
    
  end
  arr(j,:)=xarray;
end
 s1='cranfield';
for i=1:1399
   
s2=num2str(arr(i,:));
 s2= s2(~isspace(s2))
s = strcat(s1,s2);
% cc{i}=readtable(s);






fid = fopen(s);
test=textscan(fid, '%s', 'delimiter', ' ');
fclose(fid);
test=test{1,1};
pat = '<[^>]*>';
% ss={'m.','+','.','1','2','3','4','5','6','7','8','9','0'};
%     remain = str{1}
   
   
test=regexprep(test, pat, '#');

stop1=['*',')','(',',','/','\','?','-','=','$','''','.','_','[',']','#','&','+',' ','','1','2','3','4','5','6','7','8','9','0'];

for j=1:length(stop1)
    IndexC=strfind(test,stop1(j));
    Index=find(not(cellfun('isempty', IndexC)));
    test(Index) =[];
end
stop=importdata('stopwords.txt');
%    stop = {'if',' ','and','else',',','however','dvd','the','i','u','but','am','is','r','are','was','were','am','have','has','do','she','he','.',':',';','(',')','"','0','1','2','3','4','5','6','7','8','9','/','txt','music','book','books','camera','health','cd','the','it','they','it','these','that','those','there','this','can','could','be','would','they','on','in','one','of','at','two','to','three','four','five','six','seven','eight','nine','ten','which','what','where','when','!','@','#','$','%','&','*','me','us','ur','yours','her','him','them','its','still','yet','a','an','why','please','oh','god','or','on','of','and','so','then','also','hi','bye','by','how','be','being','with','other','mine','my','do','does','not','our','as','wont','nothing','?','.','all','none','before','after','you','s','for','because','cause','will','did','didnt','now','till','from','since','yet','still','...','??','!!','!!!','had','been'};
counter = find(ismember(lower(test),lower(stop)));
test(counter) = [];

test_total=[test_total;test];
siz=size(test,1);
doc{i}=test;
% doc(:,i)=test;
end
%%%% stem
test_total = test_total(~cellfun('isempty',test_total));
n=size(test_total,1)
for i=1:n
    stem{i,1}=porterStemmer(test_total{i});
end
for i=1:1400
    test2={};
    test2=doc{1,i};
    test2 = test2(~cellfun('isempty',test2));
    nn=size(test2,1);
    doc11={};
    for j=1:nn
     doc11{j,1} =  porterStemmer(test2{j});
    end
    doc{i}=doc11;
end
% %% vector space model
% dic=unique(stem);
% term= size(uniqe_stem,1);
% term_doc_tf=zeros(term,1400);
% term_doc_idf=zeros(term,1400);
% for i=1:term
%     for j=1:1400
%     a=dic(i);
%     stopi={a};
%     sumipos(i)=sum(ismember (posword,dic(i)));
%     sumineg(i)=sum(ismember (negword,dic(i)));
%     end
% end
% 
% cn=find(ismember(lower(test),lower(stop2)))

uniq_stem=unique(stem);

% dic=unique(stem);
term= size(uniq_stem,1);





%  a={'wing'};
% test2=doc{1,1};
% uniq_stem=unique(stem);

% dic=unique(stem);
term= size(uniq_stem,1);
term_doc_tf=zeros(term,1400);
term_doc_idf=zeros(term,1);

%  counter = find(ismember(lower(test2),lower(a)))
for i=1:term
    a=uniq_stem{i};
    df=0;
    
    for j=1:1400
        mostComm=[];
        counter_m=[];
        normal=[];
        counter=[];
        f=0;
        test2=doc{1,j};
        test2 = test2(~cellfun('isempty',test2));
        [unique_strings, ~, string_map] = unique(test2);
        mostComm = unique_strings(mode(string_map)); 
        counter_m = find(ismember(lower(test2),lower(mostComm)));
        normal=length(counter_m);
        counter = find(ismember(lower(test2),lower(a)));
        
        f=length(counter);
        
        ttt(i,j)=f;
        term_doc_tf(i,j)=f/normal;
        if (~isempty(counter))
            df=df+1;
        end
    end
    term_doc_idf(i)=log2(1400/df);
    dd(i)=df;
end
  weight=zeros(4300,1400);
for j=1:1400
    weight(:,j)=term_doc_idf(:,1).*term_doc_tf(:,j);
end      
      
        




% data_query=load('cranqrel');
% q=data_query(:,1);
% q_uniqe=unique(q);
% for i=1:size(q_uniqe,1)
%     c=find(ismember(q,q_uniqe(i)));
%     most(i,1)=length(c);
% end
% [a b]=sort(most,'descend');
% query=q_uniqe(b(:,1));
% %load query
fid = fopen('cran.qry');
qqq=textscan(fid, '%s', 'delimiter', ' ');
fclose(fid);
qqq=qqq{1,1};
arr=zeros(225,3);
for j=1:365
x=j;
xstr=num2str(x);
xarray=zeros(1,3);
if numel(xstr)==1
    s1='00';
     xstr1 =strcat(s1,xstr) ;
end
if numel(xstr)==2
    s1='0';
     xstr1 =strcat(s1,xstr) ;
end 
 if numel(xstr)==3
     xstr1=xstr;
 end
 
 
  for i=1:3
    
      xarray(i)=str2num(xstr1(i));
      
    
  end
  arr(j,:)=xarray;
end
arr1=zeros(365,3);
for j=1:365
x=j;
xstr=num2str(x);
xarray1=zeros(1,3);
if numel(xstr)==1
    s1='00';
     xstr1 =strcat(s1,xstr) ;
end
if numel(xstr)==2
    s1='0';
     xstr1 =strcat(s1,xstr) ;
end 
 if numel(xstr)==3
     xstr1=xstr;
 end
 
 
  for i=1:3
    
      
      xarray1(i)=str2num(xstr1(i));
      
    
  end
  arr1(j,:)=xarray1;
end







 numb={'001'};
for i=2:365
   
s2=num2str(arr(i,:));
s2= s2(~isspace(s2));
numb=[numb;s2];
end
cn=find(ismember(lower(qqq),lower(numb)));
query_concept={};
 h=1;
% while (h<11)
for i=1:365
    j=1;

    while (j<length(cn))
     ss2=num2str(arr1(i,:));
     ss2= ss2(~isspace(ss2)); 
    if(strcmpi(qqq(cn(j)),ss2))
        if (~isempty(qqq(cn(j)+1:cn(j+1)-1)))
        query_concept{h}=qqq(cn(j)+1:cn(j+1)-1);
        h=h+1;
        end
    
    end
    j=j+1;
    end
end
query_concept{h}=qqq(cn(j)+1:end);
% end
 
%%prerocess query
for t=1:225
    test={};
    test=query_concept{1,t};
    pat = '<[^>]*>';
% ss={'m.','+','.','1','2','3','4','5','6','7','8','9','0'};
%     remain = str{1}
   
   
     test=regexprep(test, pat, '#');

     stop1=['*',')','(',',','/','\','?','-','=','$','''','.','_','[',']','#','&','+',' ','','1','2','3','4','5','6','7','8','9','0'];

for j=1:length(stop1)
    IndexC=strfind(test,stop1(j));
    Index=find(not(cellfun('isempty', IndexC)));
    test(Index) =[];
end
stop=importdata('stopwq.txt');
%    stop = {'if',' ','and','else',',','however','dvd','the','i','u','but','am','is','r','are','was','were','am','have','has','do','she','he','.',':',';','(',')','"','0','1','2','3','4','5','6','7','8','9','/','txt','music','book','books','camera','health','cd','the','it','they','it','these','that','those','there','this','can','could','be','would','they','on','in','one','of','at','two','to','three','four','five','six','seven','eight','nine','ten','which','what','where','when','!','@','#','$','%','&','*','me','us','ur','yours','her','him','them','its','still','yet','a','an','why','please','oh','god','or','on','of','and','so','then','also','hi','bye','by','how','be','being','with','other','mine','my','do','does','not','our','as','wont','nothing','?','.','all','none','before','after','you','s','for','because','cause','will','did','didnt','now','till','from','since','yet','still','...','??','!!','!!!','had','been'};
counter = find(ismember(lower(test),lower(stop)));
test(counter) = [];

% test_total=[test_total;test];
siz=size(test,1);
query_p{t}=test;
% doc(:,i)=test;
end
%%%% stem
% test_total = test_total(~cellfun('isempty',test_total));
% n=size(test_total,1)
% for i=1:n
%     stem{i,1}=porterStemmer(test_total{i});
% end
for i=1:225
    test2=query_p{1,i};
    test2 = test2(~cellfun('isempty',test2));
    nn=size(test2,1);
    qwr={};
    for j=1:nn
     qwr{j,1} =  porterStemmer(test2{j});
    end
    query_stem{1,i}=qwr;
end
%%%% tf_idf for query 
%term= size(uniq_stem,1);
term=4300;
term_query_tf=zeros(term,225);
% term_query_idf=zeros(term,1);

%  counter = find(ismember(lower(test2),lower(a)))
for i=1:term
    a=uniq_stem{i};
%     df=0;
    
    for j=1:225
        mostComm=[];
        counter_m=[];
        normal=[];
        counter=[];
        f=0;
        test2=query_stem{1,j};
        test2 = test2(~cellfun('isempty',test2));
        [unique_strings, ~, string_map] = unique(test2);
        mostComm = unique_strings(mode(string_map)); 
        counter_m = find(ismember(lower(test2),lower(mostComm)));
        normal=length(counter_m);
        counter = find(ismember(lower(test2),lower(a)));
        
        f=length(counter);
        
        ttt_query(i,j)=f;
        term_query_tf(i,j)=f/normal;
%         if (~isempty(counter))
%             df=df+1;
%         end
    end
%     term_doc_idf(i)=log2(1400/df);
%     dd(i)=df;
end
  weight_query=zeros(4300,225);
for j=1:225
    weight_query(:,j)=term_doc_idf(:,1).*term_query_tf(:,j);
end      
      
 %%% comput similarity
 for i=1:225
     a=weight_query(:,i);
     s_q=norm(a);
     for j=1:1400
         zarb=a'*weight(:,j);
         s_d=norm(weight(:,j));
         sim(i,j)=zarb/(s_q*s_d);
     end
 end
%  rank=[10,50,100,500];
%  for i=1:10
%      x=[];
%      bb=[];
%      aa=[];
%      [bb aa]=sort(sim(i,:));
%      [x,y]=find(data_query(:,1)==i);
%      relevent=data_query(x,2);
%      for j=1:4
%      r=rank(j);
%      ind=find(ismember(bb(1,1:r),relevent));
%      retrive_relevent=lenght(ind);
%      num_relevent=length(relevent);
%      precion(i,j)=retrive_relevent/r;
%      recall(i,j)=retrive_relevent/num_relevent;
%      end
%  end
%      
%      
%          
% 
%     
% 










    data_query=load('cranqrel');
q=data_query(:,1);
q_uniqe=unique(q);
rank=[400];
for fi=1:1
    
    
    
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
  rr5=find(ismember(neiber5,relevent_query));
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
 