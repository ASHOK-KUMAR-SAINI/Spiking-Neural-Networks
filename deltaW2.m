function [W]=deltaW2(tprr,tpost,OWW)
       
        Wmax=2.5;
        Wmin=-2.2;
        
        dw=zeros(size(tprr,1),1);
        delta_t=zeros(size(tprr,1),1);
        d=zeros(1,size(tprr,1));
         W1=OWW;
         c=0;
 for j=1:1:size(tprr,1)
        for k=1:1:length(tpost)
            
            if tpost(k)>0
                c=k;
            end
            if tprr(j,k)>0
                d(j)=k;
            end
           
        end
        
          delta_t(j)=d(j)-c;
          if delta_t(j)>0
              dw(j)=-0.0053*exp(-delta_t(j)/016.8);
         else
              dw(j)=0.0035*exp(delta_t(j)/033.7);
          end

          if dw(j)<0
              W1(j)=W1(j)+0.5*dw(j)*(W1(j)-Wmin);
              else
               W1(j)=W1(j)+0.7*dw(j)*(Wmax-W1(j));
          end
        
 end 
        W=W1;
 end

              