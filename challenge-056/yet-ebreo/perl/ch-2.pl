#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

my @tree = (5, [4, [11, [7], [2]]], [8, [13], [9, [1]]]) ;
my $total = $ARGV[0]||22;

sub traverse {
    my ($t,$sum,$path) = @_;

    if ($t->[1]) { 
        traverse ($t->[1],$sum+$t->[0],"$path->$t->[0]");
    } elsif ($t->[0]+$sum == $total) {
        say "$path->$t->[0]";
    }
    if ($t->[2]) {
        traverse ($t->[2],$sum+$t->[0],"$path->$t->[0]");
    }
}
traverse(\@tree,0,"");

=begin
perl .\ch-2.pl 22
->5->4->11->2

perl .\ch-2.pl 26
->5->8->13

perl .\ch-2.pl 23
->5->8->9->1
=cut