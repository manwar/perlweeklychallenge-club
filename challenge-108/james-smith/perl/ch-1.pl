#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my $scalar = 1;
my @array  = (1);
my %hash   = (1=>1);
my $code   = sub {my$x=1;};

say'';
say    'Type     Ref type    Address';
say    '-------  ----------  ----------------';
printf "Scalar   %-8s    %s\n", get_loc( \$scalar );
printf "Array    %-8s    %s\n", get_loc( \@array );
printf "Hash     %-8s    %s\n", get_loc( \%hash );
printf "Sub      %-8s    %s\n", get_loc( $code );
say'';

sub get_loc {
  return $_[0] =~ m{(REF|ARRAY|HASH|SCALAR|CODE)\((.*?)\)};
}

