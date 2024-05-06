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
            
            error_par(dim2-i+1) = min(error_par_aux);
            pos_err_min = find(error_par_aux == min(error_par_aux));
            nowotropos = find(pos_antes == todo_all_possible(pos_err_min));
            pos_antes(nowotropos) = [];
            pos_fin(dim2-i+1) = todo_all_possible(pos_err_min);
            todo_all_possible(pos_err_min) = [];
            clear error_par_aux
        end
        
        V = [mean(abs(Y(:,chosen_output)).^alpha) error_par];
        plot(0:dim2,V,'o-', 'DisplayName', ['alpha=' num2str(alpha) ', orden_poli=' num2str(orden_poli)])
        
        % Almacenar los resultados en la tabla
        results{counter,1} = alpha;
        results{counter,2} = orden_poli;
        results{counter,3} = error_par;
        results{counter,4} = pos_fin;
        counter = counter + 1;
    end
end

hold off
legend

% Mostrar la tabla de resultados
disp(results)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% output 1  %%%%%%%% %%%%%%%% %%%%%%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%a=0.1%113   14     8   115   114    56    15    18    23    11    13    77    38   110    48    78  68
%a=0.5%113   14     8   115   114    56     4    43    13   107   117    11    23    55    38    77  46   
%a=1  %113   14     8   114   115    56     4    43    18    13   107    55    11    88    77    38   3
%a=2  %113   14     8   114   115     4    56    18    13    11   122    43   107   116    55   117  38
%a=3  %113   14     8   114   115     4    56    13    11    43   107    19   122   116    27    15  51
%a=5  %14     8   113   114   115    56    18     4   116    13    11   122    43   107    52    20  86
%a=6  %14     8   113   115   114    18     4   116    43   107    13    11   122   120     1    77  38
%a=10 % 8    14   113   115   114    18     4   116    43   122   120    13   107    11     1    46  77
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% output 2  %%%%%%%% %%%%%%%% %%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%a=0.1%114    1   113   110    15     9    79     3    62    94    49    47    31    70   101    12  14
%a=0.5%114    1   113    40    15    12    14   101    67    79    94    62    70     3    58    90  52
%a=1  %114    1   113   110     3    79    94    62    52    72    12    14    40    15    10   101  91
%a=2  %114    1   113     3   110    79    72    52    40    12    20    94    62    23    21    47  49
%a=3  %114  113     1     3   110    79    94    62    40    15     9    12    20    47    49   122  11
%a=4  %114  113     1   105   118    12    40    94    79    62    20    23    21     7    44    47  49
%a=5  %114  113     1    49    47    40    79    72    29   103   117   104   105    33    15     9 118
%a=6  %114  113     1   105   118    49    47     8    20    65    97    79    44     9    21    23   7
%a=10 %114   20    40    12    50     1     4   122    79    73    11     9   118     2     7   116  57
 
%alpha 2 ordenpoli 2
%  Columns 1 through 15
% 
%    113     4    14   119    56   114   115    36    43    88    15   120   118    57    47
% 
%   Columns 16 through 30
% 
%     98    40    39    42    44    22    90    58    89    20    12     1    59    38   121
% 
%   Columns 31 through 45
% 
%    100    74    73   109    97    35    66    65    49     8    78    52     3    24    11
% 
%   Columns 46 through 60
% 
%     95    19     9     7    62    94   103   102    70    29    50    51     2   106    26
% 
%   Columns 61 through 75
% 
%     55     6   101    27    63    76    80    67    79    16    18   116    17    84    69
% 
%   Columns 76 through 90
% 
%     53    72   104    71   112   122    33    31    86    28    30   105    37    61    45
% 
%   Columns 91 through 105
% 
%     54    82    81    10    34    48    32    91    60     5    21    46    68    96    87
% 
%   Columns 106 through 120
% 
%     83    85   111    99    75   117    25    77   110   108    64    13    93    92   107
% 
%   Columns 121 through 122
% 
%     23    41


