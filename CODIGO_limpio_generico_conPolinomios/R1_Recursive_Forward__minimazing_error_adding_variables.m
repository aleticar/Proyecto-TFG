clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Adding variables - Recursive Forward minimizing error %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 load X
 X=dataX;
    %%%%%%%%%%%% %%%%%% 
       %%%%%%%%%%%% %%%%%%  
  X=X-mean(X); %%%% creo IMPORTANTEclear all
close all
clc

load X
X = dataX;
X = X - mean(X);

load Y
Y = dataY;
Y = Y - mean(Y);

chosen_output = 1;
[dim1,dim2] = size(X);

alphas = [1];
orden_polis = [2, 3, 4, 5, 10];

figure
hold on

% Crear una tabla para almacenar los resultados
results = cell(length(alphas)*length(orden_polis)+1, 4);
results{1,1} = 'Alpha';
results{1,2} = 'Orden Poli';
results{1,3} = 'Error';
results{1,4} = 'Solución';

counter = 2;

for a = 1:length(alphas)
    for o = 1:length(orden_polis)
        alpha = alphas(a);
        orden_poli = orden_polis(o);
        
        pos_before = [];
        todo_all_possible = 1:dim2;
        
        for i = 1:dim2
            for j = 1:length(todo_all_possible)
                pos = [pos_before todo_all_possible(j)];
                Xnow = X(:,pos);
                warning off
                f = model(Xnow,Y(:,chosen_output),orden_poli);
                error_par_aux(j) = mean(abs(Y(:,chosen_output)-f).^alpha);
            end
            
            error_par(i) = min(error_par_aux);
            pos_err_min = find(error_par_aux == error_par(i));
            pos_err_min = pos_err_min(1);
            pos_before = [pos_before todo_all_possible(pos_err_min)];
            todo_all_possible(pos_err_min) = [];
            clear error_par_aux
        end
        
        V = [mean(abs(Y(:,chosen_output)).^alpha) error_par];
        plot(0:dim2,V,'o-', 'DisplayName', ['alpha=' num2str(alpha) ', orden_poli=' num2str(orden_poli)])
        
        % Almacenar los resultados en la tabla
        results{counter,1} = alpha;
        results{counter,2} = orden_poli;
        results{counter,3} = error_par;
        results{counter,4} = pos_before;
        counter = counter + 1;
    end
end

hold off
legend

% Mostrar la tabla de resultados
disp(results)
  
  %%%%%% %%%%%% %%%%%% %%%%%% 
  %%%%%% %%%%%% %%%%%% %%%%%% 
