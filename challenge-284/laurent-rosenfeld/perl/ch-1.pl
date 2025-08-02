sub lucky_integer {
    my %count;
    $count{$_}++ for @_;
    my @lucky = grep { $_ == $count{$_} } keys %count;
    return -1 if $#lucky == 0;
    my $max = shift @lucky;
    for my $i (@lucky) {
        $max = $i if $i > $max;
    }
    return $max;
}

my @tests = ( [<2 2 3 4>], [<1 2 2 3 3 3>], [<1 1 1 3>] );
for my $test (@tests) {
    printf "%-12s => ", "@$test";
    say lucky_integer @$test;
}
