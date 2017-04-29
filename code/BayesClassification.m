function accuracy=BayesClassification(faceM,k)  %% flag=0-> without PCA; flag=1-> with PCA

tic;
if nargin==1
    [meanV,covV]=Mean_Cov_Bayes(faceM); 
    accuracy=BayesAccuracyCal(faceM,meanV,covV);


else 
    EiganVec=LDA(faceM,k);
    [meanV,covV]=Mean_Cov_Bayes(faceM, EiganVec); 
    accuracy=BayesAccuracyCal(faceM,meanV,covV,EiganVec);


end
toc;
end