#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       hey-hexy-whatcha-doin.pl
#
#         Hexadecimal Words
#         Submitted by: Ryan J Thompson
#         As an old systems programmer, whenever I needed to come up with a
#         32-bit number, I would reach for the tired old examples like
#         0xDeadBeef and 0xC0dedBad. I want more!
# 
#         Write a program that will read from a dictionary and find 2- to
#         8-letter words that can be “spelled” in hexadecimal, with the
#         addition of the following letter substitutions:
# 
#             o ⟶ 0 (e.g., 0xf00d = “food”)
#             l ⟶ 1
#             i ⟶ 1
#             s ⟶ 5
#             t ⟶ 7
#     
#         You can use your own dictionary or you can simply open
#         ../../../data/dictionary.txt (relative to your script’s location
#         in our GitHub repository) to access the dictionary of common
#         words from Week #161.
# 
#         Optional Extras (for an 0xAddedFee, of course!) Limit the number
#         of “special” letter substitutions in any one result to keep that
#         result at least somewhat comprehensible. (0x51105010 is an actual
#         example from my sample solution you may wish to avoid!)
# 
#         Find phrases of words that total 8 characters in length (e.g.,
#         0xFee1Face), rather than just individual words.

#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use List::Util qw( sum0 );

my $dict = './dict.txt';
open my $fh, '<', $dict or die "can't open dict $dict: $!\n";
my @dict =  grep { /^[a-folist]{2,8}$/ } 
            map  { chomp; $_           } <$fh>;

my %dlen;
push $dlen{ length $_ }->@*, $_ for @dict;

for my $len (reverse(2..8)) {
    say "$len characters:";
    say (sprintf "%10s  =>  %-10s", $_, tr/olist/01157/r) for $dlen{$len}->@*;
    say '';
}


