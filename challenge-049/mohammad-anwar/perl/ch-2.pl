#!/usr/bin/perl

use strict;
use warnings;

use Cache::LRU;

my $cache = Cache::LRU->new(size => 3);

$cache->set(1 => 3);
$cache->set(2 => 5);
$cache->set(3 => 7);

print "get(2) => ", $cache->get(2), "\n";
print "get(1) => ", $cache->get(1), "\n";

print "get(4) => ", $cache->get(4)||-1, "\n";

$cache->set(4 => 9);

print "get(3) => ", $cache->get(3)||-1, "\n";
