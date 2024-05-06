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
        
        pos_antes = 1:dim2;
        todo_all_possible = 1:dim2;
        
        for i = 1:dim2
            for j = 1:length(todo_all_possible)
                pos_antesaux = pos_antes;
                pos_antesaux(j) = [];
                pos = pos_antesaux;
                Xnow = X(:,pos);
                warning off
                f = model(Xnow,Y(:,chosen_output),orden_poli);
                error_par_aux(j) = mean(abs(Y(:,chosen_output)-f).^alpha);
            end
            
            error_par = max(error_par_aux);
            pos_err_max = find(error_par_aux == error_par);
            nowotropos = find(pos_antes == todo_all_possible(pos_err_max));
            pos_antes(nowotropos) = [];
            pos_fin(i) = todo_all_possible(pos_err_max);
            todo_all_possible(pos_err_max) = [];
            clear error_par_aux
            
            Xnow2 = X(:,pos_fin);
            f = model(Xnow2,Y(:,chosen_output),orden_poli);
            error_parOK(i) = mean(abs(Y(:,chosen_output)-f).^alpha);
        end
        
        V = [mean(abs(Y(:,chosen_output)).^alpha) error_parOK];
        plot(0:dim2,V,'o-', 'DisplayName', ['alpha=' num2str(alpha) ', orden_poli=' num2str(orden_poli)])
        
        % Almacenar los resultados en la tabla
        results{counter,1} = alpha;
        results{counter,2} = orden_poli;
        results{counter,3} = error_parOK;
        results{counter,4} = pos_fin;
        counter = counter + 1;
    end
end

hold off
legend

% Mostrar la tabla de resultados
disp(results)

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%% output 1 %%%
 %a=0.1%113   114    14    20    18    11     6    68    17    29    44   106    48    38    13    70     3 
 %a=0.5%113   114    14    20    18   119    17    56    88    12    13    21     7    38     3     8     9 
 %a=1  %113   114    14    20    18   119    13    12     9     8    21     3    15    56    88     4     7
 %a=2  %114   113    14    20    18   119    13    12     9     8    21     3    15   118    56    88     4
 %a=3  %114   113    14    20    18   119    13    12     9     8    21     2    88    87    15   117   122

 %orden poli=2 alpha=1
%   Columns 1 through 15
% 
%    113   114    22    14   117    16    20    88     8     4    38     3    11    10     6
% 
%   Columns 16 through 30
% 
%     56   116    65    37    85    29    36    51     2   119    39    13     9    12    21
% 
%   Columns 31 through 45
% 
%     15    50     7    28   102    23   122    87   121    53    86   106   111    31    52
% 
%   Columns 46 through 60
% 
%    118    17    27    18    19    25    40    63    99   103    30    47   112   105    61
% 
%   Columns 61 through 75
% 
%    108    71    69    78    64    95    26     5    76    42    55    24    83    33    62
% 
%   Columns 76 through 90
% 
%     89    81    32    44    90    48    45    75    54    82    41    43    46    49     1
% 
%   Columns 91 through 105
% 
%    115    96    35   109    97   104    34   110    73    79    94    84    77    60    58
% 
%   Columns 106 through 120
% 
%    100    93    57    59    91    92    70   107   101    68    80    98    72    74    67
% 
%   Columns 121 through 122
% 
%     66   120

 %orden poli=3 alpha=1
%   Columns 1 through 15
% 
%    113   114   116     4    22    11     3    97    56    33    24    10    88    30    20
% 
%   Columns 16 through 30
% 
%     16    14     6    21     2    15   109    12    13     9    37   117    87   122    23
% 
%   Columns 31 through 45
% 
%      8   121    25    79    52    62    32    50    51    38    39    29    28   111    17
% 
%   Columns 46 through 60
% 
%    118    18   101    19    85   103     1   115   119     7    27    68   105    47    53
% 
%   Columns 61 through 75
% 
%     41    86     5    99    63    98    26    40    31    42    44    54    69    43    45
% 
%   Columns 76 through 90
% 
%     95    65    76   108    64    71    34   106   107    75    46    55    67   120    58
% 
%   Columns 91 through 105
% 
%    110   112    36    77    49    48    35   100    90    60    82    84    92   102    61
% 
%   Columns 106 through 120
% 
%     94    81    59    93    72   104    57    96    83    91    89    70    80    78    74
% 
%   Columns 121 through 122
% 
%     73    66