%%%%%%%%%%%%%%%
  load Y 
  Y=dataY;
   %%%%%%%%%%%% %%%%%%  
  Y=Y-mean(Y); %%%% IMPORTANTE  O CAMBIAR V(0)
  %%%%%% %%%%%% %%%%%% %%%%%% 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 chosen_output=1; %%%  1 or 2 %%% OUTPUT
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    [dim1,dim2]=size(X);
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
   %%%%%%%%%%%% %%%%%%%%%%%%   %%%%%%%%%%%% %%%%%%%%%%%%   %%%%%%%%%%%% %%%%%%%%%%%% 
   pos_before=[];
   todo_all_possible=1:dim2; %%% all possible positions of variables
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   for i=1:dim2
      %%%%%%%%%%%%%%%%%%%%%%%%%%% 
       if mod(i,10)==0
         disp([num2str(i/dim2*100),'%'])
       end
       %%%%%%%%%%%%%%%%%%%%%%%%%%%  
     for j=1:length(todo_all_possible)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
         pos=[pos_before todo_all_possible(j)];
         Xnow=X(:,pos); 
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         orden_poli=10;
         warning off
         f=model(Xnow,Y(:,chosen_output),orden_poli);
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         alpha=2;
         error_par_aux(j)=mean(abs(Y(:,chosen_output)-f).^alpha);
     end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    error_par(i)=min(error_par_aux);
    %%% pos_err_min=find(error_par(i)==error_par_aux);
     pos_err_min=find(error_par_aux==error_par(i));
     pos_err_min=pos_err_min(1); %%%% just for security
    pos_before=[pos_before todo_all_possible(pos_err_min)];
    todo_all_possible(pos_err_min)=[];
    clear  error_par_aux
   end
  %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%% 
  %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%% 
  %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%% 
  disp('------------------------------------')
  disp(['Solution / RANKING: (orden poli = ',num2str(orden_poli),')']) 
      SOL=pos_before
  
  %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%% 
  %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%% 
  %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%% 
   figure
 %  error_par(1)=[];
 V=[mean(abs(Y(:,chosen_output)).^alpha) error_par];
  plot(0:dim2,V,'o-')
  %%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   disp('------------------------------------------------')
   disp(['Recall chosen_output = ',num2str(chosen_output),' and alpha = ',num2str(alpha)])
   disp('------------------------------------------------')
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%
  %%%% STUDY FIRST DERIVATIVE AND CONVEXITY DO NOT STRICTLY REQUIRED
  %figure
  %stem(V(1:end-1)-V(2:end))
  d1=V(1:end-1)-V(2:end);
  posder1=find(d1<0);
  length(posder1)
  d2=d1(1:end-1)-d1(2:end);
  posder2=find(d2<0);
  length(posder2)
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 %%%%%% output 1  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 %a=0.1%113    56    14     8     4     1   114    45   122   119   103     5    54    88    40    63    64
 %a=0.5%113    39    14     8     4    56     1   114    18    13    37     3    36   102    47    43   110
 %a=1  %113    14     8     4    56   115   114    16    43    75    55    13    37   122     2   107    11
 %a=2  %113    39    14     8     4    56   115   114    16    13    37    77    43   107    55     3    11
 %a=3  %113    14     8     4   115   114    56    18    43     2   107    13    11   122   118    27    51
 %a=4  %114    88    46    13    11     6    14    16   115   113    56    38    77   119   101     3    43
 %a=5  %114    88    46    13    11     6    14    16    50   113   115    38    56   101    92     8     3
 %a=6  % 15    20    10   114    88    11    13     8    14    16    77    80    56    51   115   113    38
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 %%%%%% output 2  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 %a=0.1%114    88   115     3    52   109    33   113    40     5    51    34    36   106    96    17    85
 %a=0.5%114    88   115     3    42     5   113   109    33    54    38    65    36    79    80   101    40
 %a=1  %114    88   115     3    42     5   113   109    64    31    59    15     9   121    13    36    79
 %a=1.5%114    88   115     3    42     5   113   109    65    31    25    37     4   122     2    50    40
 %a=2  %114    88   115     3   113   109     5    25    65    40    33    37     4   122    68   107    36
 %a=2.5%114    88     1   113     3   109     5    40    65    39    33    25   122     4    37    50     2
 %a=3  %114    88     1   113     3    40     5   109    65    39   122    25    33    37     4    50    68
 %a=4  %114    88    49     1   113     3    40     5   122    37    57   109    47    33    44   111   101
 %a=5  %114    88    49     1   113     3    47    44    15    75   122     5    40    39   105    57    37
 %a=6  %114    23   113     1   105     7    86    40    39     3    57    37    56    36     5    45    47
 %a=10 % 15    41    25     6    70    93    95    42   121    84    53    59    40    80    64    71    35
