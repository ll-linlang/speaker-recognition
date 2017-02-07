%----------------------------------identify speaker-------------------------
%Ashok Sharma Paudel, Deepesh Lekhak, Keshav Bashayal, Sushma shrestha
%--------------------------------------------------------------------------

function [d]=identSpeaker(x,c,t)
[d, f]=size(x);
   sumt=zeros(t,d); 
for i=1:t
    j=int2str(i);
    s=['gmm/',j,'.mat'];
o=load(s);
m=o.m;
v=o.v;
w=o.w;




log_lp = zeros(d,c); % for storing log(p(x|j)*p(j))
 
    
for n=1:d
    for k=1:c
        log_lp(n,k) = log( mvnpdf(x(n,:), m(k,:), v(:,:,k)) );
        log_lp(n,k) = log_lp(n,k) + log( w(1, k) );
    end
end
 
sumt(i,:) = logsumexp(log_lp,2);
end


sss=zeros(1,t);
for i=1:t
    sss(1,i)=sum(sumt(i,:));
    
end
[maxv, maxl]=max(sss);


 
if abs(maxv)<10000
  d='imposter';
else 


h=int2str(maxl);
 s=['gmm/',h,'.txt'];
 fid=fopen(s,'r');
 q=fread(fid,'*char');
 q=q';
 
fclose(fid);
d=q;

end



    
 
