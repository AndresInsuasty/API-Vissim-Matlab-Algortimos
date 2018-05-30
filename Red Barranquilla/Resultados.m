% Muestra de los resultados en la simulación de Vissim

archivo = fopen('RedBarranquilla_exper_ii.stz','rt');
columnas = 49;
formato = '%s '; % formato de cada línea, que todo sea texto
for i=1:columnas-1
formato=strcat('%s',formato); % 49 '%s' seguidos para no hacerlo manual
end
 
data = textscan(archivo, formato, 'HeaderLines', 1);
fclose(archivo); 

% Sustituir coma por punto
 
data = cellfun(@(x) strrep(x,';',''), data, 'UniformOutput', false);% de vissim 
                                                                    %llegan los valores 
                                                                    %terminando en ';' 
                                                                    % para
                                                                    % convertirlos
                                                                    % a
                                                                    % numeros
                                                                    % elimina
                                                                    % ';'
for i=1:columnas
a(:,i) = cellfun(@str2num, data{i}, 'UniformOutput', false);%en la variable a
                                                            %se convierte
                                                            %todo el string
                                                            %a numero, las
                                                            %letras quedan
                                                            %como []
                                                         
end

b = cell2mat(a([27:end],:));%solo se escogen los valores de interes en la
                            %simulación y se convierten de celdas a una
                            %matriz numerica.
PromedioTotal=sum(b(:,[2:3:end]),2);
MaximoTotal=sum(b(:,[3:3:end]),2);
ParadaTotal=sum(b(:,[4:3:end]),2);

Promedio=mean(PromedioTotal);

%%
