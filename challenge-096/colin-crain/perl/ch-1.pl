#! /opt/local/bin/perl
#
#       backwards_sentence.pl
#
#       TASK #1 › Reverse Words
#         Submitted by: Mohammad S Anwar
#         
#             You are given a string $S.
# 
#             Write a script to reverse the order of words in the given string.
#             The string may contain leading/trailing spaces. The string may have
#             more than one space between words in the string. Print the result
#             without leading/trailing spaces and there should be only one space
#             between words.
# 
#             Example 1:            
#                 Input: $S = "The Weekly Challenge"
#                 Output: "Challenge Weekly The"
#  
#             Example 2:          
#                 Input: $S = "    Perl and   Raku are  part of the same family  "
#                 Output: "family same the of part are Raku and Perl"
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

sub rev_sentence {

    return join ' ', reverse $_[0] =~ m/(\S+)/g;

}


say rev_sentence("    Perl and   Raku are  part of the same family  ");





## ## ## ## ## tests:

__END__

use Test::More;

my ($str,$out);

$str = "The Weekly Challenge";
$out = "Challenge Weekly The";
is ( rev_sentence($str), $out, "ex 1");

$str = "    Perl and   Raku are  part of the same family  ";
$out = "family same the of part are Raku and Perl";
is ( rev_sentence($str), $out, "ex 2");

done_testing();