% %alpha 2 ordenpoli 3
% Columns 1 through 15
% 
%    113     4    56    14   119    22    43    88   120    15   115   116   114    51     1
% 
%   Columns 16 through 30
% 
%     65    97   104   110   118     7    12    68   100    37    95    91    63    30    78
% 
%   Columns 31 through 45
% 
%     62   109   103    99   111    39    40    33    10    75    84    80    16    18    31
% 
%   Columns 46 through 60
% 
%     85    27    19   122    86    26    67    79    29    87     3     2   107    61    93
% 
%   Columns 61 through 75
% 
%    105    48    60    13    11    34     6    96    69    25    73    55    74    90    66
% 
%   Columns 76 through 90
% 
%     57    59    24    77    41    83    28    21   117    89    46    81    47    17    52
% 
%   Columns 91 through 105
% 
%      5    20    72     8    32    50    36    82    23    76   102    98     9    58    71
% 
%   Columns 106 through 120
% 
%     92    35    64   108    42    45    94    53   106    54   121    70    44   101    38
% 
%   Columns 121 through 122
% 
%     49   112
%alpha 2 ordenpoli 4
% Columns 1 through 15
% 
%    113     4    56   119    14    43   114    50    31    86    19   120    40    39    65
% 
%   Columns 16 through 30
% 
%    115     1    51    33   104   106    12    15    55    61    93     3    89    91    76
% 
%   Columns 31 through 45
% 
%     29   109     2   116    68    36    71   110    52    87    22   112    84    69   105
% 
%   Columns 46 through 60
% 
%     79    16     6    41    11    17    95    85    26     5    37    24   103    90    21
% 
%   Columns 61 through 75
% 
%      7    60    99    30    98    97    77    62    64    34     9   117    45    74    66
% 
%   Columns 76 through 90
% 
%     46    58    81     8    20    82   121    53    75    94    10    83    67    92   107
% 
%   Columns 91 through 105
% 
%     32   101    44    27   111    88    25    63   118    28    80    57    72    54    96
% 
%   Columns 106 through 120
% 
%    100    73   122    42    70    23    48    78    38    49    13    35    47    59    18
% 
%   Columns 121 through 122
% 
%    102   108

%alpha 2 ordenpoli 5
% olumns 1 through 15
% 
%    113     4    56    43   119    87   114    75    14    50   115    51    11   120    24
% 
%   Columns 16 through 30
% 
%     39    37   118    40    22    15    10    78    95    97    65    63   107   109   116
% 
%   Columns 31 through 45
% 
%      2    33    52    79    34   101    29    57    81    67    82   105   103    99    55
% 
%   Columns 46 through 60
% 
%     59    88    26    77    85    80    61     3    19    16     1    84     9    28     7
% 
%   Columns 61 through 75
% 
%     62   106    58    89    41    53    66    31    96    68    42    60    64    30   117
% 
%   Columns 76 through 90
% 
%     86    18    90    32    93    73    71    45    44    94   110    54    47    23    72
% 
%   Columns 91 through 105
% 
%    122     5    36     8   111    98    48    69    27    70   121   100    12    21    83
% 
%   Columns 106 through 120
% 
%    102     6   108    74    91    25    92    49   104    17    38    13    20    76   112
% 
%   Columns 121 through 122
% 
%     35    46

%   alpha 2 ordenpoli 10
% 
%   Columns 1 through 15 
% 
%   
% 
%    114    22    51     4   119    34    56    69   111    21    96    26    93    44    55 
% 
%   
% 
%   Columns 16 through 30 
% 
%   
% 
%     89    61    31    98    94    37    45   105    14   104   100    12     8    78   107 
% 
%   
% 
%   Columns 31 through 45 
% 
%   
% 
%     57    11    73   117    40    36    49    46    48    39    35    81    70    85    19 
% 
%   
% 
%   Columns 46 through 60 
% 
%   
% 
%    106   103    83    79    71    33    58     2    10   101   109   121    68    18     1 
% 
%   
% 
%   Columns 61 through 75 
% 
%   
% 
%    116    59   115    13    64    75    20   122     6    84    60    25    16   108   102 
% 
%   
% 
%   Columns 76 through 90 
% 
%   
% 
%     29    95     3    32   110    23    65    87    62    97    90    82    72     5     9 
% 
%   
% 
%   Columns 91 through 105 
% 
%   
% 
%     30    74    53     7    92    88    41    47    76    77   120   118   113    66    80 
% 
%   
% 
%   Columns 106 through 120 

% 
%     91    17    24    27    52    43    28    67    99    15    38    86    54   112    42 

%   Columns 121 through 122 
%
%     50    63 

%   alpha 1 ordenpoli 2
% Columns 1 through 15
% 
%    113   114   119     1    56     4    14    43    89    88     3    40    22    15   120
% 
%   Columns 16 through 30
% 
%     12   117    48    87    45    42    11    80    58    90   112   100    59    24     8
% 
%   Columns 31 through 45
% 
%     97    74   121    50    82    79   109     5   118     7    51    94    39    33    57
% 
%   Columns 46 through 60
% 
%     34    60   107    73    68    72    78    52    98    62    76    64    49   103   106
% 
%   Columns 61 through 75
% 
%      9    30    66    44    19    38    69    26     2    16    77    20   105    61    28
% 
%   Columns 76 through 90
% 
%     55    27    35   104   101    71    37    18     6    36    47    67    70    53    63
% 
%   Columns 91 through 105
% 
%     65    96    86   108    81    32    84    17    21   102   111   110   116    92    83
% 
%   Columns 106 through 120
% 
%     23    85    31    75    41    93    10    99    13    46    25   115    29    54   122
% 
%   Columns 121 through 122
% 
%     91    95

