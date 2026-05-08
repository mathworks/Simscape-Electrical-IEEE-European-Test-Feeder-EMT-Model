% This script reads the system data
%
% Copyright 2018-2024 The MathWorks, Inc

clear dataEuropean

%% buses

busXY = readtable('Buscoords.csv','HeaderLines',1);

busVarNames = {'Bus_No','X_Coord','Y_Coord','No_Phases','A','B','C'};

rones = ones(size(busXY,1),1);

dataEuropean.buses = table(busXY.Busname,busXY.x-busXY.x(1),busXY.y-busXY.y(1),3*rones,rones,rones,rones,'VariableNames',busVarNames);

dataEuropean.buses.X_Coord = dataEuropean.buses.X_Coord/max(abs(dataEuropean.buses.X_Coord))*20000;
dataEuropean.buses.Y_Coord = -dataEuropean.buses.Y_Coord/max(abs(dataEuropean.buses.Y_Coord))*20000;


%% lines

lines = readtable('Lines.csv','HeaderLines',1);

linesVarNames = {'From','To','A','B','C','Length','Units','LineCode'};

rones = ones(size(lines,1),1);

dataEuropean.lines = table(lines.Bus1,lines.Bus2,rones,rones,rones,lines.Length,lines.Units,lines.LineCode,'VariableNames',linesVarNames);

%% line codes

dataEuropean.lineCodes = readtable('LineCodes.csv','HeaderLines',1);


%% loads

loads = readtable('Loads.csv','HeaderLines',2);

sl = size(loads,1);

Bus_No = loads.Bus;

Load_Type = cell(sl,1);
Load_Type(:) = {'Y-PQ'};

PA = zeros(sl,1);
QA = zeros(sl,1);
PB = zeros(sl,1);
QB = zeros(sl,1);
PC = zeros(sl,1);
QC = zeros(sl,1);

for l1 = 1:sl

    switch loads.phases{l1}
        
        case 'A'
       
            PA(l1) = loads.kW(l1);
            QA(l1) = sqrt((loads.kW(l1)/loads.PF(l1))^2-loads.kW(l1)^2);
            
        case 'B'
            
            PB(l1) = loads.kW(l1);
            QB(l1) = sqrt((loads.kW(l1)/loads.PF(l1))^2-loads.kW(l1)^2);
            
        case 'C'
            
            PC(l1) = loads.kW(l1);
            QC(l1) = sqrt((loads.kW(l1)/loads.PF(l1))^2-loads.kW(l1)^2);
            
    end
    
end

loadsVarNames = {'Bus_No','Load_Type','PA','QA','PB','QB','PC','QC'};

dataEuropean.loads = table(Bus_No,Load_Type,PA,QA,PB,QB,PC,QC,'VariableNames',loadsVarNames);

%%

dataEuropean.source_bus = 1;

%%

clear Bus_No Load_Type PA QA PB QB PC QC loadsVarNames sl lines linesVarNames
clear busVarNames busXY loads rones l1

data_load1 = readtable('Voltages_and_Currents_Load_#1_#32_#53_24hr.xlsx','Sheet','Load #1','VariableNamingRule','preserve');
data_load32 = readtable('Voltages_and_Currents_Load_#1_#32_#53_24hr.xlsx','Sheet','Load #32','VariableNamingRule','preserve');
data_load53 = readtable('Voltages_and_Currents_Load_#1_#32_#53_24hr.xlsx','Sheet','Load #53','VariableNamingRule','preserve');

load1 = data_load1.V1;
load32 = data_load32.V1;
load53 = data_load53.V1;

clear data_load1 data_load32 data_load53