sub odd_char {
    my (%s, %t);
    %s = map { $_ => ++$s{$_} } split //, $_[0];
    %t = map { $_ => ++$t{$_} } split //, $_[1];
    my @result = grep { (not defined $s{$_})
        or $t{$_} - $s{$_} > 0 } keys %t;
}

for my $test ([<Perl Preel>], [<Weekly Weeakly>], [<Box Boxy>]) {
    printf "%-8s %-8s => ", @$test;
    say odd_char $test->[0], $test->[1];
}
