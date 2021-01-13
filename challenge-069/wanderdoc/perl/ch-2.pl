#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
A “0/1 string” is a string in which every character is either 0 or 1.
Write a script to perform switch and reverse to generate S1000 as described below:

switch: Every 0 becomes 1 and every 1 becomes 0. For example, “101” becomes “010”.
reverse: The string is reversed. For example, "001” becomes “100”.

To generate S1000 string, please follow the rule as below:

S0 = “”
S1 = “0”
S2 = “001”
S3 = “0010011”
…
SN = SN-1 + “0” + switch(reverse(SN-1))

=cut

my $string = '';
my $counter = 0;


while ( $counter < 30 )
{
     my $new_part = switch(scalar reverse($string));
     $string .= '0';
     $string .= $new_part;
     printf("S%02d: %10d$/", ++$counter, length($string));
}
# print $string, $/; # length($string) = 1_073_741_823.
sub switch
{
     my $str = $_[0]; $str =~ tr/01/10/; return $str;
}
