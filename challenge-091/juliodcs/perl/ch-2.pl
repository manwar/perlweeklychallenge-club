use strict;
use warnings;
use Lingua::EN::Numbers 'num2en';
use feature 'say';
use experimental 'signatures';

my @input = @ARGV;

sub advance($pos = 0) {
    return 1 if $pos == @ARGV - 1;
    return 0 if $pos >= @ARGV || $input[$pos] == 0;
    return advance($pos + $input[$pos]);
}

say advance;
