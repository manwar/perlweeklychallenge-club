#! /opt/local/bin/perl
#
#       leonardo_numbers.pl
#
#       PWC41
#       TASK #2
#           Write a script to display first 20 Leonardo Numbers. Please checkout wiki page for more information.
#           For example:
#
#           L(0) = 1
#           L(1) = 1
#           L(2) = L(0) + L(1) + 1 = 3
#           L(3) = L(1) + L(2) + 1 = 5
#           and so on.
#
#       method: because we have the growing series directly available to
#           refer to no recursion is required. I have made the function
#           return a list for any quantity > 0, displayed with a nice little
#           header.
#
#           As-is can handle up to L(90)
#               L(90) = 5,760,134,388,741,632,239
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my $quan = shift @ARGV // 20;

say "the first $quan Leonardo numbers:";
say "";
say "index  |  number";
say "-------+--------";

my $i;
printf "%-2d        %d\n", ++$i, $_ for make_leonardo($quan)->@*;


## ## ## ## ## SUBS

sub make_leonardo {
##  construct a list of the first n Leonardo numbers
##  requires no recursion if we have the growing list to refer to
    my $quan  = shift;
    my $list  = [1];
    push $list->@*, 1 if $quan > 1;                         ## now [1,1]
    while ( scalar $list->@* <= $quan-1 ) {
        push $list->@*, $list->[-1] + $list->[-2] + 1;      ## sum last two elements + 1
    }
    return $list;
}
