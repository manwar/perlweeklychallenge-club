#! /usr/bin/perl
use strict;
use warnings;

use Test::More tests => 1;

is compact('1,2,3,4,9,10,14,15,16'), '1-4,9,10,14-16';

use String::Util::Range qw{ convert_sequence_to_range };
sub compact {
    my ($seq_string) = @_;
    join ',', @{ convert_sequence_to_range(
        array     => [split /,/, $seq_string],
                      threshold => 3,
                      separator => '-')
    };
}