% alpha=1 poli=2
% %[Columns 1 through 15
% 
%    113     4    56    42   115   114     6    36    88    30    37    14    12    55    43
% 
%   Columns 16 through 30
% 
%     13    86   119    40    21    22    45    75    48    33    98     2     3    77    49
% 
%   Columns 31 through 45
% 
%     84   105    63    80    57    52    25    26   116     8    93    31    38    72    27
% 
%   Columns 46 through 60
% 
%     50    24    10    78   103    83    34    76     5    53    97   121    65   102    39
% 
%   Columns 61 through 75
% 
%     89    69   122    62    59    73   100    60    82    68    32    29    81     1    15
% 
%   Columns 76 through 90
% 
%    112    28   104   111    11    16   118     7   120     9    74    19    20    64    96
% 
%   Columns 91 through 105
% 
%    109    90    91    67   107   106    70    99   117    71    18    66    47    41    58
% 
%   Columns 106 through 120
% 
%     44   101    17    51    87    46    35    94   110   108    23    61    92    79    85
% 
%   Columns 121 through 122
% 
%     54    95


%alpha 1 poli=3
% SOL =
% 
%   Columns 1 through 15
% 
%    113     4    56    24    43    33    14   114   119    87    36    30    19     3   117
% 
%   Columns 16 through 30
% 
%     42    44    47    48    40   115    39     9    15    59    49   102   101    10    22
% 
%   Columns 31 through 45
% 
%     51     1     2    88    29   110   108    11    57     8    26   104   106    78    69
% 
%   Columns 46 through 60
% 
%    118    21    97    83    41    65    16    89    62    13    18     6    28    94   122
% 
%   Columns 61 through 75
% 
%     20    34    70     7    73    84    45    72    81    52    17    91    80    12   120
% 
%   Columns 76 through 90
% 
%     37    63    85    55   100    90   109    76    66    31   112    95    46   105   121
% 
%   Columns 91 through 105
% 
%    103    79    68    98    96     5    93    74    99    67   111    60    75    71   107
% 
%   Columns 106 through 120
% 
%     77    32    23    50    64    25    61    82    38    92    58   116    35    86    27
% 
%   Columns 121 through 122
% 
%     54    53

%aplha 1 poli 4

% SOL =
% 
%   Columns 1 through 15
% 
%    113     4    56    24    43    33    14   119   114    36    87    86    50    13    37
% 
%   Columns 16 through 30
% 
%     40    19    39    12    76     7    16   110   105    15     9     8    85    68    10
% 
%   Columns 31 through 45
% 
%     22    42    44    34    63   120   102    35   112    21    27    57    20    11   103
% 
%   Columns 46 through 60
% 
%      3   118    32    69    70    45     1   109    51    73    74   104    97   121    65
% 
%   Columns 61 through 75
% 
%     72   106    89    78    30    71    94    90    93    58    18    41    62    77   117
% 
%   Columns 76 through 90
% 
%     46    75   101    47    28    80    49     6    31    84    88    55    17   111    98
% 
%   Columns 91 through 105
% 
%     29    26    83    64    23    67    99    79   108    38    95    25    82   115    52
% 
%   Columns 106 through 120
% 
%      5   100    66    59    91    92   107    60    48    96    61    81    53    54   122
% 
%   Columns 121 through 122
% 
%      2   116

%aplha 1 poli 5
%  Columns 1 through 15

% 
%    113     4    56    24    43    36   114    87   119    86    14    69    13    10   122
% 
%   Columns 16 through 30
% 
%     91    52    51   116    19    94    18    37    39    12    26    93    59   100   105
% 
%   Columns 31 through 45
% 
%     49     3    44   102    33   121    74    70    68    61    22   115    50    27    85
% 
%   Columns 46 through 60
% 
%      1     6    23    62    79    11    25    20    46   108   109     5   101    15    47
% 
%   Columns 61 through 75
% 
%    120    76   110    30    99   104    90    32    64    82    83     2   107    42    75
% 
%   Columns 76 through 90
% 
%     65    88    16    40   111   118    21   103    95     9    53    63    96    67    34
% 
%   Columns 91 through 105
% 
%     55    71    72    29    81    80    35    28    84    45    41    97    92    98    66
% 
%   Columns 106 through 120
% 
%     54    77   106    73    58    31     7    48    89    57    17    38    78    60   112
% 
%   Columns 121 through 122
% 
%      8   117

%aplha 1 poli 10
% Columns 1 through 15
% 
%    113     4    45    33   117    56    87    43    42    69    15    39   119    12   118
% 
%   Columns 16 through 30
% 
%    121    37     7    18    14    52     3   116    51   109    21    63    65   111    25
% 
%   Columns 31 through 45
% 
%     66    20    91   101    31    27    30    82     6   105   122    74    96    35    81
% 
%   Columns 46 through 60
% 
%     94    55    34    40    53    41    78    49    46    36    79    17   106   103    44
% 
%   Columns 61 through 75
% 
%     23    54    84   100    59    32    77   108    67    73    85   107    62    97    11
% 
%   Columns 76 through 90
% 
%     48    60    80    29   112    24     5    88    58    90     1     2    38    22    86
% 
%   Columns 91 through 105
% 
%     10    83   120   104    71    70    93    98   110     8    76    57   114    47   115
% 
%   Columns 106 through 120
% 
%     72    61    99    89   102    64    92    95    16    75    13    50    26    28     9
% 
%   Columns 121 through 122
% 
%     19    68

%aplha 2 poli 1
% Columns 1 through 15
% 
%    113    14     8     4    56   115   114    16    43    75    55    13    37   122     2
% 
%   Columns 16 through 30
% 
%    107    11    40     3    38    22    20    47    51    35    44   117    12    68    88
% 
%   Columns 31 through 45
% 
%     15    21    96    80   101    59    30    46    42    77   109    78    87    27    19
% 
%   Columns 46 through 60
% 
%     73    65    81    52    23    79    91   121    86    85   110   111   100    83   104
% 
%   Columns 61 through 75
% 
%    105    92    90   103   102    72     6    48    32    17    41    71    70    24    39
% 
%   Columns 76 through 90
% 
%     82   116    31    62    10    98    64    66    76    57    89    33    60   118     7
% 
%   Columns 91 through 105
% 
%    120    63    95    94    18    61    93    25    84    36    29    97     9   106    74
% 
%   Columns 106 through 120
% 
%    108    26   112    50    34     5     1    54    53   119    45    67    99    49    58
% 
%   Columns 121 through 122
% 
%     69    28


% aplha 2 poli 2
% Columns 1 through 15
% 
%    113     4    56    42   115   114     6    36    87    43    30     3    14   119    37
% 
%   Columns 16 through 30
% 
%     22    15    88   122    13    55    75    33     1    44    40    20    48    63    78
% 
%   Columns 31 through 45
% 
%     72   110   117    70    91   101    38    11    77    80   109    24    35    59    50
% 
%   Columns 46 through 60
% 
%     26    73    74    25     8    12    34    68   121   112     9    52    19   120     7
% 
%   Columns 61 through 75
% 
%     65    76    58    27    98    66    95   105   111   118    39    51   116    47    90
% 
%   Columns 76 through 90
% 
%     67   103    49   104   106    97    28     2    64   100    45    53    54    83    61
% 
%   Columns 91 through 105
% 
%     17    18    16    62    94    86    10    71    29    31   102    99    79    81    82
% 
%   Columns 106 through 120
% 
%     32    69     5    21    85    46    93    84    60    89    57    96   108    92   107
% 
%   Columns 121 through 122
% 
%     23    41


%   aplha 2 poli 3
% 
%   Columns 1 through 15 
% 
%   
% 
%    113     4    56    24    31    15    33    47    87   114     6   121    43    14   117 
% 
%   
% 
%   Columns 16 through 30 
% 
%   
% 
%     55    77    46   115    13    22     1    42    39   119    40    11    19    78    44 
% 
%   
% 
%   Columns 31 through 45 
% 
%   
% 
%     63   108    50    10    36   106    70   107    97    65   104    66    30    95   110 
% 
%   
% 
%   Columns 46 through 60 
% 
%   
% 
%     18    17    80    72    34    73    88    75    52    59    29    51    26   109    38 
% 
%   
% 
%   Columns 61 through 75 
% 
%   
% 
%    116     2    12     3    69    20     8    74    83    32    96   120     5    85    90 
% 
%   
% 
%   Columns 76 through 90 
% 
%   
% 
%      7    60    57    89    58    98   103    45    62   111    37    41    21    94    82 
% 
%   
% 
%   Columns 91 through 105 
% 
%   
% 
%    118    79    68    67   100    99    84    91    27    25    61    93   105    81    16 
% 
%   
% 
%   Columns 106 through 120 
% 
%   
% 
%     48    28    71    76   102    23    53    86   122     9    64    35    92    54   101 
% 
%   
% 
%   Columns 121 through 122 
% 
%   
% 
%     49   112 


%   aplha 2 poli 4
% Columns 1 through 15
% 
%    113     4    56    24    43    33     3    87    15    14    76   114    10    50    22
% 
%   Columns 16 through 30
% 
%     40     9    42    29    27    39   119    12   115    37     7    34    19    16    41
% 
%   Columns 31 through 45
% 
%     51     1    44     5    49    66    65     8    52   102    81    17     2   116    35
% 
%   Columns 46 through 60
% 
%    110    85    67    86    26    30    69   121    70   105   109    53    68    55    18
% 
%   Columns 61 through 75
% 
%     31   101    89   104    36    95    71    83    91   106    74    32    93    62    60
% 
%   Columns 76 through 90
% 
%     97    63   107    79   120    75    77    11    61    99    88     6    80   111    84
% 
%   Columns 91 through 105
% 
%     45    21   103   118   122    57    78    20    96   117    73    59    90    28    25
% 
%   Columns 106 through 120
% 
%     82    58    92    98    64   112    94    38    72    48    23    54    46   100    13
% 
%   Columns 121 through 122
% 
%     47   108


%   aplha 2 poli 5
% Columns 1 through 15
% 
%    113     4    35    24    56    43   119    20    87    36   114    86    13    80    19
% 
%   Columns 16 through 30
% 
%     50     2    22    55    39    76    11    30    42    44    40    26    51    45    78
% 
%   Columns 31 through 45
% 
%     73   115   116    82   121    14     7    63    52     1   110    15     9    37    53
% 
%   Columns 46 through 60
% 
%     90   103    69    75    57    59   105    33    83    32   109    97    34    21    47
% 
%   Columns 61 through 75
% 
%     84    29    79    99    16    18    54    71     5   120    10    25    67    95    81
% 
%   Columns 76 through 90
% 
%    101    62   100     3   107    91    28    85    61    65    27    88   118   111    93
% 
%   Columns 91 through 105
% 
%     94    89     6   122    23    58   106   112    41    96    66    77    48    92   104
% 
%   Columns 106 through 120
% 
%     31    70     8   102    49    72    98    12   117    74   108    46    60    68    64
% 
%   Columns 121 through 122
% 
%     38    17


% aplha 2 poli 10
% 
% Columns 1 through 15
% 
%    113     4   100    56   117    42    87    36    15    43    44   121    33   114    50
% 
%   Columns 16 through 30
% 
%    104    40     9    69     3    16    84    30    55    88    58    78    51    34    29
% 
%   Columns 31 through 45
% 
%     39    72    86    31    60   107    54   122    68    66    47    11    35    81    49
% 
%   Columns 46 through 60
% 
%     52   118    19    13    90   103   109    21   110    95    37    18    64    97    63
% 
%   Columns 61 through 75
% 
%     82    94    59    45   112   111    91    20   119    23    27    75    93     7    32
% 
%   Columns 76 through 90
% 
%     67    14    62     5    10    41    85   115     1     8     2    53   105    77    70
% 
%   Columns 91 through 105
% 
%     65   106    17    83    71   101     6    46    57    73    98    92   108    61   116
% 
%   Columns 106 through 120
% 
%     22    99    96   120    12    24    48    25    76    79   102    80    89    74    38
% 
%   Columns 121 through 122
% 
%     26    28

