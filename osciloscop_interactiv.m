function osciloscop_interactiv()
    f = figure('Name', 'Osciloscop Interactiv', 'NumberTitle','off',...
        'Position', [300 300 800 600], 'Color', [0.95 0.95 1]);

    h.axa = axes('Parent', f, 'Position', [0.1 0.45 0.8 0.45], 'Box','on');
    grid(h.axa, 'on'); 
    hold(h.axa, 'off');

    uicontrol('Style', 'text', 'Position', [80 235 120 25], 'String', 'Frecvenţă (Hz)');
    h.f_slid = uicontrol('Style', 'slider', 'Min',1,'Max', 25, 'Value',5, 'Position', [80 215 150 20]);

    uicontrol('Style', 'text', 'Position', [80 170 120 25], 'String','Amplitudine');
    h.a_slid = uicontrol('Style', 'slider', 'Min', 0.1, 'Max', 10, 'Value', 2, 'Position', [80 150 150 20]);

    h.h_meniu = uicontrol('Style', 'popupmenu', 'String', {'Sinusoidal', 'Dreptunghiular', 'Triunghiular'}, 'Position', [450 215 150 20]);
    h.h_zgomot = uicontrol('Style', 'checkbox', 'String', 'Adaugă zgomot', 'Position', [450 150 150 20]);
    h.h_status = uicontrol('Style','text', 'String', 'Status: Oprit', 'Position', [325 20 150 30], 'FontWeight', 'bold');

    h.btn = uicontrol('Style', 'togglebutton', 'String', 'START',...
        'Position', [350 70 100 40], 'BackgroundColor', [0.6 1 0.6],...
        'Callback', @toggle_callback);

    set(f, 'UserData', h);

    t_obj = timer('ExecutionMode', 'fixedRate', 'Period', 0.2, ...
        'TimerFcn', @(~,~) draw_now(f));

    function toggle_callback(src, ~)
        fig_obj = ancestor(src, 'figure');
        if get(src, 'Value') == 1
            set(src, 'String', 'STOP', 'BackgroundColor', [1 0.6 0.6]);
            curr_h = get(fig_obj, 'UserData');
            set(curr_h.h_status, 'String', 'Status: Rulare', 'ForegroundColor', [0 0.5 0]);
            start(t_obj);
        else
            set(src, 'String', 'START', 'BackgroundColor', [0.6 1 0.6]);
            curr_h = get(fig_obj, 'UserData');
            set(curr_h.h_status, 'String', 'Status: Oprit', 'ForegroundColor', 'red');
            stop(t_obj);
        end
    end

    function draw_now(fig_handle)
        if ~isscalar(fig_handle) || ~ishandle(fig_handle), return; end
        
        curr_h = get(fig_handle, 'UserData');
        
        f_val = get(curr_h.f_slid, 'Value');
        A_val = get(curr_h.a_slid, 'Value');
        tip = get(curr_h.h_meniu, 'Value');
        zgomot_on = get(curr_h.h_zgomot, 'Value');
        
        t = linspace(0, 2, 1000);

        switch tip
            case 1 
                y = A_val * sin(2*pi*f_val*t);
            case 2 
                y = A_val * square(2*pi*f_val*t);
            case 3 
                y = A_val * sawtooth(2*pi*f_val*t, 0.5);
        end

        if zgomot_on
            y = y + (A_val * 0.15) * randn(size(t));
        end

        plot(curr_h.axa, t, y, 'Color', [0 0.45 0.74], 'LineWidth', 1.5);
        
        axis(curr_h.axa, [0 2 -12 12]);
        grid(curr_h.axa, 'on');
        
        drawnow limitrate;
    end

    set(f, 'CloseRequestFcn', @(s,e) stop_all(s, t_obj));
    function stop_all(f_obj, timer_ptr)
        try
            stop(timer_ptr);
            delete(timer_ptr);
        catch
        end
        delete(f_obj);
    end
end
