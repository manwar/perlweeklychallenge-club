#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (

    [ 1, 0, 1 ],
    [ 1, 1, 0 ],
    [ 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1 ],
);

for my $example (@examples) {
    my $binary = join ', ', $example->@*;
    my @output = binary_prefix( $example->@* );
    my $output = join ', ', @output;
    say <<"END";
    Input:  \@binary = ($binary)
    Output: ($output)
END
}

sub binary_prefix (@binary) {
    my @output;
    for my $i ( 0 .. $#binary ) {
        my @slice = @binary[ 0 .. $i ];
        my $bin   = join '', @slice;
        my $dec   = oct( "0b" . $bin );
        push @output, is_prime($dec) ? 'true' : 'false';
    }
    return @output;
}

sub is_prime ($n) {
    die "Bad number $n" unless length $n;
    return 0 if $n == 0;
    return 0 if $n == 1;
    for ( 2 .. sqrt $n ) { return 0 unless $n % $_ }
    return 1;
}