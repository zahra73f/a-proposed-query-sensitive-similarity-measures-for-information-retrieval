
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
      
        