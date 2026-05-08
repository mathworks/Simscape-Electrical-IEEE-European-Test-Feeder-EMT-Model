open_system('top_level_European_4segs_MR')

read_network_data
read_load_profiles
load benchmarkData

hm = find_system(bdroot,'FindAll','on','FollowLinks','on','LookUnderMasks','all','Name','busM');
qq = get(hm,'InputSignals');

ind01 = {n1_slBus1.Elements.Name};
ind02 = {n2_slBus1.Elements.Name};
ind03 = {n3_slBus1.Elements.Name};
ind04 = {n4_slBus1.Elements.Name};

idxV = [str2num(char(strtok(ind04,'Vabc_')));str2num(char(strtok(ind03,'Vabc_')));str2num(char(strtok(ind02,'Vabc_')));str2num(char(strtok(ind01,'Vabc_')))]; %#ok<*ST2NM>

n1_idxV = str2num(char(strtok(ind01,'Vabc_')));
n2_idxV = str2num(char(strtok(ind02,'Vabc_')));
n3_idxV = str2num(char(strtok(ind03,'Vabc_')));
n4_idxV = str2num(char(strtok(ind04,'Vabc_')));

% vs = [];
% for xx = 1:numel(dataEuropean.loads.Bus_No)
% 
%     vs = [vs,'Vabc_',num2str(dataEuropean.loads.Bus_No(xx)),',']; %#ok<*AGROW>
% 
% end

% vs = vs(1:end-1);

% voltages for load block
h = find_system(bdroot,'FindAll','on','FollowLinks','on','LookUnderMasks','all','Name','busV');
vs = join('Vabc_' + string(dataEuropean.loads.Bus_No), ',');
set(h,'OutputSignals',vs);

pp = [dataEuropean.loads.PA dataEuropean.loads.PB dataEuropean.loads.PC];

idxLoads = find(reshape(pp',1,[]));

dt = 2/50;
tstop = 1440*dt;

ta = (0:dt:tstop-dt)';
Prefa = zeros(1440,55);
Qrefa = zeros(1440,55);

for x = 1:55

    idxS = dataEuropean.loads.Bus_No(x);

    fb = find(ismember(idxV,idxS));

    Prefa(:,x) = loadProfile(:,x)*1000;
    Qrefa(:,x) = sqrt(1-0.95^2)*loadProfile(:,x)*1000;

end

Prefa(1,:) = 0;
Qrefa(1,:) = 0;

t = (0:Ts:tstop-dt)';

load1(1) = 0;
load32(1) = 0;
load53(1) = 0;

Pref = interp1(ta, Prefa, t, 'previous');
Qref = interp1(ta, Qrefa, t, 'previous');
vload1 = interp1(ta, load1, t, 'previous');
vload32 = interp1(ta, load32, t, 'previous');
vload53 = interp1(ta, load53, t, 'previous');

vload1 = [vload1(2:end);0];
vload32 = [vload32(2:end);0];
vload53 = [vload53(2:end);0];

% index into current locations

[~,idxL] = ismember(dataEuropean.loads.Bus_No,idxV);

[~,n1_idxLa] = ismember(dataEuropean.loads.Bus_No,n1_idxV);
[~,n2_idxLa] = ismember(dataEuropean.loads.Bus_No,n2_idxV);
[~,n3_idxLa] = ismember(dataEuropean.loads.Bus_No,n3_idxV);
[~,n4_idxLa] = ismember(dataEuropean.loads.Bus_No,n4_idxV);

idx_n1 = find(n1_idxLa~=0);
idx_n2 = find(n2_idxLa~=0);
idx_n3 = find(n3_idxLa~=0);
idx_n4 = find(n4_idxLa~=0);

[~,n1_idxL] = ismember(dataEuropean.loads.Bus_No(idx_n1),n1_idxV);
[~,n2_idxL] = ismember(dataEuropean.loads.Bus_No(idx_n2),n2_idxV);
[~,n3_idxL] = ismember(dataEuropean.loads.Bus_No(idx_n3),n3_idxV);
[~,n4_idxL] = ismember(dataEuropean.loads.Bus_No(idx_n4),n4_idxV);

idxC = zeros(55,1);

for x = 1:55

    idxC(x) = 3*(idxL(x)-1) + find(pp(x,:) > 0);

end

idxC1 = zeros(numel(idx_n1),1);
idxC2 = zeros(numel(idx_n2),1);
idxC3 = zeros(numel(idx_n3),1);
idxC4 = zeros(numel(idx_n4),1);

pp1 = pp(idx_n1,:);
pp2 = pp(idx_n2,:);
pp3 = pp(idx_n3,:);
pp4 = pp(idx_n4,:);

nz1 = nonzeros(n1_idxLa);
nz2 = nonzeros(n2_idxLa);
nz3 = nonzeros(n3_idxLa);
nz4 = nonzeros(n4_idxLa);

for x1 = 1:numel(idx_n1)

    idxC1(x1) = 3*(nz1(x1)-1) + find(pp1(x1,:) > 0);

end

for x2 = 1:numel(idx_n2)

    idxC2(x2) = 3*(nz2(x2)-1) + find(pp2(x2,:) > 0);

end

for x3 = 1:numel(idx_n3)

    idxC3(x3) = 3*(nz3(x3)-1) + find(pp3(x3,:) > 0);

end

for x4 = 1:numel(idx_n4)

    idxC4(x4) = 3*(nz4(x4)-1) + find(pp4(x4,:) > 0);

end


idxR = zeros(165,1);
idxR(1:3:end) = 1:55;
idxR(2:3:end) = 56:110;
idxR(3:3:end) = 111:165;
