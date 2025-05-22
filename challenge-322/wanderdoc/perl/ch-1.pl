#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string and a positive integer.

Write a script to format the string, removing any dashes, in groups of size given by the integer. The first group can be smaller than the integer but should have at least one character. Groups should be separated by dashes.

Example 1

Input: $str = "ABC-D-E-F", $i = 3
Output: "ABC-DEF"


Example 2

Input: $str = "A-BC-D-E", $i = 2
Output: "A-BC-DE"


Example 3

Input: $str = "-A-B-CD-E", $i = 4
Output: "A-BCDE"
=cut


use Test2::V0 -no_srand => 1;

is(format_string("ABC-D-E-F", 3), "ABC-DEF", "Example 1");
is(format_string("A-BC-D-E",  2), "A-BC-DE", "Example 2");
is(format_string("-A-B-CD-E", 4), "A-BCDE",  "Example 3");
done_testing();

sub format_string
{
     my ($str, $i) = @_;
     $str =~ s/^\-//;
     $str = reverse $str;
     $str =~ s/^\-//;
     my (@output, @group);
     my @source = split(//, $str);
     for my $idx ( 0 .. $#source )
     {
          my $chr = $source[$idx];
          if ( scalar @group < $i )
          {
               if ( $chr ne '-' )
               {
                    push @group, $chr;
                    if ( $idx == $#source )
                    {
                         push @output, @group;
                    }
               }
          }
          elsif ( scalar @group == $i )
          {
               if ( $chr eq '-' )
               {
                    push @group, $chr;
                    push @output, @group;
                    @group = ();
               }
               else # not defined: what if the group length in source is bigger than $i?
               {
                    push @group, '-'; # however in this case one could simply
                                      # strip all the dashes and add them as necessary.
                    push @output, @group;
                    @group = ($chr);
               }
          }
     }
     return reverse join('',@output)
}
