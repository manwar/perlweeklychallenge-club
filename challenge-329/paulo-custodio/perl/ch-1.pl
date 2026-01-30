#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(uniq);

@ARGV==1 or die "usage: $0 str\n";
my $str = $ARGV[0];
$str =~ s/\D/ /g;
my @nums = uniq(split ' ', $str);
say join ", ", @nums;

