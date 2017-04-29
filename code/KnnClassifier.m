function accuracy=KnnClassifier(faceM,k)

tic;
if nargin==2
    EigVec=PCA(faceM,k);
end

[~,~,NumberSubjects]=size(faceM);
counter=0;
for i=48:3:147
        a=faceM(:,:,i);
        if nargin==1
           b=KnnClassifierModel(faceM, a);
        else
           b=KnnClassifierModel(faceM, a,EigVec);
        end
       if b==1
         counter=counter+1;
       end
end
accuracy=counter/(99/3);
toc;
end
