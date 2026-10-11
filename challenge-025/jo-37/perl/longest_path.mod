param n integer > 1;
param M := n + 1;

set V := 0..n-1;
set E within V cross V;

var x{V}, binary;
var s{V}, binary;
var t{V}, binary;
var y{E}, binary;
var p{V} >= 0, <= n;

maximize LongestPath:
    sum{v in V} x[v];

# Exactly one start and one end
s.t. OneStart:
    sum{v in V} s[v] = 1;

s.t. OneEnd:
    sum{v in V} t[v] = 1;

# Incoming and outgoing edges
s.t. Incoming{v in V}:
    sum{(u,w) in E: w = v} y[u,w] = x[v] - s[v];

s.t. Outgoing{v in V}:
    sum{(u,w) in E: u = v} y[u,w] = x[v] - t[v];

# Selected edges require selected endpoints
s.t. EdgeTail{(u,v) in E}:
    y[u,v] <= x[u];

s.t. EdgeHead{(u,v) in E}:
    y[u,v] <= x[v];

# Position bounds
s.t. PositionLower{v in V}:
    p[v] >= x[v];

s.t. PositionUpper{v in V}:
    p[v] <= n * x[v];

# Eliminate directed cycles
s.t. Order{(u,v) in E}:
    p[v] >= p[u] + 1 - M * (1 - y[u,v]);

end;
