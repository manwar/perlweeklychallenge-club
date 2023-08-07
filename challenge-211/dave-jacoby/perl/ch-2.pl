#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Algorithm::Permute;
use Getopt::Long;
use List::Util qw{ sum };

my @examples = (

    [ 1, 2, 3, 4, 5, 6, 7, 8 ],
    [ 1, 3 ],

);

my $v = 0;
GetOptions( 'verbose' => \$v, );

for my $e (@examples) {
    my $o = sse( $e->@* );
    my $i = join ', ', $e->@*;

    say <<"END";
    Input:  \@list = ($i)
    Output: $o
END
}

sub sse (@array) {
    my $permute = Algorithm::Permute->new( \@array );
    while ( my @result = $permute->next ) {
        for my $i ( 0 .. -2 + scalar @result ) {
            my @a1  = @result[ 0 .. $i ];
            my @a2  = @result[ $i + 1 .. -1 + scalar @result ];
            my $av1 = ( sum @a1 ) / ( scalar @a1 );
            my $av2 = ( sum @a2 ) / ( scalar @a2 );
            say join "    ", $i, ( join ',', @a1 ), ( join ',', @a2 ), $av1,
                $av2
                if $v;
            return 'true' if $av1 == $av2;
        }
    }
    return 'false';
}
