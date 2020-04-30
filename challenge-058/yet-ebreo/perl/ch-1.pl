#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

sub compare {
    0+eval "@_"=~s/\S+/\"$&\"/gr =~s/ / cmp /r =~ s/[._]0+\"/\"/gr =~s/_/!/gr =~ s/\d+/sprintf "%09d",$&/gre;
}

my @num_set = (  
    [qw(0.1       1.1)],
    [qw(2.0       1.2)],
    [qw(1.2     1.2_5)],
    [qw(1.2.1   1.2_1)],
    [qw(1.2.1   1.2.1)],
    [qw(3_3       3.3)],
    [qw(1.01.1  1.1.1)],
    [qw(2_0       2.0)], 
    [qw(1.9      1.10)], 
    [qw(1.002     1.2)]
);

#Notes:
# - leading 0's are ignored such that 1.002 is eq 1.2
# - 2_00 , 2.0 and 2 are considered equal
for my $num (@num_set) {
    my $c = compare(@{$num});
    printf "%10s %s %-10s %2s\n", $num->[0], qw(< = >)[$c+1], $num->[1], $c;
}

=begin
perl .\ch-1.pl
       0.1 < 1.1        -1
       2.0 > 1.2         1
       1.2 < 1.2_5      -1
     1.2.1 > 1.2_1       1
     1.2.1 = 1.2.1       0
       3_3 < 3.3        -1
    1.01.1 = 1.1.1       0
       2_0 = 2.0         0
       1.9 < 1.10       -1
     1.002 = 1.2         0
=cut