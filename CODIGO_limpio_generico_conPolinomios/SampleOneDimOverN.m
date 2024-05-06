function output=SampleOneDimOverN(pos,X,Y,chosen_output,Const,alpha,type_of_Model)
%clear all
%close all
%clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
     [dim1,dim2]=size(X);     
     N=length(pos);
     vec=[1:dim2];
     vec(pos)=[];
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   for i=1:dim2-N
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
       posnow=[pos vec(i)];
       posnow=sort(posnow);%%%no estrictamente necesario 
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
               Xnow=X(:,posnow);  
               f=model(Xnow,Y(:,chosen_output),type_of_Model);
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
        error_par(i)=mean(abs(Y(:,chosen_output)-f).^alpha);    
   end
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %error_par(1)=[];
   %error_par(1)=Inf;
   w=exp(-Const*error_par);
   wn=w./sum(w);
   %size(wn)
   %stem(wn)
   posres=randsrc(1,1,[1:length(wn); wn]);
   output=vec(posres);
  