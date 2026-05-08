function set_line(h,data,from_bus,to_bus)
%
% This function parameterizes the lines and names the goto tags
%
% Copyright 2018 The MathWorks, Inc.
%

set(h,'Name',[num2str(from_bus),'_',num2str(to_bus)]);


nn = sort([from_bus to_bus]);

idx = sum(ismember(from_to,[data.lines.From(ll) data.lines.To(ll)]),2) == 2;

if sum(idx) ~= 0
    
    set(h,'config',num2str(data(idx,4)));
    set(h,'length',num2str(data(idx,3)));

else
   
    set(h,'config',num2str(1));
    set(h,'length',num2str(100));
end

set(h,'from_bus',num2str(from_bus));
set(h,'to_bus',num2str(to_bus));

hD = find_system(h,'FindAll','on','LookUnderMasks','all','RegExp','on','Name','Distributed Parameters Line');

nc = num2str(data(idx,4));
nl = num2str(data(idx,3));

set(hD,'Resistance',['R_',nc]);
set(hD,'Inductance',['L_',nc]);
set(hD,'Capacitance',['C_',nc]);
set(hD,'Length',[nl,'*ft2km']);

hI = find_system(h,'LookUnderMasks','all','RegExp','on','Name','Iabc');

no = get(h,'Name');

set(hI,'GotoTag',['Iabc_',no]);
