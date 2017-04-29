%% FEATURE VECTOR EXTRACTION (LBP)
function [meanV, covV]=Mean_Cov_Bayes(faceM,EiganVec)

 [~, ~, numSubjects]=size(faceM);
 if nargin >1
[rows,~]=size(EiganVec);
 else
 testFace=faceM(:,:,1);
 testFace=reshape(testFace, [],1);
 [rows, ~]=size(testFace);
 end
meanV=zeros(rows,1, numSubjects);
covV=zeros(rows, rows, numSubjects);

%% 
for i=1:numSubjects
   if rem(i,3)~=0
       a=faceM(:,:,i);
  
       nFiltSize=4;
       nFiltRadius=1;
       filtR=generateRadialFilterLBP(nFiltSize, nFiltRadius);
       LBP= efficientLBP(a, 'filtR', filtR, 'isRotInv', false, 'isChanWiseRot', false);
       LBP=im2double(LBP);
       LBP=reshape(LBP, [], 1);
       LBP=imadjust(LBP,[],[0,1]);
       if nargin>1
          LBP=EiganVec*LBP;
       end
       
       if rem(i+2,3)==0
           temp=zeros(rows,1,2);
           temp(:,:,rem(i+2,3)+1)=LBP;
       else
           temp(:,:,rem(i+2,3)+1)=LBP;
       end
   else
       %% mean Cal
       
       sumMean=(temp(:,:,1)+temp(:,:,2))/2;
       meanV(:,:,i/3)=sumMean;
        
       %% cov Cal
       
        sumCov= (  (temp(:,:,1)-sumMean)* transpose((temp(:,:,1)-sumMean)) + (temp(:,:,2)-sumMean)* transpose((temp(:,:,2)-sumMean))  )/2;
        sumCov=sumCov+eye(rows);
        covV(:,:,i/3)=sumCov;
       
   end  % end if-else
end  % end for
end  % end class
       