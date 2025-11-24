sub f {
    my( $s, %c ) = @_;
    $s !~ s{ ^. }{ ++$c{$&}; '' }ex  ? 0
   :$c{U} == $c{D} && $c{L} == $c{R} ? 1
   :f($s, %c)
}

print!f("ULD")          ? "ok\n" : "error\n";
print f("ULDR")         ? "ok\n" : "error\n";
print!f("UUURRRDDD")    ? "ok\n" : "error\n";
print f("UURRRDDLLL")   ? "ok\n" : "error\n";
print f("RRUULLDDRRUU") ? "ok\n" : "error\n";
