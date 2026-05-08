function source_placement_ssc(mdl,data)
%
% This function connects the source
%
% Copyright 2026 The MathWorks, Inc.
%

busv = data.source_bus;

for l = 1:numel(busv)
    
    bus = busv(l);
    
    ha = find_system([mdl,'/Bus_',num2str(bus)]);
    
    h = get_param(ha,'handle');
    
    h = h{1};
    
    hb = add_block('source_snt/sourcesscT',[mdl,'/source',num2str(bus)]);
    
    posa = get(hb,'Position');
    
    pos = posa - [posa(1) posa(2) posa(1) posa(2)];
    
    pp = get(h,'Position');
    
    set(hb,'Position',pos + [pp(1)-150 pp(2) pp(1)-150 pp(2)])
    
    b1 = get(hb,'Porthandles');
    b2 = get(h,'Porthandles');
    
    % connect the lines
    
    for l1 = 1
        
        add_line(mdl,b1.RConn(l1),b2.LConn(l1))
        
    end
    
end