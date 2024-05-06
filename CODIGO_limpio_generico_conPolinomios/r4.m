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
