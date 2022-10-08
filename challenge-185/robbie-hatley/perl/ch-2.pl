#! /usr/bin/perl

# PWCC_185_P2_Mask_Robbie-Hatley.pl

=pod

Task 2: Mask Code
Submitted by: Mohammad S Anwar

You are given a list of codes in many random format.

Write a script to mask first four characters (a-z,0-9) and keep the rest as it is.
Example 1

Input: @list = ('ab-cde-123', '123.abc.420', '3abc-0010.xy')
Output: ('xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy')

Example 2

Input: @list = ('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f')
Output: ('xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f')

=cut

# NOTE: Input should be space-separated 'quoted' command-line arguments:
# ./PWCC_185_P2_Mask_Robbie-Hatley.pl 'ab-cde-123' '123.abc.420' '3abc-0010.xy'
# ./PWCC_185_P2_Mask_Robbie-Hatley.pl '1234567.a' 'a-1234-bc' 'a.b.c.d.e.f'

# NOTE: Output will be (comma-separated list of 'quoted' items):
# ('xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy')
# ('xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f')

use v5.36;
$,="', '";
my @list = @ARGV;
my $size = scalar @list;
my $C = qr([0-9a-z]);
for ( my $idx = 0 ; $idx < $size ; ++$idx )
{
   $list[$idx] =~ s/$C/@@@%%%&&&/ for (1..4);
   $list[$idx] =~ s/@@@%%%&&&/x/  for (1..4);
}

print "('"; print @list; print "')\n";
