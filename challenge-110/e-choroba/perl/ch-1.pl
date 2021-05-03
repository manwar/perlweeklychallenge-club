#!/usr/bin/perl
use warnings;
use strict;

my $VALID = qr/^\s* (?: \([0-9]{2}\)
                      | \+[0-9]{2}
                      |   [0-9]{4}
                    ) \s+
                    [0-9]{10} $/x;

sub valid_phone_numbers {
    my @valid = grep /$VALID/, @_;
    chomp @valid;
    return \@valid
}

use Test::More tests => 1;

is_deeply valid_phone_numbers(<DATA>),
    ['0044 1148820341',
     ' +44 1148820341',
     '(44) 1148820341'];

__DATA__
0044 1148820341
 +44 1148820341
  44-11-4882-0341
(44) 1148820341
  00 1148820341
