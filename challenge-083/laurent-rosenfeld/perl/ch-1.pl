use strict;
use warnings;
use feature "say";

my $str = $ARGV[0] // "The purpose of our lives is to be happy";
my @words = split /\s+/, $str;
say length join "", @words[1 .. $#words -1];
