The code is run on two different datasets, data.mat and pose.mat. 
There are two separate codes for each dataset. 

A) Data.mat
1) Bayes
  To run Bayes, run BayesClassificaiton(face,k);
  face is the data.mat and k is optional. If specified, dimensionality
reduction is done, and LDA or PCA os correspondingly chosen by changing
the corresponding line mentioned in the BayesClassification funciton.
If only one parameter specified as input, code runs without dimensionality reduction
Output: accuracy of the classifier. 
Note: Number of test images can be changed in the BayesAccuracyCal funciton
2) KNN
  To run KNN, run KnnClassifier(face,k), similar to Bayes. 
    PCA or LDA can be changed in the KnnClassifier function. 
   Number of test funcitons can be changed in the KnnClassifier Function.

B) Pose.mat: Only Bayes classification has been implemented on Pose
   To test pose.mat, run BayesClassificationPose(pose,k)
   Input and output are similar to above. 

LBP has been used from the matlab file exchange: https://www.mathworks.com/matlabcentral/fileexchange/36484-local-binary-patterns 
