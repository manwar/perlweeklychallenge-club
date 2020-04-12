##!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use feature qw/say/;

sub process_all_flips {
    my $binary = shift;
    my %all_results;

    my $max = 0;

    my @numbers = split //, $binary;

    for my $l_count ( 0 .. scalar(@numbers)-1 ) {
        for my $r_count ( $l_count .. scalar(@numbers)-1 ) {
            my $inverted   = do_flip( $l_count, $r_count, $binary );
            my $ones_count = () = $inverted =~ /1/gi;
            push @{ $all_results{$ones_count} }, [ $l_count, $r_count ];
            $max = $ones_count if $ones_count > $max;
        }
    }

    return $all_results{$max};
}

sub do_flip {

    my ( $l_count, $r_count, $input ) = @_;

    my @binary = split //, $input;

    for my $str_pos ( $l_count .. $r_count ) {
        $binary[$str_pos] = $binary[$str_pos] == 1 ? 0:1;
    }

    return join '', @binary;
}

my $result = process_all_flips("010");
warn Dumper \$result;
