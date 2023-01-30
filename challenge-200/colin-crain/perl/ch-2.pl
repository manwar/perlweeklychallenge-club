#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       seven-seconds.pl
#
#       Seven Segment 200
#         Submitted by: Ryan J Thompson
# 
#         A seven segment display is an electronic component, usually used
#         to display digits. The segments are labeled 'a' through 'g' as
#         shown:
# 
#             a
#           f   b
#             g
#           e   c
#             d 
# 
#         The encoding of each digit can thus be represented compactly as a
#         truth table:
# 
#         my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc
#         abcdefg abcfg>; For example, $truth[1] = ‘bc’. The digit 1 would
#         have segments ‘b’ and ‘c’ enabled.
# 
#         Write a program that accepts any decimal number and draws that
#         number as a horizontal sequence of ASCII seven segment displays,
#         similar to the following:
# 
# 
#             -------  -------  -------
#                   |  |     |  |     |
#                   |  |     |  |     |
#             -------
#             |        |     |  |     |
#             |        |     |  |     |
#             -------  -------  -------
# 
#         To qualify as a seven segment display, each segment must be drawn
#         (or not drawn) according to your @truth table.
# 
#         The number "200" was of course chosen to celebrate our 200th
#         week!
# 
# 
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use open ':std', ':encoding(UTF-8)';

## given encoding method
my @truth = qw( abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg );

## input
my $num = shift @ARGV // 31415926;
my @out;

for my $d (split //, $num) {
    $out[0] .= $truth[$d]          =~ s/(a?)[bcdefg]*/   $1 ? ' ╺╸ ' : '    '/er;
    $out[1] .= reverse $truth[$d]  =~ s/a?(b?)[cde]*(f?)g?/
                                              ($1 ? '┃' : ' ') 
                                            . '  ' 
                                            . ($2 ? '┃' : ' ')/er;
    $out[2] .= $truth[$d]          =~ s/[abcdef]*(g?)/   $1 ? ' ━━ ' : '    '/er;
    $out[3] .= reverse $truth[$d]  =~ s/a?b?(c?)d?(e?)f?g?/
                                              ($1 ? '┃' : ' ') 
                                            . '  ' 
                                            . ($2 ? '┃' : ' ')/er;
    $out[4] .= $truth[$d]          =~ s/[abc]*(d?)[efg]*/$1 ? ' ╺╸ ' : '    '/er;
    
    $out[$_] .= '  ' for (0..4);
}

## output
for my $i (0..4) {
    say $out[$i];
}
    



