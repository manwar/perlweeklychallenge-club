#!/usr/bin/env perl

# Instance Count
#
# Ryan Thompson <rjt@cpan.org>

use strict;
use warnings;
no  warnings 'uninitialized';
use List::Util qw< max >;

# -csv must be first argument, in case you need to process a file named '-csv'
# Usually I'd use Getopt::Long, but this is even simpler.
my $csv = $ARGV[0] eq '-csv' ? shift : 0;

my %count; # string => count
chomp, $count{$_}++ while <>;

# Pretty output is better than a lower constant on your complexity. :-)
my $key_width = max map { length }  keys  %count;
my $val_width = max map { length } values %count;
my $fmt = $csv ? "%s,%d\n" : "%-${key_width}s %${val_width}d\n";

# Sort by result count, then alphabetically by keyword
printf $fmt, $_, $count{$_}
    for sort { $count{$a} <=> $count{$b} || $a cmp $b } keys %count;
