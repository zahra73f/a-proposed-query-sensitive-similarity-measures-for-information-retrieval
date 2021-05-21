
data_query=load('cranqrel');
q=data_query(:,1);
q_uniqe=unique(q);
for i=1:size(q_uniqe,1)
    c=find(ismember(q,q_uniqe(i)));
    most(i,1)=length(c);
end
[a b]=sort(most,'descend');
query=q_uniqe(b(:,1));
%load query
fid = fopen('cran.qry');
qqq=textscan(fid, '%s', 'delimiter', ' ');
fclose(fid);
qqq=qqq{1,1};
arr=zeros(225,3);
for j=1:225
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
arr1=zeros(225,3);
for j=1:11
x=query(j);
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
for i=2:225
   
s2=num2str(arr(i,:));
s2= s2(~isspace(s2));
numb=[numb;s2];
end
cn=find(ismember(lower(qqq),lower(numb)));
query_concept={};
h=1;
while (h<11)
for i=1:225
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
end
 
%%prerocess query
for t=1:10
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
for i=1:10
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
term= size(uniq_stem,1);
term_query_tf=zeros(term,10);
% term_query_idf=zeros(term,1);

%  counter = find(ismember(lower(test2),lower(a)))
for i=1:term
    a=uniq_stem{i};
%     df=0;
    
    for j=1:10
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
  weight_query=zeros(4300,10);
for j=1:10
    weight_query(:,j)=term_doc_idf(:,1).*term_query_tf(:,j);
end      
      
 %%% comput similarity
 for i=1:10
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










    