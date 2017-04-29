function ReOrdered=PCA(face,k)


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
   CovV=zeros(rows,rows);
   ZeroVal=zeros(rows,cols,N);

for i=1:N
    if rem( i,3)~=0
     
    %[rows,~]=size(aTemp);
    
    summ=summ+faceT(:,:,i);
    end
end

meanV=summ/(2*N/3);

for i=1:N
    if rem(i,3)~=0
        ZeroVal(:,:,i)=faceT(:,:,i)-meanV;
    end
end

for i=1:N
    if rem(i,3)~=0
        CovV=CovV+(ZeroVal(:,:,i)*transpose(ZeroVal(:,:,i)));
    end
end
CovV=CovV/(2*N/3);

[Vec,Val]=eig(CovV);

diagonal=diag(Val);
diagonal=flipud(diagonal);
[~,index]=sort(diagonal);

ReOrdered=zeros(k,rows);
for i=1:k
    pos=index(i);
    ReOrdered(i,:)=Vec(pos,:);
end


% for i=1:600
%         if rem(i,3)~=0 
%           faceM(:,:,i)=ReOrdered*faceT(:,:,i);
%         end
% end

    
end   % function





        

