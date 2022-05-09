#!/usr/bin/env raku
# https://theweeklychallenge.org/blog/perl-weekly-challenge-163/

sub MAIN( $a, $b, *@c  ) {
    my @a = ( $a, $b, @c).flat;
    summation( @a );

    sub summation( @x ){
        say @x;
        my @y = @x;
        my @z = [];
        @z[0] = @y[1];
        loop (my $i = 0; $i < @y.elems; $i++) {
            @z[$i + 1] = @z[$i] + @y[$i + 2] if defined @y[$i + 2];
        }
        if @z.elems < 2 {
            say "Summation is '@z[* - 1]'";
        } else {
            summation(@z);
        }
    }
}

