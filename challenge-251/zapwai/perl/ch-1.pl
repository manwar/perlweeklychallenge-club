use v5.30;
my @ints = (6, 12, 25, 1);
say "Input: \@ints = (" . join(", ", @ints) . ")";
my $sum = 0;
do {
    proc(\@ints);
} while (@ints);
say "Output: $sum";
sub proc {
    my $r = shift;
    my $a = shift @$r;
    my $b;
    $b = pop @$r if (@$r) ;
    my $x = $a.$b;
    $sum += $x;
}
