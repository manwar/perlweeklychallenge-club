# Only 100, please.
# You are given a string “123456789”.
# Write a script that would insert ”+” or ”-” in between digits
# so that when you evaluate, the result should be 100.

use strict;
use warnings;
use v5.20;

# I would like to try a brute force approach, in the sense
# that all valid combinations of "+" and "-" or nothing
# are inserted between digits.
#
# so between two consecutive digits, we
# have just 3 alternatives:
#
# - No insertion
# - a "+" sign
# - a "-" sign
#
# that means 3 alternatives between any consecutive digits.
# we will define an array of 8 (or l-1 in general, where l is
# the length of the input string in digits) elements,
# corresponding to the modification we will introduce between
# digits 1 and 2, then between digits 2 and 3, ... and finally
# between digits 8 and 9.
#
# the element will be:
# 0 or non existant (undef), meaning no insertion
# 1 meaning to insert a "+" sign
# 2 meaning to insert a "-" sign
#
# So if we want to check all combinations, that will be
# an array of at most 8 elements, with values 0, 1 or 2
#
# That array can be represented by a ternary number of up
# to 9 digits. So to try every combination, we can convert
# an integer variable to its base 3 representation, so
# incrementing that integer will generate another case
#

sub ter {
  my @m;
  my $n = shift;
  while ($n) {
    push @m, $n % 3;
    $n = int($n/3);
  }
  return @m;
}

#
# this function ter() will return an array of digits from 0 to 2
# from an integer
#
# lets analize an example. For the integer 567, we obtain the following
# array as a result: (0, 0, 0, 0, 1, 2)
#
# so the final result, after applying those modifications to the
# original string would be:
#
# 123456789
# 1
#        => 0 means join 1 & 2 (12)
# 2
#        => 0 means keep joining (123)
# 3
#        => 0 means keep joining (1234)
# 4
#        => 0 means keep joining (12345)
# 5
#        => 1 means insert a "+" sign (12345 + 6)
# 6
#        => 2 means insert a "-" sign (12345 + 6 - 7)
# 7
#        => undef means keep joining (12345 + 6 - 78)
# 8
#        => undef means keep joining (12345 + 6 - 789)
# 9
#
# so the final result is 12345 + 6 - 789 = 11562
#
# as it is different to our target result (200), we will need
# to continue trying
#
# we need a function to modify an imput string as a result
# of applying the integer according to the defined rules

sub modify_string {
    my ($in, $mod) = @_;
    my @mods = ter($mod);
    # if @m vector has more than needed elements, return undef
    return undef if length($in) < @mods + 1;
    my $result = '';
    for my $d (split '', $in) {
        my $m = (shift @mods) // 0;             # undefs at the end mean empty inter-digit appends
        $result .= $d . ('', ' + ', ' - ')[$m]; # just peek what to insert according to $m
    }
    return $result;
}

#
# modify_string returns a string with a mathematical formula that needs to be
# evaluated.
#
# For instance, modify_string(123456789, 567) will return
# "12345 + 6 - 789"
#
#
# we will get from command line the original string and the target number like this:
#

my ($input, $target) = @ARGV;
die "Usage; $0 <input number> <target sum>" unless $input =~ /^\d+$/ && $target =~ /^-?\d+$/;
say "Found answer(s):";
my $n = 0;
while (defined (my $x = modify_string ($input, $n))) {
  say "$target = $x" if eval $x == $target;
  $n++;    
}

#
# as we are just incrementing a number ($n) that will produce all
# available combinations, we are confident that we will be able to
# spot all valid solutions
#
# Example usage:
# $>perl ch-1.pl 123456789 100
# Found answer(s):
# 100 = 123 - 45 - 67 + 89
# 100 = 12 - 3 - 4 + 5 - 6 + 7 + 89
# 100 = 12 + 3 + 4 + 5 - 6 - 7 + 89
# 100 = 123 + 4 - 5 + 67 - 89
# 100 = 1 + 2 + 3 - 4 + 5 + 6 + 78 + 9
# 100 = 12 + 3 - 4 + 5 + 67 + 8 + 9
# 100 = 1 + 23 - 4 + 56 + 7 + 8 + 9
# 100 = 1 + 2 + 34 - 5 + 67 - 8 + 9
# 100 = 1 + 23 - 4 + 5 + 6 + 78 - 9
# 100 = 123 + 45 - 67 + 8 - 9
# 100 = 123 - 4 - 5 - 6 - 7 + 8 - 9
# $>
#
