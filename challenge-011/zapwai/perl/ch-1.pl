use v5.38;

sub f($c) {
    my $m = (212 - 32) / 100;
    return 32 + $m*$c;
}
    
for my $i (-100 .. 212) {
    say f($i) if ($i == f($i));
}
