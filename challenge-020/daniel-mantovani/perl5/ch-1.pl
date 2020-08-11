# Write a script to accept a string from command line and split it
# on change of character. For example, if the string is “ABBCDEEF”,
# then it should split like “A”, “BB”, “C”, “D”, “EE”, “F”.

use strict;
use warnings;
use v5.10;
use utf8;
use Encode;
use open qw(:std :utf8);    # for other languages

# we start by reading string from command line

my $string = Encode::decode 'utf8', $ARGV[0];
die "Usage: $0 <string>" unless $string;

my $current;                # this to store current char to see if changed

while ($string) {
    my $char = $1
      if $string =~ s/(.)//;   # there are maaaany ways to do this, but the
                               # idea is to take the first char from $string and
                               # store it in $char
    print "\n"
      unless !defined $current
      || $char eq $current;    # new line on change of character
        # note that on first pass $current will not be defined,
        # so we don't get a newline before first char
    $current = $char;    # keep current char for next pass
    print $char;
}
print "\n";              # to end last line
