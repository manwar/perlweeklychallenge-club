#!/usr/bin/perl
# The sum of three odd numbers is odd. Thus any three numbers with a sum
# of twelve contain at least one even number.
perl -MMath::Prime::Util=:all -E 'forcomp {say "@_"} 12, {n => 3}'
