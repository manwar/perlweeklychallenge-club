#! /usr/bin/perl

# PWCC_185_P1_MAC_Robbie-Hatley.pl

=pod

Task 1: MAC Address
Submitted by: Mohammad S Anwar

You are given MAC address in the form i.e. hhhh.hhhh.hhhh.

Write a script to convert the address in the form hh:hh:hh:hh:hh:hh.
Example 1

Input:  1ac2.34f0.b1c2
Output: 1a:c2:34:f0:b1:c2

Example 2

Input:  abc1.20f1.345a
Output: ab:c1:20:f1:34:5a

=cut

# NOTE: Input should be space-separated 'quoted' command-line arguments:
# ./PWCC_185_P1_MAC_Robbie-Hatley.pl '1ac2.34f0.b1c2' 'abc1.20f1.345a'


# NOTE: Output will be (comma-separated list of 'quoted' items):
# ('1a:c2:34:f0:b1:c2', 'ab:c1:20:f1:34:5a')


use v5.36;
$,="', '";
my @list = @ARGV;
my $size = scalar @list;
my $H = qr([0-9a-f]);
for ( my $idx = 0 ; $idx < $size ; ++$idx )
{
   $list[$idx] =~ s/\.//g;
   $list[$idx] =~ s/($H)($H)(?=$H)/$1$2:/g;
}

print "('"; print @list; print "')\n";