use v6;

sub MAIN( Int $num, Int $den where $den != 0  ) {
    my ($non-rep, $repeating) = ($num / $den).base-repeating;
    my $suffix = $repeating ?? "($repeating)" !! "";
    printf '%s%s', $non-rep, $suffix;
}
