#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

# Problem: https://perlweeklychallenge.org/blog/perl-weekly-challenge-126/ TASK #2

my $field = <<'EOD';
x * * * x * x x x x
* * * * * * * * * x
* * * * x * x * x *
* * * x x * * * * *
x * * * x * * * * x
EOD

my $MINE = 'x';

# offset vector from current cell
my $vec = [
    [ 1, 0 ], [ -1,  0 ], [  0, 1 ], [  0, -1 ],  
    [ 1, 1 ], [  1, -1 ], [ -1, 1 ], [ -1, -1 ],
];

# A matrix: m and it's dimension: (x, y)
my $m = [];
my ($y, $x) = (0, 0);

# parse field into matrix 
my @lines = split(/\n/, $field);
$y ||= scalar @lines;
foreach (reverse (@lines)) {
    my @cell = split(/ /, $_);
    $x ||= scalar @cell;
    push @{$m}, \@cell;
}

# zero offset
$y--; $x--;

foreach my $j (0 .. $y) {
    foreach my $i (0 .. $x) {

        # if cell contains a MINE, skip it
        # otherwise init adjacent MINE count to 0
        next if ($m->[$j][$i] eq $MINE);
        $m->[$j][$i] = 0;

        # inspect adjacent cells
        foreach my $v ( @{$vec} ) {
            my ($a, $b) = @{$v};
            my ($c, $d) = ($j+$a, $i+$b);

            # out of bounds 
            next if ($c < 0 or $c > $y) or ($d < 0 or $d > $x);

            # total adjacent mines
            $m->[$j][$i] += 1 if ($m->[$c][$d] eq $MINE);
        }
    }
}

foreach my $j (reverse (0 .. $y)) {
    foreach my $i (0 .. $x) {
        print $m->[$j][$i] . " ";
    }
    say "";
}

__END__

./ch-2.pl  
x 1 0 1 x 2 x x x x 
1 1 0 2 2 4 3 5 5 x 
0 0 1 3 x 3 x 2 x 2 
1 1 1 x x 4 1 2 2 2 
x 1 1 3 x 2 0 0 1 x


