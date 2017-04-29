function accuracy=BayesAccuracyCal(faceM,meanV,covV,EiganVec)

 [~, ~, numSubjects]=size(faceM);
counter=0;
for i=3:3:36
       a=faceM(:,:,i);
          if nargin>3
             b=CondProbCal(faceM, a,meanV,covV,EiganVec);
          else
             b=CondProbCal(faceM, a,meanV,covV);
          end
         if b==1
           counter=counter+1;
         end
end
accuracy=counter/(36/3);

end
