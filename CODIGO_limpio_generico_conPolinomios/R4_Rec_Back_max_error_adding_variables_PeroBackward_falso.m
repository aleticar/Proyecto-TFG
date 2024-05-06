clear all
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

alphas = [2];
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
        
        pos_antes = [];
        todo_all_possible = 1:dim2;
        
        for i = 1:dim2
            for j = 1:length(todo_all_possible)
                pos = [pos_antes todo_all_possible(j)];
                Xnow = X(:,pos);
                warning off
                f = model(Xnow,Y(:,chosen_output),orden_poli);
                error_par_aux(j) = mean(abs(Y(:,chosen_output)-f).^alpha);
            end
            
            error_parinv = max(error_par_aux);
            pos_err_max = find(error_parinv == error_par_aux);
            pos_antes = [pos_antes todo_all_possible(pos_err_max)];
            todo_all_possible(pos_err_max) = [];
            clear error_par_aux
        end
        
        pos_antes = pos_antes(end:-1:1); % inversion de la secuencia
        
        for j = 1:dim2
            pos = pos_antes(1:j);
            Xnow = X(:,pos);
            f = model(Xnow,Y(:,chosen_output),orden_poli);
            error_par(j) = mean(abs(Y(:,chosen_output)-f).^alpha);
        end
        
        V = [mean(abs(Y(:,chosen_output)).^alpha) error_par];
        plot(0:dim2,V,'o-', 'DisplayName', ['alpha=' num2str(alpha) ', orden_poli=' num2str(orden_poli)])
        
        % Almacenar los resultados en la tabla
        results{counter,1} = alpha;
        results{counter,2} = orden_poli;
        results{counter,3} = error_par;
        results{counter,4} = pos_antes;
        counter = counter + 1;
    end
end

hold off
legend

% Mostrar la tabla de resultados
disp(results)

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  %%%%%%% output 1  %%%%%%%%%%%
  %a=0.1%113   114    14     1   115    50   116    51     2    20    18   119    12    13     3     9     8
  %a=1  %113   114     1   115    50   116     2    51    14    20   119    12     8    13     9    21   117
  %a=2  %114   113     1   115    50   116    51     2    14    20    18   119    13    12     9     8     3
  %a=3  %114   113     1   115    50   116    51     2    14    20   119    13    12     8     9    21     3
  %a=4  %114   113    14    20   119    13    12     8     9    21     2    88    87   122   116    51     6
  %a=5  %114   113    14    20   119    13    18     9     2    12    51   116     8   117    21    15    87
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
  %%%%%%% output 2  %%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %a=0.1%113   114    14    20   115     1     2   116    51    50    18     9    13     3    34   119   101
 %a=1  %113   114    14    20    50    51     2   116     1   115    18     9    13     3   119    19    17
 %a=2  %114   113    14    20    50     1   115   116    51     2    18     9    13     6     3     4    19
 %orden poli 2 alpha 1

%   Columns 1 through 15
% 
%    113   114   115     1    50   116     2    51    14    20   119    12    18     8    13
% 
%   Columns 16 through 30
% 
%      9    21   117    15    11    88    23    87   122     6     4     3    19    16    27
% 
%   Columns 31 through 45
% 
%     56     7    85    29    86    25    38   118    53    31    33   121    47    10    42
% 
%   Columns 46 through 60
% 
%     37    40    39    17    26    41    44    43    45    46    65    64    48    49    69
% 
%   Columns 61 through 75
% 
%     89   112     5    98   108    95    91    90    94    93    92    59    22    72    96
% 
%   Columns 76 through 90
% 
%     97    57    58    67    28    75   102    70    35    62    36    61    83   100    80
% 
%   Columns 91 through 105
% 
%     99    81   109    24    32    63    52    30    54   105    82    77   101   110    74
% 
%   Columns 106 through 120
% 
%     79    78    34   107    76    60   106    66    68   103   104    71   111    73    84
% 
%   Columns 121 through 122
% 
%     55   120

 %orden poli 3 alpha 1
%   Columns 1 through 15
% 
%    113   114     1   115    50   116     2    51    20    14    12   119     8    13    21
% 
%   Columns 16 through 30
% 
%     22    18   117     9    15     4     6   122    88    87    23    11    19   118     3
% 
%   Columns 31 through 45
% 
%     25    16    85    29    38    44    37    58    39    56    27    42    41    40    17
% 
%   Columns 46 through 60
% 
%     31    47    43    46    45    53   111    99    68    48    97    49    69    86    33
% 
%   Columns 61 through 75
% 
%     90    98    64    95    61    59    62    92   108    91    89   120    77     5    75
% 
%   Columns 76 through 90
% 
%     74   109    76    26    35    72    36    57    93    65    82    83    70   102    52
% 
%   Columns 91 through 105
% 
%     63    10   121    80   112    28    81    54   105    96    55   110    30    32    79
% 
%   Columns 106 through 120
% 
%     78   101   107    34   106    73   103   104   100    67    84    71    24    94    66
% 
%   Columns 121 through 122
% 
%     60     7


