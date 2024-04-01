#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Carp;
use List::Compare;

my @examples = (

    { s => "Perl",   t => "Preel" },
    { s => "Weekly", t => "Weeakly" },
    { s => "Box",    t => "Boxy" },
);

for my $example (@examples) {
    my $output = odd_character($example);
    my $s      = $example->{s};
    my $t      = $example->{t};

    say <<~"END";
    Input:  \$s = "$s" \$t = "$t" 
    Output: $output
    END
}

sub odd_character ($input) {
    my @s = sort split //, $input->{s};
    my @t = sort split //, $input->{t};
    say join  ', ', @s;
    say join  ', ', @t;
    return 7;
    my @output;
    while ( @s && @t ) {
        if ( $s[0] eq $t[0] ) {
            shift @s;
            shift @t;
        }
        else {
            if ( scalar @s > scalar @t ) {
                push @output, shift @s;
            }
            elsif ( scalar @s < scalar @t ) {
                push @output, shift @t;
            }
            else { croak 'Impossible Scenario' }
        }
    }
    push @output, @s if @s;
    push @output, @t if @t;
    return shift @output;
}
