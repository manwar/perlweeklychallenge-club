use v6;

my $file = "11, Line Eleven
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
5, Line Five";

my %seen;
my $max = 0;

for $file.lines -> $line {
    my $num = $line ~~ /^(\d+)/;
    %seen{$num} = 1;
    $max = $num if $num > $max;
}
for 1..$max -> $i {
    say "Missing number = ", $i unless %seen{$i}:exists;
}