%orden poli 4 alpha 1
%   Columns 1 through 15
% 
%    113   114     1   115   116    50     2    51    14    20   119    12    16    18     4
% 
%   Columns 16 through 30
% 
%     21    13     6     9   117    15     8    19    23    88   122    87    37     3   118
% 
%   Columns 31 through 45
% 
%     17    38    11    56    52    63    22    85    31    29    65    25    27    69   101
% 
%   Columns 46 through 60
% 
%    103    47    45     5    41    28    86    53    39    43    42    40    44   120   109
% 
%   Columns 61 through 75
% 
%     33    35    48    46    49    26    95    71   108    76   112    10    64    55    60
% 
%   Columns 76 through 90
% 
%     98    81   106    62    61    90    67    77    75    36    92    58    96    59    89
% 
%   Columns 91 through 105
% 
%     57    74    80    68    72    93    91    82   121   111    83   105    99   102   110
% 
%   Columns 106 through 120
% 
%    100   107    73   104    32    30    54    70    34    97    79    84    24    78    94
% 
%   Columns 121 through 122
% 
%      7    66
%ordenpoli 5 alpha 1
% Columns 1 through 15
% 
%    113   114    50     1   116   115     2    51    14    20    12   119     8    22    21
% 
%   Columns 16 through 30
% 
%     13     9    18    15   117    19     6     4    16     3    17    52    63    65    38
% 
%   Columns 31 through 45
% 
%     29    85    87    37   118    31   122    88    23    56   101    69    11    25    47
% 
%   Columns 46 through 60
% 
%     27    81   109    26    39    40    41    42   120     5   121    53    43    86    33
% 
%   Columns 61 through 75
% 
%     28    44    95    45    96    46    59    71   108    76    64    48    49    10    55
% 
%   Columns 76 through 90
% 
%     92    60    98    62    97    58    90    89    57    83   111    67    35    68    75
% 
%   Columns 91 through 105
% 
%     82    61    91    36   105    93    99    30    32   102    70    34    80    78   112
% 
%   Columns 106 through 120
% 
%    106    77    72    24    54    74   110   107    84    94    79   100   103   104    73
% 
%   Columns 121 through 122
% 
%     66     7
%ordenpoli 10 alpha 1
% Columns 1 through 15
% 
%    115     1    51   113    50   114     2   116    24    14   119    20    12     8    15
% 
%   Columns 16 through 30
% 
%      4    16     3    18    21    19   117     9    22    13     6    64    65    59    17
% 
%   Columns 31 through 45
% 
%     97    38    41    52   118    11    85    32    66    47   109    62    39    43   112
% 
%   Columns 46 through 60
% 
%     91    56    95    67    37    61    69    31     5    92    29    45    27    49    48
% 
%   Columns 61 through 75
% 
%     40   101    42    28    44    46    33    82    26    35    36    55    58   107    89
% 
%   Columns 76 through 90
% 
%     90    57    71    93    73   120   122    87    53    88    25    23    98    30    75
% 
%   Columns 91 through 105
% 
%     83    96    86    76   108   121   102    60    63    54    81    10    80    34    70
% 
%   Columns 106 through 120
% 
%     99    78    68    79   105    77   110    94   111    74   104   103   106    84    72
% 
%   Columns 121 through 122
% 
%    100     7

%ordenpoli 2 aplha 2 
%  Columns 1 through 15
% 
%    113   114     1   115    50   116     2    51    14    20   119    12     8    13     9
% 
%   Columns 16 through 30
% 
%     19    18    11    21   117    15    88    23   122    87     6     4     3    38    16
% 
%   Columns 31 through 45
% 
%     85    22     7    25    29   118    86    27    56    53    31    33    26    47    39
% 
%   Columns 46 through 60
% 
%     37    17    42    40    44    41    43    45    46    65    64   112    48    49    28
% 
%   Columns 61 through 75
% 
%     70    89     5    95    74    61    99    62    98    90    92    91    77    75    57
% 
%   Columns 76 through 90
% 
%     59    76    58    68    72    10    80    79    35    78    73   109    83   101    81
% 
%   Columns 91 through 105
% 
%     63    36    93    96    32    82   110   107    69   102    30    97   105    34   108
% 
%   Columns 106 through 120
% 
%     94    54   121    24   100    67    55    71    52    84    60    66   106   103   111
% 
%   Columns 121 through 122
%    104   120

