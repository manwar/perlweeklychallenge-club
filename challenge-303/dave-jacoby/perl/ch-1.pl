#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use Algorithm::Permute;

my @examples = (

    [ 2, 1, 3, 0 ],
    [ 2, 2, 8, 8, 2 ],
);

for my $example (@examples) {
    my @output = even_3_digits( $example->@* );
    my $output = join ', ', @output;
    my $input  = join ', ', $example->@*;
    say <<"END";
    Input:  \@ints = ($input)
    Output: ($output)
END
}

sub even_3_digits(@array) {
    my @output;
    my $done;
    my $p = Algorithm::Permute->new( \@array, 3 );
    while ( my @p = $p->next() ) {
        my $int = 0 + ( join '', @p );
        next if $int < 100;
        next if $int % 2 != 0;
        next if $done->{$int}++;
        push @output, $int;
    }
    @output = sort @output;
    return @output;
}
