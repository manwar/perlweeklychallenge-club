use strict;
use warnings;
use feature "say";

my %seen;
my $max = 0;

while (my $line = <DATA>) {
    my $num = $1 if $line =~ /^(\d+)/;
    $seen{$num} = 1;
    $max = $num if $num > $max;
}
for my $i (1..$max) {
    say "Missing number = ", $i unless exists $seen{$i};
}

__DATA__
11, Line Eleven
1, Line one
9, Line Nine
13, Line Thirteen
2, Line two
6, Line Six
8, Line Eight
10, Line Ten
7, Line Seven
4, Line Four
14, Line Fourteen
3, Line three
15, Line Fifteen
5, Line Five
