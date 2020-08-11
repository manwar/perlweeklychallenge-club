#!/usr/bin/env perl6
use v6;

sub MAIN(UInt:D $nth, *@sequence) {
    die "Only provide numbers" if @sequence.first( { $_ !~~ m:s/^ <[ 0 .. 9 ]>+ $/ } ).defined;

    my @in = @sequence;
    for 1..$nth {
        @sequence = ();
        my $last;
        for @in -> $num {
            @sequence.push: $num - $last if $last.defined;
            $last = $num;
        }
        @in = @sequence;
    }

    say @sequence.join(" ");
}


