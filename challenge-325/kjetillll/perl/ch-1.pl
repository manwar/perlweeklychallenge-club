sub f {
    my($c, $max) = (0, 0);
    for(@_){
        $c = $_ ? $c+1 : 0;
        $max = $c if $c > $max;
    }
    $max
}

sub f2 {
    (sort {$b <=> $a } map length, join('',@_) =~ /1+/g )[0]
}

for my $f ( \&f, \&f2 ) {
    print $f->(0, 1, 1, 0, 1, 1, 1) == 3 ? "ok\n" : "err\n";
    print $f->(0, 0, 0, 0)          == 0 ? "ok\n" : "err\n";
    print $f->(1, 0, 1, 0, 1, 1)    == 2 ? "ok\n" : "err\n";
}
