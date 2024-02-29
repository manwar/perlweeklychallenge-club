#!/usr/bin/perl
print scalar grep {0==length($_)%2} @ARGV, "\n";
