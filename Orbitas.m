function Orbitas
    % x poblacion de peces en el instante t / capacidad de carga (k)
    % x=P/k
    % y concentracion del contaminante en el instante t

    % Parámetros
    % r = 0.5; % Tasa de crecimiento de la poblacion
    % a = 0.4; % Tasa de mortalidad de los peces por contaminacion
    % I = 0.4; % Tasa de introduccion del contaminante
    % d = 0.3; % Tasa de descomposicion natural del contaminante
    % % k = 0.8; % capacidad de carga del ecosistema para la poblacion de peces
    % B = 0.5; % Tasa de descomposicion del contaminante debido a la influencia de la poblacion 


     % Parámetros
     r = 0.5; % Tasa de crecimiento de la poblacion
     a = 0.4; % Tasa de mortalidad de los peces por contaminacion
     I = 0.4; % Tasa de introduccion del contaminante
     d = 0.5; % Tasa de descomposicion natural del contaminante
    % % k = 0.8; % capacidad de carga del ecosistema para la poblacion de peces
     B = 0.5; % Tasa de descomposicion del contaminante debido a la influencia de la poblacion 


    % Sistema de ecuaciones diferenciales
    dydt = @(t, z) [
        r * z(1) * (1 - z(1)) - a * z(1) * z(2);
        I - d * z(2) - B * z(1) * z(2)
    ];

    % Condiciones iniciales
    condiciones_iniciales = [
        0.15, 1.05;
        0.1, 0.1;
        0.3, 0.8;
        0.5, 0.3;
        0.7, 0.7;
        0.9, 0.4;
        0.2, 0.6
    ];

    % Intervalo de tiempo
    tspan = [-100 100];

    % Crear el espacio de fase
    figure;
    hold on;

    % Graficar el campo vectorial
    [X, Y] = meshgrid(-0.4:0.05:1, 0:0.05:1.5); % Malla del espacio de fase
    U = r * X .* (1 - X) - a * X .* Y; % dx/dt
    V = I - d * Y - B * X .* Y; % dy/dt
    quiver(X, Y, U, V, 1.5, 'k'); % Vectorial, escala 1.5, color negro

    % Graficar las órbitas
    colores = lines(size(condiciones_iniciales, 1)); % Colores para las órbitas
    for i = 1:size(condiciones_iniciales, 1)
        z0 = condiciones_iniciales(i, :);
        [~, z] = ode45(dydt, tspan, z0);
        plot(z(:, 1), z(:, 2), 'Color', colores(i, :), 'LineWidth', 1.5);
    end
    plot(0, I/d, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r'); % Punto rojo con relleno<
    text(0, I/d, ' (0,I/d)', 'FontSize', 10, 'Color', 'r'); % Etiqueta cerca del punto

     plot(0.2, 1, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r'); % Punto rojo con relleno<
     text(0.2, 1, ' (0.2,1)', 'FontSize', 10, 'Color', 'r'); % Etiqueta cerca del punto


    % Personalizar gráfico
    xlabel('Población de peces (x)');
    ylabel('Concentración del contaminante (y)');
    title('Órbitas en el espacio de fase con campo vectorial');
    legend(arrayfun(@(i) sprintf('CI %d', i), 1:size(condiciones_iniciales, 1), 'UniformOutput', false), ...
        'Location', 'best');
    grid on;
    hold off;