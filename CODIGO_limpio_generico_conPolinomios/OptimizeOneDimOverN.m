function output=OptimizeOneDimOverN(pos,X,Y,chosen_output,alpha,type_of_Model)
%clear all
%close all
%clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     [dim1,dim2]=size(X); 
    N=length(pos);
     vec=[1:dim2];
     vec(pos)=[];
     
  %%%%%%%%%%%%  %%%%%%%%%%%%  %%%%%%%%%%%%  %%%%%%%%%%%%  %%%%%%%%%%%%
  %%%%%%%%%%%%  %%%%%%%%%%%%  %%%%%%%%%%%%  %%%%%%%%%%%%  %%%%%%%%%%%%    
  %%%%%%%%%%%%  %%%%%%%%%%%%  %%%%%%%%%%%%  %%%%%%%%%%%%  %%%%%%%%%%%%
   for i=1:dim2-N
       
      % if mod(i,10)==0
      %     i
      % end
       %%%% NOOOOOO pos(i,:)=randi(dim2,1,N);
      %%%%%%%%%%%%%%%%%%%%%%%%%%% 
      %%%%%%%%%%%%%%%%%%%%%%%%%%%
       %%%posnow=randperm(dim2,1);
       posnow=[pos vec(i)];
       posnow=sort(posnow);%%%no estrictamente necesario 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
               Xnow=X(:,posnow); 
                f=model(Xnow,Y(:,chosen_output),type_of_Model);
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        error_par(i)=mean(abs(Y(:,chosen_output)-f).^alpha);  
    
   end
   %%%%%%%%%%%%%%%%%%%%%%%%
   posmin=find(error_par==min(error_par));
   output=vec(posmin);
   
   