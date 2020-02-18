#! /usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my @people = (1) x 50;
my $sword = 0;
my $next = sub {
    do { $sword = (1 + $sword) % @people } until $people[$sword];
};
while (1 < (my $living = grep $_, @people)) {
    # print 1 + $sword, ' kills ';
    $next->();
    # print 1 + $sword, $living == 2
    #     ? ' and the survivor is '
    #     : ' and passes the sword to ';
    $people[$sword] = 0;
    $next->();
    # say 1 + $sword;
}
say 1 + $sword;
