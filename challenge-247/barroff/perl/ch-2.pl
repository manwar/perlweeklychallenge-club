#!/usr/bin/env perl

use v5.38;

sub most_frequent_letter_pair ($s) {
    use List::Util qw( max );
    my %pairs;
    while ( $s =~ /(?=(\w\w))/g ) {
        $pairs{$1}++;
    }
    my $maximum_repitition = max( values %pairs );
    my @repeated_keys =
      sort( grep( { $pairs{$_} == $maximum_repitition } keys %pairs ) );
    return $repeated_keys[0];
}

sub MAIN() {
    if (@ARGV) {

        #| Run on command line argument
        say most_frequent_letter_pair( $ARGV[0] );
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 2;

        is most_frequent_letter_pair('abcdbca'), 'bc', "works for ('abcdbca')";
        is most_frequent_letter_pair('cdeabeabfcdfabgcd'), 'ab',
          "works for ('cdeabeabfcdfabgcd')";
    }
}

MAIN();
