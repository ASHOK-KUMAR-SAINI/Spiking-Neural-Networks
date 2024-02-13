function [W]=deltaW3(tprr,tpost,OWW)
       
        Wmax=1.5;
        Wmin=-1.2;
        alpha=.8;
        dw=zeros(size(tprr,1),1);
        deltat=zeros(size(tprr,1),1);
        d=zeros(1,size(tprr,1));
         W1=OWW;
 for j=1:1:size(tprr,1)
        for k=1:1:length(tpost)
            for i=1:1:k
            if tpost(i)>0
                c=i;
            end
            if tprr(j,i)>0
                d(j)=i;
            end
            end
        end
        
          deltat(j)=c-d(j);
          if deltat(j)>=0
              dw(j)=0.00078*exp(-deltat(j)/016.8);
         else
              dw(j)=-0.00027*exp(-deltat(j)/033.7);
          end

          if dw(j)>0
              W1(j)=W1(j)+alpha*dw(j)*(Wmax-W1(j));
              else
               W1(j)=W1(j)+alpha*dw(j)*(Wmax-Wmin);
          end
 end 
        W=W1;
 end

              