%ordenpoli 3 aplha 2
%   Columns 1 through 15
% 
%    113   114     1   115    50   116     2    51    14    20   119    12     8    13    21
% 
%   Columns 16 through 30
% 
%     22    18   117     9    15     4    19     6    11   122    88    87    23     3   118
% 
%   Columns 31 through 45
% 
%     85    16    25    29    27    56    33    31    86     7    53    38    44     5    47
% 
%   Columns 46 through 60
% 
%    102    90    58    77    26    39    28    40    97    37    17    42    43    41    45
% 
%   Columns 61 through 75
% 
%     46    48    49   112   110    74    62    64    35    76    75    95    61    89    99
% 
%   Columns 76 through 90
% 
%     91    92    59    65    57    70    72    93    36   108    80    68    82    98   105
% 
%   Columns 91 through 105
% 
%     78    79    73    63    83    81    10    32    94    96    69   111   107    34    55
% 
%   Columns 106 through 120
% 
%     84    30    71   100    54    24   121   106   104   103    52   120    67   101   109
% 
%   Columns 121 through 122
% 
%     66    60
%ordenpoli 4 aplha 2

%   Columns 1 through 15
% 
%    113   114     1   115   116    50     2    51    14    20   119    12    16     4    22
% 
%   Columns 16 through 30
% 
%     21     8    13     9    19     6   117    15     3    18    17    52   122    87    88
% 
%   Columns 31 through 45
% 
%     85    38    11     7    23    56    29    25    27    86   118    37    39    44    63
% 
%   Columns 46 through 60
% 
%     47    98    61   111    99    68    96    62    97    90    91    57    92    95    26
% 
%   Columns 61 through 75
% 
%     53    31    41    45    43    33    40    42    48    49    46    28    24    30     5
% 
%   Columns 76 through 90
% 
%    108    89    77    32    75    72    76    55    74    73    35    70    94    82    58
% 
%   Columns 91 through 105
% 
%     93    80    78    36    59    65    64   112   110   105    54   102    83    81   121
% 
%   Columns 106 through 120
% 
%     10    79    69    84    34   107   100    71    67   106   104   103   101   120    60
% 
%   Columns 121 through 122
% 
%     66   109
%ordenpoli 5 aplha 2

%   Columns 1 through 15
% 
%    113   114    50     1   115   116     2    51    14    20    12   119    18    22    19
% 
%   Columns 16 through 30
% 
%     21     8    13     9   117     4     6    17    52     3    38    37   118    88    87
% 
%   Columns 31 through 45
% 
%    122    85    15    16    11    23    56    29    25    27    86    63    94    62   112
% 
%   Columns 46 through 60
% 
%     59    91    65    64    69    99    93    92   109    90    98    58    28    47    41
% 
%   Columns 61 through 75
% 
%     39    53     5    33    31    40    42    48    43    44    45    46    49    95   108
% 
%   Columns 76 through 90
% 
%     76    26    10   121   111    55    35   120    54    57    68    72    30    75    32
% 
%   Columns 91 through 105
% 
%     89    77    36    74    61    96    67    80    70   102    83    81    82    34    24
% 
%   Columns 106 through 120
% 
%    105    97    73    78   110   100   101     7    79   107   106   104   103    84    71
% 
%   Columns 121 through 122
% 
%     60    66
%ordenpoli 10 alpha 2 
% lumns 1 through 15
% 
%    115     1    51   113    50   114   116     2     4    14    16    20    12   119    18
% 
%   Columns 16 through 30
% 
%     10    15   117    19    22    21     8     9    13    11    86    65   121    38   104
% 
%   Columns 31 through 45
% 
%    122    85   118   112    31    94    62     3    27    59    91    26    37    63    69
% 
%   Columns 46 through 60
% 
%      6    52    23    57    66    80    29    25    88    56     5    87    28   110   108
% 
%   Columns 61 through 75
% 
%     53    71   111    96    90   102    41    39    40    42    64   120    76    33    97
% 
%   Columns 76 through 90
% 
%     58   105    55    17    89    35    95    93    24    47    46    92    82    61    36
% 
%   Columns 91 through 105
% 
%     75    45    43    67    44    48    49    60    98    81    84   106    83    54   103
% 
%   Columns 106 through 120
% 
%     32    30    34   100    68    72   107     7    78    77    70    99    79    73   101
% 
%   Columns 121 through 122
% 
%    109    74