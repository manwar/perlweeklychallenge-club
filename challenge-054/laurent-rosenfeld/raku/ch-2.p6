use v6;

sub collatz-seq (UInt $in) {
    my $n = $in;
    my @result = gather {
        while $n != 1 {
            my $new-n = $n % 2 ?? 3 * $n + 1 !! $n / 2;
            take $new-n;
            $n = $new-n;
        }
    }
    return $in, |@result;
}
sub MAIN (UInt $in) {
    my @seq = collatz-seq $in;
    print "Collatz sequence for $in: ", @seq, "\n";
}