%orden poli 4 aplha 1
%   Columns 1 through 15
% 
%    113   114    29    39    56    14    11     4    38    91    33    50   117   109   106
% 
%   Columns 16 through 30
% 
%     36   120    52     1   115   116     2    51    20    16    18     6    10    21    22
% 
%   Columns 31 through 45
% 
%      8    24    13     3    85    17    28     9    15    88    25    87   122    37    19
% 
%   Columns 46 through 60
% 
%     63    12   119     7    34    65    44    23    30    86    73     5    41    27    53
% 
%   Columns 61 through 75
% 
%     74   118   107    26   110    69   121    98    31    42    40    43    32   102    71
% 
%   Columns 76 through 90
% 
%     54    81    76   101    45    47    46   112    95    97    64    96   108    55    62
% 
%   Columns 91 through 105
% 
%     68    75    77    61    57    82    94    60    49    48    35    79    66    59    93
% 
%   Columns 106 through 120
% 
%    103    84    80   100    58    90    89    72    92    83   105   111    70   104    99
% 
%   Columns 121 through 122
% 
%     67    78
%ordenpoli 5 alpha 1
% Columns 1 through 15
% 
%    113   114    50    15     4    62    93    11    17    41    74    54     5    28     1
% 
%   Columns 16 through 30
% 
%    115    20    14   116     2    51    18    16   117     8    82    37    40    88     6
% 
%   Columns 31 through 45
% 
%     10    22    21    56    24     3     9    26    38    35    85    87   122    13    12
% 
%   Columns 46 through 60
% 
%     23   119    19     7    52    63    55   120    65    29    31   109   101    45    39
% 
%   Columns 61 through 75
% 
%     69    43    47    27   105    68    42    25    30    34   103    44    86   112    46
% 
%   Columns 76 through 90
% 
%     33    98    75   121    32    99    95    94    53    96    76   108   111    36    64
% 
%   Columns 91 through 105
% 
%    118    81    48    49    97    71    73    78    60    77   102    92    84    58    90
% 
%   Columns 106 through 120
% 
%     59    57    89    91   106    80    61    83    70    72    79   107   110    67   100
% 
%   Columns 121 through 122
% 
%    104    66
%ordenpoli 10 alpha 1
% 
%   Columns 1 through 15
% 
%     72    99    69   105    89    42    44   122    29   114     6     7   104    41    96
% 
%   Columns 16 through 30
% 
%    102    57    77    19    43    14    59    45    31   106    58    38    46    51    55
% 
%   Columns 31 through 45
% 
%    113    35    52    82    26    22    90    21    88    54    81    97   117    18    92
% 
%   Columns 46 through 60
% 
%     67    50    85    71    24    63     3    37    56    34    30    23    87    10    15
% 
%   Columns 61 through 75
% 
%     16     4    20   118   121     9     8    66    28    86    25    27    78    13   119
% 
%   Columns 76 through 90
% 
%     12    17     2     5    53   100    48   103    33   112    49    76    74    47    39
% 
%   Columns 91 through 105
% 
%     40    94   108    32    36   120    64    68   111    65    91    83    93    11    70
% 
%   Columns 106 through 120
% 
%     75    73    79   109   107   110   101    95    98    60   116    61    62    80    84
% 
%   Columns 121 through 122
% 
%    115     1

%alpha 2 ordenpoli 2

