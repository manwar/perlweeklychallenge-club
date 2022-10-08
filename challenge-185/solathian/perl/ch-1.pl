#!usr/bin/perl -w
use strict;
use warnings;

use feature ('say', 'signatures');
no  warnings 'experimental';

# Challange 185 - 1 - MAC Address
# You are given MAC address in the form i.e. hhhh.hhhh.hhhh.
# Write a script to convert the address in the form hh:hh:hh:hh:hh:hh.


# my $testString = "1ac2.34f0.b1c2";    # 1a:c2:34:f0:b1:c2
# my $testString = "abc1.20f1.345a";    # ab:c1:20:f1:34:5a
# mac($testString);

sub mac($string)
{
    $string =~ s/(.{2})(.{2})   \.  (.{2})(.{2})     \.  (.{2})(.{2})/$1:$2:$3:$4:$5:$6/x;
    
    say $string;
}