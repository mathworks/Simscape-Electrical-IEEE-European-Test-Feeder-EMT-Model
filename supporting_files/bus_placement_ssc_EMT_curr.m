function bus_placement_ssc_EMT_curr(mdl,data)
%
% This function places the buses
%
% Copyright 2018 The MathWorks, Inc.
%

% place the buses

nl = numel(data.buses.Bus_No);

for l = 1:nl
    
    h = add_block(['buses_snt/',num2str(data.buses.No_Phases(l)),'sscTcurr'],[mdl,'/Bus_',num2str(data.buses.Bus_No(l))]);
    
    set_buses(h)
    
    posa = get(h,'Position');
    
    pos = posa - [posa(1) posa(2) posa(1) posa(2)];
    
    x = data.buses.X_Coord(l);
    y = data.buses.Y_Coord(l);
    
    set(h,'Position',pos + [x y x y])

    pause(0.01) % this pause is in place to visually see the network 'grow'. 
    
end



