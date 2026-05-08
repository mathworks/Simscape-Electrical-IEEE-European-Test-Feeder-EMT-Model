function set_buses(h)
%
% This function names the bus goto tags
%
% Copyright 2026 The MathWorks, Inc.
%


hV = find_system(h,'LookUnderMasks','All','RegExp','on','Name','Vabc');

no = get(h,'Name');

set(hV,'GotoTag',['Vabc_',strtok(no,'Bus_')]);

hI = find_system(h,'LookUnderMasks','All','RegExp','on','Name','IabcFrom');

set(hI,'GotoTag',['Iabc_',strtok(no,'Bus_')]);


