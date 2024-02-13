function [W]=deltaW(tprr,tpost,OW)
       for j=1:1:length(tpost)
            if tpost(j)>0
                c=j;
            end
        end
       d=zeros(1,size(tprr,1));
        for j=1:1:size(tprr,1)
            for i=1:1:size(tprr,2)
            if tprr(j,i)>0
                d(j)=i;
            end
            end
        end
        W1=OW(1);
        W2=OW(2);
          deltat1=c-d(1);
          deltat2=c-d(2);
          if deltat1>0
              dw1=.00078*exp(-deltat1/16.8);
          else
              dw1=-.00027*exp(-deltat1/33.7);
          end
           if deltat2>0
              dw2=.00078*exp(-deltat1/16.8);
          else
              dw2=-.00027*exp(-deltat1/33.7);
         
           end
         
          W1=W1+dw1;
          W2=W2+dw2;
          W=[W1 W2];
end

              