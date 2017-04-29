function flag=KnnClassifierModel(faceM,a,Vec)
%a=face(:,:,510);

[~,~,NumberSubjects]=size(faceM);

for i=1:NumberSubjects
       if faceM(:,:,i)==a
         ActualClass=i/3;
         break;
       end  
end%% actual class find

%% 



       nFiltSize=4;
       nFiltRadius=1;
       filtR=generateRadialFilterLBP(nFiltSize, nFiltRadius);
       LBP= efficientLBP(a, 'filtR', filtR, 'isRotInv', false, 'isChanWiseRot', false);
       a=im2double(LBP);
       a=reshape(a, [], 1);
a=imadjust(a,[],[0,1]);
if nargin==3
   a=Vec*a;
end



%%%% K nearest neighbours
K=20;
KMatDist=zeros(1,K);
KMatInd=zeros(1,K);
q=1;
for i=1:NumberSubjects
    if rem(i,3)~=0
    
         trainFaceCurrent=faceM(:,:,i);
         nFiltSize=4;
         nFiltRadius=1;
         filtR=generateRadialFilterLBP(nFiltSize, nFiltRadius);
         LBP= efficientLBP(trainFaceCurrent, 'filtR', filtR, 'isRotInv', false, 'isChanWiseRot', false);
         trainFaceCurrent=im2double(LBP);
         trainFaceCurrent=reshape(trainFaceCurrent, [], 1);
         trainFaceCurrent=imadjust(trainFaceCurrent,[],[0,1]);
        if nargin==3
            trainFaceCurrent=Vec*trainFaceCurrent;
        end
        
        %EucDist=abs(a-trainFaceCurrent);
       % summ=sum(EucDist(:));
        summ=sqrt(sum((trainFaceCurrent - a) .^ 2));

         if q<=K 
            KMatDist(q)=summ;
            KMatInd(q)=floor(i/3)+1;
            q=q+1;
         else   
             if max(KMatDist(:)) > summ    
                posTemp=find(KMatDist==max(KMatDist));
                KMatDist(posTemp)=summ;
                KMatInd(posTemp)=floor(i/3)+1;
             end  %% end if( replaceing max element)
         end      %% end if ( for i<=K)
    end   %% end  if


end    %% end subjects if

%% classification

y = zeros(size(KMatInd));
for i = 1:length(KMatInd)
y(i) = sum(KMatInd==KMatInd(i));
end

counter=1;
%% form 'pre' array, which contains all duplicated classes if any, or is the same as the KMatInd array   

if max(y)>1
        for i=1:length(KMatInd)
          if y(i)>1
            pre(counter)=KMatInd(i);
            counter=counter+1;
          end
        end
        
else
        pre=KMatInd;
        
end   %% end if max(y)
   %% 
if all(y==y(1))                                 %% if all unique elements, choose the one with the minimum distance to test sample
    pos=find(KMatDist==min(KMatDist));
    estimatedClassKNN=pre(pos);
elseif nnz(y==2)                    %% in case of no tie, final Class is the one which appears most times
        estimatedClassKNN=unique(pre);
else                                            %% if there is a tie, choose that class(among the tied classes) which is closest to test. else randomly choose 
    Temp=KMatInd;
    [~,index]=sort(Temp);
    for i=1:length(pre)
        if Temp(index(1))==pre(i)
            estimatedClassKNN=pre(i);
            break;
        else
            estimatedClassKNN=datasample(pre,1);        
        end
    end       
end    % end if all()
       

if ActualClass==estimatedClassKNN
    flag=1;
else 
    flag=0;
end    % end if ActualClass==


end %% function


    
