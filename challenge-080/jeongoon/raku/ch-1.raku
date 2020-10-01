# https://dev.to/jeongoon/weekly-challenge-080-2kg9
# test with: jeongoon/raku/ch-1.raku 5 2 -2 0
[1..∞].first({@*ARGS.Set∌$_}).say
#sub MAIN{say((|@_,0,Inf).sort.rotor(2=>-1).first({.[0]>-1>[-] $_})[0]+1)}
