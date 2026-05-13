#!/usr/bin/env perl

# Description of Challenge goes here

use 5.018;
use strict;
use warnings;
use File::JSON::Slurper qw(read_json);
use Data::Printer;

use Test2::V0;
plan tests => 5;

my $json_ref       = read_json( __FILE__ =~ s/pl$/json/r );
my $challenge_ref  = $json_ref->{ challenge };
my $input_vars_ref = $json_ref->{ input_vars };
my $examples_ref   = $json_ref->{ examples };

printf qq{Challenge: %s Task %s: %s\n\n},
    $challenge_ref->{ week },
    $challenge_ref->{ task },
    $challenge_ref->{ name };

is( power_string( $_->{ in } ), $_->{ out }->[0], $_->{ name } )
    for @{ $examples_ref };

sub power_string {
    my $str = $_[0]->[0];
    printf qq{Input: %s = "%s"\n}, $input_vars_ref->[0], $str;
    my $result = q{0};

    return 1 if ( $str =~ /^.$/ );
    my $long_re = qr{((.)\g2+)};

    while ( $str =~ m/$long_re/g ) {
        my $long_str = $1;
        my $lsl = length $long_str;
        $result = $lsl if ( $lsl > $result );
    }

    printf qq{Output: %s\n}, $result;
    return $result;
}

