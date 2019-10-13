#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my $in_str = shift // "Perl {Daily,Weekly,Monthly,Yearly} Challenge";
my ($start, $options, $end) = $in_str =~ /([^{]+) \{ ([^}]+) \} (.+)/x;
s/^ +| +$//g for ($start, $options, $end); # removing leading or trailing spaces
say "$start $_ $end" for split / *, */, $options;