% alpha 1 ordenpoli 3

%  Columns 1 through 15
% 
%    113     4    56    14   119    22    43    88   110    65    97    68   100   120    15
% 
%   Columns 16 through 30
% 
%    118    11    55   104    12     7   116   115    63    73    99    67   109    30    10
% 
%   Columns 31 through 45
% 
%     62    78    19    40    39    16   111     9    59     8    31   103    51    20    95
% 
%   Columns 46 through 60
% 
%     85    33    26    29    57    37    83    74    77    79    17    75    98    90     3
% 
%   Columns 61 through 75
% 
%     96    93    60     1    48    41    34    80    52     5   114    24   107    25    72
% 
%   Columns 76 through 90
% 
%     69   105    61    32    45    44    91   122    46    89    36    42     6    23    49
% 
%   Columns 91 through 105
% 
%     76    81    50    94   102    58    21    13     2    35   117    18    84    66    71
% 
%   Columns 106 through 120
% 
%    108    82    70   106    47    92    38    87   112    64   101    28    54    53   121
% 
%   Columns 121 through 122
% 
%     86    27


% alpha 1 ordenpoli 4
% Columns 1 through 15
% 
%    113     4    56   119   114    50    43    87    69    14    86   120    19    33    40
% 
%   Columns 16 through 30
% 
%     12    36     8    15    68    74    85   104    89    78    30    10    57    27    76
% 
%   Columns 31 through 45
% 
%     16   109    71    22     3     2   116    21   103    20    97    65    11    95    84
% 
%   Columns 46 through 60
% 
%     90   112    39    45   105     6   117    51   110    31    98   111    99    46    37
% 
%   Columns 61 through 75
% 
%     62    66    79   118    77     9    41    93    64     7   115    82    91    92    60
% 
%   Columns 76 through 90
% 
%     29    94   106    17    26    44    67    83    96    24   121    61    81    88    32
% 
%   Columns 91 through 105
% 
%     75    48    58    55    25    34    72    63   107     1    80    28    42    38    23
% 
%   Columns 106 through 120
% 
%     52     5    73    53    18   101    70    49   108   122    13   100    59    47    54
% 
%   Columns 121 through 122
% 
%    102    35



% alpha 1 ordenpoli 5
%  Columns 1 through 15
% 
%    113     4    56    10   114   115    30    43     3    61    87   103    22    42    15
% 
%   Columns 16 through 30
% 
%     24   120    39    55   105   118    93    77    59    80   107    13    51    75   116
% 
%   Columns 31 through 45
% 
%     34   119    95    26    82    50     2    23    99    49    63   109    16    67    79
% 
%   Columns 46 through 60
% 
%     85   122    62    57    28    94    29    17    81    33    31    90    96    65    64
% 
%   Columns 61 through 75
% 
%     66    58   101    60    68   106    53    54    32     9    41    25    84    19    78
% 
%   Columns 76 through 90
% 
%    110    44    21     6    89    52    74    72    88    97    86    91    45    27    40
% 
%   Columns 91 through 105
% 
%     14   108    73   111    98    11     7    70    69   102    48    92    47     1    20
% 
%   Columns 106 through 120
% 
%      5    36    35    37     8    38   104    83   121   100    71    12   117    76    46
% 
%   Columns 121 through 122
% 
%    112    18

% alpha 1 ordenpoli 10
% 
%   Columns 1 through 15
% 
%    113     4    30   119    18    47    31    24   121   116    51   105     1   100    89
% 
%   Columns 16 through 30
% 
%    103    45     9    44    11    94    39    36    99    19    78    70    62    81    35
% 
%   Columns 31 through 45
% 
%      2    88    38    34    90    37    48    12    68    65    16   117     7   118    20
% 
%   Columns 46 through 60
% 
%     58    98     6    82    46    60   101   120    32    92    77    61    57    33    27
% 
%   Columns 61 through 75
% 
%     93    14    26    96    25    74   110    23    69    59   106   107    86     8    13
% 
%   Columns 76 through 90
% 
%     97   122    85    71   108    67    40   111    87    29    84   104    80    79    91
% 
%   Columns 91 through 105
% 
%     64    21   102    55    56   115    73    22    76    49     5    10    66    54    43
% 
%   Columns 106 through 120
% 
%     72    17   114     3    95    41    75    83    52    15   109    53    28   112    42
% 
%   Columns 121 through 122
% 
%     50    63
