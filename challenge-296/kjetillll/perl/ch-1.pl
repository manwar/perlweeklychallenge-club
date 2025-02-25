#https://theweeklychallenge.org/blog/perl-weekly-challenge-296/
#string compression
#input: string of presumably just A-Z chars, upper and lower case
#output: same string run-length encoded where repeating chars have a count in front

use strict; use warnings; use Test::More tests => 8;

sub rle { pop() =~ s{ ( [a-zA-Z] ) \1+ }{ length($&) . $1 }xger } #encoding
sub rld { pop() =~ s{ (\d+)(.)         }{ $2 x $1         }xger } #decoding

print rle($ARGV[0]), "\n" and exit if @ARGV;

for my $test (
  [ "abbc"       => "a2bc"    ],
  [ "aaabccc"    => "3ab3c"   ],
  [ "abcc"       => "ab2c"    ],
  [ "BbaacccccC" => "Bb2a5cC" ],
){
    my($input,$expected)=@$test;
    my $rle = rle($input);
    my $rld = rld($rle);
    is $rle => $expected;
    is $rld => $input;
}