%   Columns 1 through 15
% 
%    113   114    22    14   117    88    56     4    11    38     3    20    16     6    10
% 
%   Columns 16 through 30
% 
%      8    85   116    51     2   119    13     9    12    21    15     7    50   102    37
% 
%   Columns 31 through 45
% 
%     39    97    35   105    23   122    87   121    53    86   120    29    31    17    18
% 
%   Columns 46 through 60
% 
%     19    27    52   108   111    67    95    69    89    57    34    71   103    40   118
% 
%   Columns 61 through 75
% 
%     76    94    64    78   112   101    25    28    26    63    55    24    42     5    33
% 
%   Columns 76 through 90
% 
%     75    65    49    41    81    43    44    45    47    46    48    60    82    54    90
% 
%   Columns 91 through 105
% 
%     93     1   115    96    58    66    59    91    30    79   100    92   109    62    83
% 
%   Columns 106 through 120
% 
%     32    61    99    98    36    70    80    68    72   107    77   110    74    73    84
% 
%   Columns 121 through 122
% 
%    106   104
%lpha 2 ordenpoli 3
%  Columns 1 through 15
% 
%    113   114   116    22     4    11    56    33    63    14   117    20    16    10    88
% 
%   Columns 16 through 30
% 
%      8     6     2    51    21    15    85    59    87   122    23    37   119    13     9
% 
%   Columns 31 through 45
% 
%    121    79    52    50    62    38    39    53     3   118    29    31    28     1   115
% 
%   Columns 46 through 60
% 
%     12    24    19    18    27    25    86     7   110    26   120     5    41    30   102
% 
%   Columns 61 through 75
% 
%     77    98   109   108    97    69    71    17   112    60   105   111    92    40    93
% 
%   Columns 76 through 90
% 
%     64    95    47    44    76    42    55    54    70    83    67    72    99    43    45
% 
%   Columns 91 through 105
% 
%     75    94    48    35    49    46    65    82    81    74    34   101    91    84    78
% 
%   Columns 106 through 120
% 
%     32    96    73   100    66    58    90    57    89    61    36    80    68   107   104
% 
%   Columns 121 through 122
% 
%    106   103
%orden poli=4 alpha=1
%   Columns 1 through 15
% 
%     22   113   114     4    11    56    15    33    97    14    10    25    38    39    37
% 
%   Columns 16 through 30
% 
%    109   116   117     2    51     8    16    88    50     6    20     1   115    18    24
% 
%   Columns 31 through 45
% 
%     21     3    17   120    13     9    12   119    19     7    52    34    85    29   122
% 
%   Columns 46 through 60
% 
%     87    23    44    86    31    27    30    41    26     5    54    63    65    69    55
% 
%   Columns 61 through 75
% 
%     53    40   101   112   108   103    71    59    95    77    28   121   118    42    81
% 
%   Columns 76 through 90
% 
%     98    76    64    96    70   105    62    43    32    45    47    46    78    68    94
% 
%   Columns 91 through 105
% 
%     67    75   111    49    48    35    72    93    60    82    84    90    58   102    74
% 
%   Columns 106 through 120
% 
%     92    57   110    66   107    36    89    80    61    83    91    99    79   100    73
% 
%   Columns 121 through 122
% 
%    104   106
%orden poli=5 alpha=1
% Columns 1 through 15
% 
%     62   113   114     4    15    50    81    29    18     2    22    56     1   115   116
% 
%   Columns 16 through 30
% 
%     51    20    16    14   117     3     8    13    12   119    21     9     6    19    11
% 
%   Columns 31 through 45
% 
%     10    38    17     7   120    52    55    31   118    63    65    85   109    34    42
% 
%   Columns 46 through 60
% 
%     37    39     5    26    44    43    88    75    66    24    25    27   122    87    23
% 
%   Columns 61 through 75
% 
%     86    53    33    40    30    35   121    28    41   104    69   101    95   110    98
% 
%   Columns 76 through 90
% 
%     32    54    45   102   105    83    47    36    46    77    64    76    71   112    68
% 
%   Columns 91 through 105
% 
%    108   111    82    96    67    48    49   100    80    94    58    60    93    84    90
% 
%   Columns 106 through 120
% 
%    106    72    59    57    74   107    92    78    61    97   103    89    99    91    70
% 
%   Columns 121 through 122
% 
%     79    73

%orden poli=10 alpha=1
% Columns 1 through 15
% 
%     72    99    69    89    37   103   122    48   120    45   116    88   101   100    14
% 
%   Columns 16 through 30
% 
%     81    58    90    40    56   106    27    51   110    76   113    62     2    35    25
% 
%   Columns 31 through 45
% 
%     54    43    16    15     7    75   114     4   118    32    85    95    63    11    22
% 
%   Columns 46 through 60
% 
%     53    38    23    30    87    96    31     3    19    73    24    39    28     5   117
% 
%   Columns 61 through 75
% 
%    121    55    50     6    10    86    18    20    52    17    65    29    59    42    33
% 
%   Columns 76 through 90
% 
%     44    78   112   111     8     9    21    13    26    49    66   119    12   102    36
% 
%   Columns 91 through 105
% 
%    108    91   104   105    97    80    68    57    74    94    71    47    46    34   109
% 
%   Columns 106 through 120
% 
%     77    64    83    61    92   107    67    98    82    41    79    93    60    70    84
% 
%   Columns 121 through 122
% 
%    115     1


