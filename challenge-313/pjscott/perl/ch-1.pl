#!/usr/bin/perl
use 5.017;
use warnings;
@ARGV == 2 or die "Usage: $0 <input> <typed>";
$_ = shift;
s/(.)/quotemeta($1)."+"/eg;

say shift =~ /$_/ ? 'true' : 'false';
