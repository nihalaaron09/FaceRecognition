function ReOrdered=LDA(face,k)
[~,~,N]=size(face);
testFace=face(:,:,1);
testFace=reshape(testFace, [],1);
[rows, cols]=size(testFace);
faceT=zeros(rows,cols,N);
% faceM=zeros(k,1,N);

for i=1:N
faceT(:,:,i)=reshape(face(:,:,i), [], 1);
faceT(:,:,i)=imadjust(faceT(:,:,i),[],[0,1]);
end

%faceM=zeros(k,1,N);

   summ=zeros(rows,cols);
   ClassAvg=zeros(rows,cols,N/3);
  
  

for i=1:N
    if rem( i,3)~=0                    %% total mean
     
    %[rows,~]=size(aTemp);
    
    summ=summ+faceT(:,:,i);
    end
end
meanWhole=summ/(2*N/3);

for i=1:3:N                   % indivisual class means
        a1=faceT(:,:,i);
        a2=faceT(:,:,i+1);
        ClassAvg(:,:,(floor(i/3)+1))=(a1+a2)/2;  
end

%% Sw calculation
sW=zeros(rows,rows);

for i=1:3:N
    a1=faceT(:,:,i);
    a2=faceT(:,:,i+1);
    d1=a1-ClassAvg(:,:,(floor(i/3)+1));
    d2=a2-ClassAvg(:,:,(floor(i/3)+1));
    sW=sW+(d1*transpose(d1) + d2*transpose(d2));
end
%sW=sW/400;
sW=sW+eye(rows);
%% sB calculation

sB=zeros(rows,rows);

for i=1:N/3
    d=ClassAvg(:,:,i)-meanWhole;
    sB=sB + 2*(d*transpose(d));
end

    %sB=sB/200;
    
    w=(inv(sW))*sB;
    
    
    [Vec,Val]=eig(w);
    Val=real(Val);
    Vec=real(Vec);
    

diagonal=diag(Val);
diagonal=flipud(diagonal);
[~,index]=sort(diagonal);

ReOrdered=zeros(k,rows);
for i=1:k
    pos=index(i);
    ReOrdered(i,:)=Vec(pos,:);
end

end

        
        
        
      