#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-049/
#
#  Write a script to demonstrate LRU Cache feature. It should support operations get and set. Accept the capacity of the LRU Cache as command line argument.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 02/29/2020 08:53:24 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use Cache::LRU;

my $size = $ARGV[0] or die 'Usage: script size';

my $cache = Cache::LRU->new(
    size => $size
);


use Test::More;

$cache->set(1=>3);
$cache->set(2=>5);
$cache->set(3=>7);

is($cache->get(2),5);
is($cache->get(1),3);
is($cache->get(4),undef);
$cache->set(4=>9);
is($cache->get(3),undef);
