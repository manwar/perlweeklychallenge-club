#!/usr/bin/env perl
=begin comment
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2024-06-15
Challenge 273 Percentage of Character ( Perl )
-----------------------------------------
=cut
use v5.38;
use strict;
use warnings;
use Math::Round;

sub CharPC {
    my $wd = shift;
    my $ch = shift;
    my $ln = length($wd);
    my $count = length( $wd =~ s/[^\Q$ch\E]//rg );
    say nearest(1,(($count / $ln ) * 100));

}
my $number_args = $#ARGV + 1;
if ($number_args != 2) {
    print "Wrong entry. Please enter your full name.\n";
    exit;
}
my ($str, $char) = @ARGV;
CharPC($str, $char);;

=begin comment
SAMPLE OUTPUT
----------------------------------------------------------
perl PcofChar.pl perl e
25

perl PcofChar.pl java a
50

perl PcofChar.pl python m
0

perl PcofChar.pl ada a
67

perl PcofChar.pl ballerina l
22

perl PcofChar.pl analitik k
13
----------------------------------------------------------
=cut

