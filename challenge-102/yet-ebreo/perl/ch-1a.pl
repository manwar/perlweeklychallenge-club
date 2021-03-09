#! /usr/bin/perl

use strict;
use warnings;

my $N = $ARGV[0] || 2;
my @rn;

#Some optimization, still inefficient, was able to solve N = 9, took a long while
for my $base (2,4,6,8) {
    for my $r (0..~-10**~-$N) {
        $_ = $base*10**~-$N+$r;
        ($_-reverse>-1)&&sqrt($_+reverse)!~/\./&&sqrt($_-reverse)!~/\./ && (push @rn,$_)
    }
}
print "Rare with $N digits: @rn\n";
# =begin
# Rare with 1 digits: 2 8
# Rare with 2 digits: 65
# Rare with 3 digits: 242
# Rare with 4 digits: 
# Rare with 5 digits: 20402 24642
# Rare with 6 digits: 621770
# Rare with 7 digits: 2004002 2138312 2468642
# Rare with 8 digits: 85099058
# Rare with 9 digits: 200040002 204060402 242484242 281089082 291080192
# =cut