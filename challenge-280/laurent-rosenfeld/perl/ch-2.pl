use strict;
use warnings;
use feature 'say';

sub count_asterisks {
    my $in = shift;
    $in =~ s/\|.*?\|//g;
    return +($in =~ tr/*//);
}

my @tests = ("p|*e*rl|w**e|*ekly|", "perl",
          "th|ewe|e**|k|l***ych|alleng|e");
for my $test (@tests) {
    printf "%-30s => ", $test;
    say count_asterisks $test;
}
