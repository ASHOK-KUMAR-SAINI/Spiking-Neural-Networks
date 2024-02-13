function [W]=weigths(N_spike,N_predicted,I_e_vect,OWW)
      
         W1=OWW;
        rate=0.0001;
        N_input=zeros(size(I_e_vect,1),1);
        DW=zeros(size(I_e_vect,1),1);
      for k=1:1:size(I_e_vect,1)
       for j=1:1:length(I_e_vect)
            if I_e_vect(k,j)>0
                N_input(k)=N_input(k)+1;
            end
       end
        DW(k)=(N_predicted-N_spike)*rate*N_input(k);
        W1(k)=W1(k)+DW(k);
       
      end
 W=W1;
              