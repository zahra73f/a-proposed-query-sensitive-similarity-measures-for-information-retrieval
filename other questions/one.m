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


