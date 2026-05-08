function define_outputs_curr(mdl)

%
% This function places from tags in the 'current_outputs' and
% 'voltage_outputs' subsystems
%
% Copyright 2018 The MathWorks, Inc.
%


%%

hi = find_system(mdl,'FindAll','on','LookUnderMasks','All','Name','IabcGoto');

hom = find_system(mdl,'FindAll','on','LookUnderMasks','All','Name','current_output_bus');

set(hom,'Inputs',num2str(numel(hi)));

homp = get(hom,'PortHandles');

for l = 1:numel(hi)
    
    nn = get(hi(l),'GotoTag');
    
    hf = add_block('simulink/Signal Routing/From',[mdl,'/current_outputs/from_',nn]);
    
    hfp = get(hf,'PortHandles');
    
    set(hf,'GotoTag',nn);
    
    pos = get(hf,'Position');
    
    set(hf,'Position',[pos(1) pos(2)+(l-1)*20 pos(3) pos(4)+(l-1)*20])
    
    hl = add_line([mdl,'/current_outputs'],hfp.Outport,homp.Inport(l));
    
    set(hl,'SignalNameFromLabel',get(hi(l),'GotoTag'))
    
end

%%

hv = find_system(mdl,'FindAll','on','LookUnderMasks','All','Name','VabcBus');

hvom = find_system(mdl,'FindAll','on','LookUnderMasks','All','Name','voltage_output_bus');

set(hvom,'Inputs',num2str(numel(hv)));

hvomp = get(hvom,'PortHandles');

for l = 1:numel(hv)
    
    nn = get(hv(l),'GotoTag');
    
    hf = add_block('simulink/Signal Routing/From',[mdl,'/voltage_outputs/from_',nn]);
    
    hfp = get(hf,'PortHandles');
    
    set(hf,'GotoTag',nn);
    
    pos = get(hf,'Position');
    
    set(hf,'Position',[pos(1) pos(2)+(l-1)*20 pos(3) pos(4)+(l-1)*20])
    
    hl = add_line([mdl,'/voltage_outputs'],hfp.Outport,hvomp.Inport(l));
    
    set(hl,'SignalNameFromLabel',get(hv(l),'GotoTag'))
    
end

