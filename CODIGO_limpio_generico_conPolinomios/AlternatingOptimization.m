clear all
close all
clc

 load X
 X=dataX;
%%%%%%%%%%%%%%%
  load Y 
  Y=dataY;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
   chosen_output=1;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
   [dim1,dim2]=size(X);
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
    N=4;
    pos_curr=randperm(dim2,N);
    disp('random intial condition:')
    pos_curr=sort(pos_curr)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     alpha=2;
     type_of_Model=1;
 % Tsimu=1000000;
Tsimu=100;
 %Tsimu=5000; 

  %%%%%%%%%%%%
   for i=2:Tsimu+1
       if mod(i,10)==0
         disp([num2str(i/Tsimu*100),'%'])
       end
     %%%%%%%%%%%%%  
       pos_curr(i,:)=pos_curr(i-1,:);
      for j=1:N 
         % disp('aqui---')
          posnow=pos_curr(i,:);
         % disp('aquii')
          posnow(j)=[];
          posmin=OptimizeOneDimOverN(posnow,X,Y,chosen_output,alpha,type_of_Model);
          pos_curr(i,j)=posmin;
        %  pause
      end
       
   end
  %%%%%%%%%%%%%%%%%%%% 
   pos_curr
  %%%%%%%%%%% 
   SOL=pos_curr(end,:); %%%%% porque quiero que 0 sea la componente nula
 disp('------------------------------------------------------------')
 disp(['Chosen Output = ',num2str(chosen_output)]) 
 disp('------------------------------------------------------------')
  disp(['Solution (ordered in ascending order) =']) 
 SOL=sort(SOL)
   
  error_par=Compute_error(SOL,X,Y,chosen_output,alpha,type_of_Model)
  
 disp('------------------------------------------------------------')
 disp(' It could be a local mode ! TRY AGAIN ! ') 
 disp('------------------------------------------------------------')
  % error_antes=Calcula_error_2fun([1     4     8    14  18  37   56    87   113 114],X,Y,chosen_output,with_intercept)
  
  %err_posmin=error_par;
%namefile=['Results_OptSEQ_ALTER_N_',num2str(N),'_output_',num2str(chosen_output),'_intercep_',num2str(with_intercept)]
%save(namefile,'SOL','N','error_par','chosen_output','with_intercept')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% OUTPUT 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1%%% 114                                                                  0.3732
%2%%%  88   114                                                            0.3479
%3%%%  88   114   115                                                      0.3275
%4%%%   3    88   114   115                                                0.3187
%5%%%   3   104   113   114   115                                          0.3092
%6%%%  33    40   113   114   115   119                                    0.3031
%7%%%   3     5    88   109   113   114   115                              0.2954
%8%%%   3     5    72    79   110   113   114   115                        0.2919
%9%%%   3     5    72    79    88   110   113   114   115                  0.2852
%10%%%  3     5    40    72    79    88   112   113   114   115            0.2814
%11%%%  3    31    40    52    72    79    91   110   113   114   115      0.2777
%12%%%  1    3    31    40    52    72    79    88    91   110   113   114 0.2740
%13%%%  3    31    40    52    64    75    79    88    91   110   113   114 115 %%%% 0.2717  
%14%%%  3    15    31    40    52    64    75    79    88    91   110   113 114 115 %%% 0.2695
%15%%%  3    10    12    14    15    31    40    52    72    79    91   110 113   114   115  %%% 0.2668
%20%%% 0.2592
%30%%% 0.2513
%50%%% 0.2438
%80%%% 0.2381

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% OUTPUT 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1  %%% 113                                                                %%%%  0.2868                                                             
%2  %%%  39   113                                                          %%%%  0.2500
%3  %%%   8    14   113                                                    %%%%  0.2102
%4  %%%   4     8    14   113                                              %%%%  0.1871
%5  %%%  10    56   113   114   115                                        %%%%  0.1725
%6  %%%  10    13    56   113   114   115                                  %%%%  0.1679
%7  %%%   4     8    14    56   113   114   115                            %%%%  0.1593
%8  %%%   4     8    14    43    56   113   114   115                      %%%%  0.1564
%9  %%%   4     8    14    16    43    56   113   114   115                %%%%  0.1538
%10 %%%   4     8    14    16    43    56   107   113   114   115          %%%%  0.1520
%11 %%%   4     8    13    14    16    43    56   107   113   114   115    %%%% 0.1500
%12 %%%   4     8    13    14    16    43    55    56   107   113   114   115 %%%%  0.1487
%13 %%%   4     8    11    13    14    16    23    43    56   107   113   114   115 %%%% 0.1475
%14 %%%   4     8    13    14    16    38    43    55    56    91   107   113   114   115  %%% 0.1465
%15 %%%   4     8    11    13    14    16    23    38    43    55    56   107   113   114   115  %%% 0.1454
%16 %%%  0.1445
%17 %%%  0.1439
%18 %%%  0.1433
%19 %%%  0.1425
%20 %%%  0.1421
%25 %%%  0.1398
%30 %%%  0.1384
%50 %%%  0.1354
%70 %%%  0.1337
%85 %%%  0.1331
%100 %%  0.1330
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

