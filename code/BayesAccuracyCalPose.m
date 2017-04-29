function accuracy=BayesAccuracyCalPose(poseM,meanV,covV,EiganVec)

 [~, ~,numPose, numSubjects]=size(poseM);
counter=0;
for i=33:35
    i
    for j=11:13
        
       a=poseM(:,:,j,i);
          if nargin>3
             b=CondProbCalPose(poseM, a,meanV,covV,EiganVec);
          else
             b=CondProbCalPose(poseM, a,meanV,covV);
          end
         if b==1
           counter=counter+1;
         end
    end
end
accuracy=counter/9;

end
