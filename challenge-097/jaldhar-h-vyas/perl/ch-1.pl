#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
  $PROGRAM_NAME <S> <N>
  
    <S>    a message to encrypt
    <N>    number of letters to shift left in cipher
-USAGE-
    exit 0;
}

sub rotateLeft {
    my ($str, $n) = @_;

    for (1 .. $n) {
        unshift @{$str}, pop @{$str};
    }

    return @{$str};
}

if (scalar @ARGV != 2) {
    usage;
}

my ($S, $N) = @ARGV;

my @plain = qw/ A B C D E F G H I J K L M N O P Q R S T U V W X Y Z /;
my @cipher = rotateLeft(\@plain, $N);

say join q{}, map { $cipher[ord($_) - ord('A')] // $_; } (split //, $S);