function [weight_n ,weight_query_n ] = weight_all( term,uniq_stem,rank,new_doc,query_stem )
%WEIGHT_ALL Summary of this function goes here
%   Detailed explanation goes here
term_doc_tf=zeros(term,rank);
term_doc_idf=zeros(term,1);

%  counter = find(ismember(lower(test2),lower(a)))
for e=1:term
    a=uniq_stem{e};
    df=0;
    
    for q=1:rank
        mostComm=[];
        counter_m=[];
        normal=[];
        counter=[];
        f=0;
        test2=new_doc{1,q};
        test2 = test2(~cellfun('isempty',test2));
        [unique_strings, ~, string_map] = unique(test2);
        mostComm = unique_strings(mode(string_map)); 
        counter_m = find(ismember(lower(test2),lower(mostComm)));
        normal=length(counter_m);
        counter = find(ismember(lower(test2),lower(a)));
        
        f=length(counter);
        
        ttt(e,q)=f;
        term_doc_tf(e,q)=f/normal;
        if (~isempty(counter))
            df=df+1;
        end
    end
    term_doc_idf(e)=log2(rank/df);
    dd(e)=df;
end
weight_n=zeros(term,rank);
weight_query_n=zeros(term,225);
for m=1:rank
    weight_n(:,m)=term_doc_idf(:,1).*term_doc_tf(:,m);
end
for tti=1:term
    a=uniq_stem{tti};
%     df=0;
    
    for hhh=1:225
        mostComm=[];
        counter_m=[];
        normal=[];
        counter=[];
        f=0;
        test2=query_stem{1,hhh};
        test2 = test2(~cellfun('isempty',test2));
        [unique_strings, ~, string_map] = unique(test2);
        mostComm = unique_strings(mode(string_map)); 
        counter_m = find(ismember(lower(test2),lower(mostComm)));
        normal=length(counter_m);
        counter = find(ismember(lower(test2),lower(a)));
        
        f=length(counter);
        
        ttt_query(tti,hhh)=f;
        term_query_tf(tti,hhh)=f/normal;
%         if (~isempty(counter))
%             df=df+1;
%         end
    end
%     term_doc_idf(i)=log2(1400/df);
%     dd(i)=df;
end
  weight_query_n=zeros(term,225);
for hh=1:225
    weight_query_n(:,hh)=term_doc_idf(:,1).*term_query_tf(:,hh);
end   

end

