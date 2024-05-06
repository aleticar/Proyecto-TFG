clear all
close all
clc
 %%%%%%%%%%%%%% %%%%%%%%%%%%%% %%%%%%%%%%%%%% %%%%%%%%%%%%%% 
 %%%%%%%%%%%%%% %%%%%%%%%%%%%% %%%%%%%%%%%%%% %%%%%%%%%%%%%% 
 load X
 X=dataX;
load Y 
  Y=dataY;
 %%%%%%%%%%%%%% %%%%%%%%%%%%%% %%%%%%%%%%%%%% %%%%%%%%%%%%%% 
 %%%%%%%%%%%%%% %%%%%%%%%%%%%% %%%%%%%%%%%%%% %%%%%%%%%%%%%% 
 %%%%%%%%%%%%%% %%%%%%%%%%%%%% %%%%%%%%%%%%%% %%%%%%%%%%%%%% 
 N_entrada=6;
 Tsimu=1000;
 chosen_output=1;
 Const=100;
 alpha=1;
 type_of_Model=1;
 %%%%%%%%%%%%%% %%%%%%%%%%%%%% %%%%%%%%%%%%%% %%%%%%%%%%%%%% 
 %%%%%%%%%%%%%% %%%%%%%%%%%%%% %%%%%%%%%%%%%% %%%%%%%%%%%%%% 
 %%%%%%%%%%%%%% %%%%%%%%%%%%%% %%%%%%%%%%%%%% %%%%%%%%%%%%%%  
 [a1n,a1,pos_curr]=GIBBS_SAMPLER_func(X,Y,N_entrada,Tsimu,chosen_output,Const,alpha,type_of_Model);
 %[a1n,a1,pos_curr]=GIBBS_SAMPLER_func(X,Y,6,2000,1,100,10,1);
%%%[a1n,a1,pos_curr] = GIBBS_SAMPLER_func(X,Y,N_entrada,Tsimu,chosen_output,Const,alpha,type_of_Model)
