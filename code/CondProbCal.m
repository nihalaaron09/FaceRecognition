
function flag=CondProbCal(faceM,a,meanV,covV,Eigan)   %% returns number accurate classifications of test data points
%[meanV,covV]=ModelConstruction(face);
[~,~,NumberSubjects]=size(faceM);
for i=1:NumberSubjects
       if faceM(:,:,i)==a
         ActualClass=i/3;
         break;
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

[rowsP,~]=size(y);

p=zeros(NumberSubjects/3,1);

for i=1:NumberSubjects/3
    
  mP=meanV(:,:,i);
  cP=covV(:,:,i);
  
  dif=y-mP;
  
p(i) =   (1/ (   ((2*pi)^(rowsP/2) )  *sqrt(det(cP)) ) ) * exp( -0.5*(transpose(dif)*( inv(cP)*dif )) );

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


