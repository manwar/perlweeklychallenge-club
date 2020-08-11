#!/usr/bin/perl

use strict;
use warnings;
use lib '.';
use Div qw(debug);
my $DEBUG=0;

{
my $a = Div->new(4);
my $b = 2;
my $r = $a/$b;
print "Division $a/$b = $r\n";
debug($a,$b,$r) if $DEBUG;
}

{
my $a = Div->new(4);
my $b = 0;
my $r = $a/$b;
print "Division $a/$b = $r\n";
debug($a,$b,$r) if $DEBUG;
}

{
my $a = Div->new(5);
my $b = 3;
my $r = $a/$b;
print "Division $a/$b = $r\n";
debug($a,$b,$r) if $DEBUG;
}

{
my $a = Div->new(8);
my $b = 0;
my $r = $a/$b;
print "Division $a/$b = $r\n";
debug($a,$b,$r) if $DEBUG;
}

