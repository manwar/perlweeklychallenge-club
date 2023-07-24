#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my $ops = 0;

    until @ints.all == 0 {
        my $pick = @ints.grep({ $_ != 0 }).min;
        @ints = @ints.map({ $_ == 0 ?? 0 !! $_ - $pick });
        $ops++;
    }

    say $ops;
}