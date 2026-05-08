% This script prepares data for four segments
%
% Copyright (C) 2026, The MathWorks, Inc

clear qq1 ww1

no_buses = 906;

read_network_data

data = dataEuropean;

buses1 = unique([data.lines.From;data.lines.To]);

for l = 1:numel(data.lines.From)
    
   qq1(l,1) = find(ismember(buses1,data.lines.From(l))); %#ok<*SAGROW>
   ww1(l,1) = find(ismember(buses1,data.lines.To(l)));
   
end

qq = qq1;

ww = ww1;

eea = [qq ww];

eea = sort(eea,2);

eea = unique(eea,'rows');

G = graph(eea(:,1),eea(:,2),rand(numel(eea(:,1)),1));

 
qq = colormap('lines');

hf = figure(1);h = plot(G,'layout','force');title('IEEE European : 4 Segments')
 
[n1aa,n2aa,idxn1,idxn2,boundaryBuses,nb1s,nb2s,idxB] = splitNetwork02a(G,0.5); % 

h.XData = data.buses.X_Coord;
h.YData = -data.buses.Y_Coord;

%%
 
highlight(h,n1aa,'NodeColor',qq(1,:))
highlight(h,n2aa,'NodeColor',qq(2,:))
 
highlight(h,G.Edges.EndNodes(idxn1,1),G.Edges.EndNodes(idxn1,2),'EdgeColor',qq(1,:)) % highlight region n1
highlight(h,G.Edges.EndNodes(idxn2,1),G.Edges.EndNodes(idxn2,2),'EdgeColor',qq(2,:)) % highlight region n1
highlight(h,G.Edges.EndNodes(idxB,1),G.Edges.EndNodes(idxB,2),'EdgeColor','g','LineWidth',5) % highlight connection lines


%%


G2 = subgraph(G,n1aa);
G3 = subgraph(G,n2aa);


XData1 = h.XData(n1aa);
YData1 = h.YData(n1aa);

XData2 = h.XData(n2aa);
YData2 = h.YData(n2aa);

[n1a,n2a,idxn1a,idxn2a,boundaryBusesa,nb1a,nb2a,idxB1] = splitNetwork02a(G2,0.7); % 

[n1b,n2b,idxn1b,idxn2b,boundaryBusesb,nb1b,nb2b,idxB2] = splitNetwork02a(G3,0.7); % 


highlight(h,n1aa(n1a),'NodeColor',qq(1,:))
highlight(h,n1aa(n2a),'NodeColor',qq(2,:))

highlight(h,n1aa(G2.Edges.EndNodes(idxn1a,1)),n1aa(G2.Edges.EndNodes(idxn1a,2)),'EdgeColor',qq(1,:)) % highlight region n1
highlight(h,n1aa(G2.Edges.EndNodes(idxn2a,1)),n1aa(G2.Edges.EndNodes(idxn2a,2)),'EdgeColor',qq(2,:)) % highlight region n1
highlight(h,n1aa(G2.Edges.EndNodes(idxB1,1)),n1aa(G2.Edges.EndNodes(idxB1,2)),'EdgeColor','g','LineWidth',5) % highlight connection lines

highlight(h,n2aa(n1b),'NodeColor',qq(3,:))
highlight(h,n2aa(n2b),'NodeColor',qq(5,:))

highlight(h,n2aa(G3.Edges.EndNodes(idxn1b,1)),n2aa(G3.Edges.EndNodes(idxn1b,2)),'EdgeColor',qq(3,:)) % highlight region n1
highlight(h,n2aa(G3.Edges.EndNodes(idxn2b,1)),n2aa(G3.Edges.EndNodes(idxn2b,2)),'EdgeColor',qq(5,:)) % highlight region n1
highlight(h,n2aa(G3.Edges.EndNodes(idxB2,1)),n2aa(G3.Edges.EndNodes(idxB2,2)),'EdgeColor','g','LineWidth',5) % highlight connection lines

n11 = n1aa(n1a);
n12 = n1aa(n2a);
n21 = n2aa(n1b);
n22 = n2aa(n2b);

n1 = n11;
n2 = n12;
n3 = n21;
n4 = n22;


G11 = subgraph(G2,n1a);
G12 = subgraph(G2,n2a);
G21 = subgraph(G3,n1b);
G22 = subgraph(G3,n2b);

nb1 = [sort(n1(ismember(n1,n2)));sort(n1(ismember(n1,n3)));sort(n1(ismember(n1,n4)))];
nb1_idx = [numel(sort(n1(ismember(n1,n2))));numel(sort(n1(ismember(n1,n3))));numel(sort(n1(ismember(n1,n4))))];

nb2 = [sort(n2(ismember(n2,n1)));sort(n2(ismember(n2,n3)));sort(n2(ismember(n2,n4)))];
nb2_idx = [numel(sort(n2(ismember(n2,n1))));numel(sort(n2(ismember(n2,n3))));numel(sort(n2(ismember(n2,n4))))];

nb3 = [sort(n3(ismember(n3,n1)));sort(n3(ismember(n3,n2)));sort(n3(ismember(n3,n4)))];
nb3_idx = [numel(sort(n3(ismember(n3,n1))));numel(sort(n3(ismember(n3,n2))));numel(sort(n3(ismember(n3,n4))))];

nb4 = [sort(n4(ismember(n4,n1)));sort(n4(ismember(n4,n2)));sort(n4(ismember(n4,n3)))];
nb4_idx = [numel(sort(n4(ismember(n4,n1))));numel(sort(n4(ismember(n4,n2))));numel(sort(n4(ismember(n4,n3))))];

lineConns = [boundaryBuses;n1aa(boundaryBusesa)';n2aa(boundaryBusesb)'];

n1_lineConns = lineConns(find(sum(ismember(lineConns,n1),2)),:); %#ok<*FNDSB>
n2_lineConns = lineConns(find(sum(ismember(lineConns,n2),2)),:);
n3_lineConns = lineConns(find(sum(ismember(lineConns,n3),2)),:);
n4_lineConns = lineConns(find(sum(ismember(lineConns,n4),2)),:);
