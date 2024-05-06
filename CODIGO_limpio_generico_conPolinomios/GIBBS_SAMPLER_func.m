function [a1n,a1,pos_curr] = GIBBS_SAMPLER_func(X,Y,N_entrada,Tsimu,chosen_output,Const,alpha,type_of_Model)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% pos_curr ====> GENERATED MARKOV CHAIN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  [dim1,dim2]=size(X);
%%%%%%%%%%%%%%%  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                          %
   N=N_entrada; %%% N>=1 y N<122 (tiene sentido 121), EDU, ROB TOCA AQUI %%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
   pos_curr=randperm(dim2,N);
   pos_curr=sort(pos_curr)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
 %Tsimu=10000;
 %Const=100;
 %Const=50;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% START !!!!! %%%%%%  %%%%%%  %%%%%%  %%%%%%  %%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  for i=2:Tsimu+1
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
       if mod(i,50)==0
         disp([num2str(i/Tsimu*100),'%'])
       end
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    %%%%%%%%%%%%%%%%%%%%%  
       pos_curr(i,:)=pos_curr(i-1,:);
      for j=1:N 
          posnow=pos_curr(i,:);
          posnow(j)=[];
          possample=SampleOneDimOverN(posnow,X,Y,chosen_output,Const,alpha,type_of_Model);
          pos_curr(i,j)=possample;
      end
       
  end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
[a1,a2]=hist(pos_curr(:),dim2);
  a1n=a1/sum(a1);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
plotyes=1;
if plotyes==1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

      bar([1:dim2],a1n,'b')
   hold on
   plot(1:dim2,1/dim2*ones(1,dim2),'r--','LineWidth',2)
   set(gca,'FontWeight','Bold','Fontsize',20)
   titulo = ['GIBBS con N = ',num2str(N)];
   title(titulo)
%   namefile=['Results_GIBBS_N_',num2str(N),'_output_',num2str(chosen_output)]
%   saveas(gcf,namefile)
%   namefile2=['Results_GIBBS_N_',num2str(N),'_output_',num2str(chosen_output),'.jpg']
%   saveas(gcf,namefile2)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % if savefiles==1    
% % %   namefile=['Results_GIBBS_N_',num2str(N),'_output_',num2str(chosen_output),'_intercep_',num2str(with_intercept)]
% % %   save(namefile,'pos_curr','N','chosen_output','with_intercept','Tsimu','Const')
% % % end
   
  % text(106.5,0.31,'113','Fontsize',12,'FontWeight','Bold','Color','r')
  % text(54,0.04,'56','Fontsize',12,'FontWeight','Bold','Color','r')
  % text(12,0.17,'14','Fontsize',12,'FontWeight','Bold','Color','r')
  % text(6.7,0.05,'8','Fontsize',12,'FontWeight','Bold','Color','r')
   
%     text(106.5,0.49,'113','Fontsize',12,'FontWeight','Bold','Color','r')
%     text(12,0.215,'14','Fontsize',12,'FontWeight','Bold','Color','r')
%     text(55,0.033,'56','Fontsize',12,'FontWeight','Bold','Color','r')
%     text(33,0.04,'35','Fontsize',12,'FontWeight','Bold','Color','r')
%     text(27,0.04,'29','Fontsize',12,'FontWeight','Bold','Color','r')
%     
%    text(109,0.133,'113','Fontsize',12,'FontWeight','Bold','Color','r')
%    text(114,0.185,'116','Fontsize',12,'FontWeight','Bold','Color','r')
%    text(51,0.108,'51','Fontsize',12,'FontWeight','Bold','Color','r')
%    text(46.8,0.1,'50','Fontsize',12,'FontWeight','Bold','Color','r')
%    text(11,0.025,'13','Fontsize',12,'FontWeight','Bold','Color','r')
%    text(1,0.175,'2','Fontsize',12,'FontWeight','Bold','Color','r')
%    text(-0.5,0.117,'1','Fontsize',12,'FontWeight','Bold','Color','r')

  


   