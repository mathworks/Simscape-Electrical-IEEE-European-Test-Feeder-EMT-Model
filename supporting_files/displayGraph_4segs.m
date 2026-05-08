function [X,Y,n1,n2,nb1,nb2,bus1,bus2,linesConn] = displayGraph_4segs(data,cc,cc1,cc2)

buses1 = unique([data.lines.From;data.lines.To]);

for x = 1:numel(data.lines.From)
    
   qq(x,1) = find(ismember(buses1,data.lines.From(x))); %#ok<*AGROW>
   ww(x,1) = find(ismember(buses1,data.lines.To(x)));
   
end

eea = [qq ww];

eea = sort(eea,2);

eea = unique(eea,'rows');

G = graph(eea(:,1),eea(:,2),ones(numel(eea(:,1)),1));

G.Nodes.Name = arrayfun(@num2str, data.buses.Bus_No, 'UniformOutput', false);

figure(1);h = plot(G,'layout','force');

h.XData = data.buses.X_Coord;
h.YData = -data.buses.Y_Coord;

X = h.XData;
Y = h.YData;

[n1,n2,~,~,~,~,~,n1a,n2a,idxB,idxa,idxb] = splitNetwork02(G,cc); % 

qq1 = colormap('lines');

highlight(h,n1a,'NodeColor',qq1(1,:))
highlight(h,n2a,'NodeColor',qq1(2,:))
 
highlight(h,G.Edges.EndNodes(idxa,1),G.Edges.EndNodes(idxa,2),'EdgeColor',qq1(1,:),'LineWidth',3) % highlight region 1
highlight(h,G.Edges.EndNodes(idxb,1),G.Edges.EndNodes(idxb,2),'EdgeColor',qq1(2,:),'LineWidth',3) % highlight region 2
highlight(h,G.Edges.EndNodes(idxB,1),G.Edges.EndNodes(idxB,2),'EdgeColor','g','LineWidth',5) % highlight connection lines

bus1 = n1a;
bus2 = n2a;
linesConn = str2double(G.Edges.EndNodes(idxB,:));

nb1 = sort(n1(ismember(n1,n2)));
 
nb2 = sort(n2(ismember(n2,n1)));

G1 = subgraph(G,n1a);
G2 = subgraph(G,n2a);

[n11,n12,~,~,~,~,~,n11a,n12a,idxB1,idxa1,idxb1] = splitNetwork02(G1,cc1); %
[n21,n22,~,~,~,~,~,n21a,n22a,idxB2,idxa2,idxb2] = splitNetwork02(G2,cc2); %

linesConn1 = str2double(G1.Edges.EndNodes(idxB1,:));
linesConn2 = str2double(G2.Edges.EndNodes(idxB2,:));

G11 = subgraph(G1,n11a);
G12 = subgraph(G1,n12a);
G21 = subgraph(G2,n21a);
G22 = subgraph(G2,n22a);


disp('')


