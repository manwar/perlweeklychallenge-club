#!/usr/bin/perl
# 
# Task 1: MAC Address
# 
# You are given MAC address in the form i.e. hhhh.hhhh.hhhh.
# 
# Write a script to convert the address in the form hh:hh:hh:hh:hh:hh.
# 
# Example 1
# 
# Input:  1ac2.34f0.b1c2
# Output: 1a:c2:34:f0:b1:c2
# 
# Example 2
# 
# Input:  abc1.20f1.345a
# Output: ab:c1:20:f1:34:5a
# 
# MY NOTES: nice and easy.
#
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use feature 'state';
use Getopt::Long;
use Data::Dumper;


my $debug=0;
die "Usage: mac-address [--debug] mac\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;

my $mac = shift;

$mac =~ /^(\w\w)(\w\w)\.(\w\w)(\w\w)\.(\w\w)(\w\w)$/ ||
	die "mac-address: bad format $mac\n";
$mac = "$1:$2:$3:$4:$5:$6";

say $mac;
