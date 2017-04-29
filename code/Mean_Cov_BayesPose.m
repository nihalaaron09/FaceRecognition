%% FEATURE VECTOR EXTRACTION (LBP)
function [meanV, covV]=Mean_Cov_BayesPose(poseM,EiganVec)

 [~, ~,numPose, numSubjects]=size(poseM);
 
 if nargin >1
[rows,~]=size(EiganVec);
 else
 testFace=poseM(:,:,1,1);
 testFace=reshape(testFace, [],1);
 [rows, ~]=size(testFace);
 end
meanV=zeros(rows,1, numSubjects);
covV=zeros(rows, rows, numSubjects);

%% 
 for i=1:numSubjects
     temp=zeros(rows,1,numPose-9);   % train for 6 samples
    for j=1:numPose-9
   % if rem(i,3)~=0
       a=poseM(:,:,j,i);
  
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
       temp(:,:,j)=LBP;
    end  % end j-for
    
    meanT=(sum(temp(:,:,:),3))/(numPose-9);   % 5 changes to numpose-x
    meanV(:,:,i)=meanT;

    diff=bsxfun(@minus,temp,meanT);
    diffT=permute(diff,[2,1,3]);    %% transpose for the 2d slices of a 3d matrix
    
    sumCov=zeros(rows,rows);
    for k=1:numPose-9
        sumCov=sumCov+( diff(:,:,k)*diffT(:,:,k) );
    end
    covV(:,:,i)=sumCov/(numPose-9);
    covV(:,:,i)=covV(:,:,i)+eye(rows);

    
end    % end i-for

end       % function
       
    