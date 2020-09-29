my @N = @*ARGS>>.Int;

say @N.elems + elems (^@N.elems.pred).grep: { @N[$_] != @N[.succ] };
