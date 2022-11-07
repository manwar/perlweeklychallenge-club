#!/usr/bin/perl
use 5.030;
use warnings;
use English;


sub usage {
print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <target> [<array> ...]
  
    <target>         target character
    [<array> ...]    array of characters
-USAGE-
    exit(0);
}

unless (@ARGV) {
    usage;
}

my $target = shift;
my @array = @ARGV;
my $result = $target;

for my $char (sort @array) {
    if ($char gt $target) {
        $result = $char;
        last;
    }
}

say $result;
