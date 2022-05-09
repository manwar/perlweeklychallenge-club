#!/usr/bin/env raku
# https://theweeklychallenge.org/blog/perl-weekly-challenge-163/

sub MAIN( $a, $b, *@c  ) {
    my $bitsum = 0;
    my @a = ( $a, $b, @c).flat;
    loop (my $i = 0; $i < @a.elems; $i++) {
        $bitsum += sum( @a.shift X+& @a );
    }
    say $bitsum;
}

