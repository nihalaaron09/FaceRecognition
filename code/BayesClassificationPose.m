function accuracy=BayesClassificationPose(poseM,k)  %% flag=0-> without PCA; flag=1-> with PCA
poseM=uint8(poseM);
tic;
if nargin==1
    [meanV,covV]=Mean_Cov_BayesPose(poseM); 
    accuracy=BayesAccuracyCalPose(poseM,meanV,covV);


else 
    EiganVec=PCAPose(poseM,k);
    [meanV,covV]=Mean_Cov_BayesPose(poseM, EiganVec); 
    accuracy=BayesAccuracyCalPose(poseM,meanV,covV,EiganVec);


end
toc;
end