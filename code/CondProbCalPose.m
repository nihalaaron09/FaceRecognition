
function flag=CondProbCalPose(poseM,a,meanV,covV,Eigan)   %% returns number accurate classifications of test data points
%[meanV,covV]=ModelConstruction(face);
[~,~,numPose,numSubjects]=size(poseM);
for i=1:numSubjects
    for j=1:numPose
       if poseM(:,:,j,i)==a
         ActualClass=i;
         break;
       end
    end
end


%% extract LBP for input image
nFiltSize=4;
nFiltRadius=1;
filtR=generateRadialFilterLBP(nFiltSize, nFiltRadius);
LBP= efficientLBP(a, 'filtR', filtR, 'isRotInv', false, 'isChanWiseRot', false);
    LBP=im2double(LBP);
    LBP=reshape(LBP, [], 1);
    LBP=imadjust(LBP,[],[0,1]);
    if nargin==5
       LBP=Eigan*LBP;
    end
y=LBP;
    
%% compute p(x/wi)'s wrt extracted image's LBP

%[rowsP,~]=size(y);

p=zeros(numSubjects,1);

for i=1:numSubjects
    
  mP=meanV(:,:,i);
  cP=covV(:,:,i);
  
  dif=y-mP;
  
p(i) =   (1/ (   sqrt(det(cP)) ) ) * exp( -0.5*(transpose(dif)*( inv(cP)*dif )) );   % ((2*pi)^(rowsP/2) ) 

end %% for

%% test whether actual class of image is the same as the estimated Class
%count=0;
estimatedClassBayes=find(p==max(p));
if ActualClass==estimatedClassBayes
    flag=1;
    %count=count+1;
else
    flag=0;
end  % if


end % function


