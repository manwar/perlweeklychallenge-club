#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Algorithm::Permute;

my @examples = ( "IDID", "III", "DDI" );

for my $e (@examples) {
    my @output = di_string_match($e);
    my $output = join "\n        ", sort
        map { qq{($_)} }
        map { join ', ', $_->@* } @output;

    say <<~"END";
    Input:  \$str = $e

    Output: $output
    END
}

sub di_string_match ($str) {
    my @output;
    my @s = 0 .. length $str;
    my $p = Algorithm::Permute->new( [@s] );
OUTER: while ( my @perm = $p->next ) {
        for my $i ( 0 .. -1 + length $str ) {
            my $l = substr $str, $i, 1;
            if ( $l eq 'I' ) {
                next OUTER unless $perm[$i] < $perm[ $i + 1 ];
            }
            elsif ( $l eq 'D' ) {
                next OUTER unless $perm[$i] > $perm[ $i + 1 ];
            }
        }
        push @output, \@perm;
    }

    return @output;
}

