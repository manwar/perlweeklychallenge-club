#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub split_on_change {
    my ($string) = @_;
    my $i;
    grep ++$i % 2, $string =~ /((.)\2*)/g
}

use Test::More tests => 1;
is_deeply [split_on_change('ABBCDEEF')],
          [qw[ A BB C D EE F ]];
