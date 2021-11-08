use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;

my (@mine_field, $max_i, $max_j);

sub get_count {
    my ($i, $j) = @_;
    my $count = 0;
    my @positions;
    for my $k (-1, 0, +1) {
        for my $m (-1, 0, +1) {
            push @positions, [$i + $k, $j + $m] unless $k == 0 and $m == 0;
        }
    }
    my $count_mines = 0;
    for my $pos (@positions) {
        next if $pos->[0] <0 or $pos->[1] < 0;
        next if $pos->[0] > $max_i or $pos->[1] > $max_j;
        $count_mines++ if $mine_field[$pos->[0]][$pos->[1]] eq 'x';
    }
    return $count_mines;
}

sub print_grid {
    say "@$_" for @_; say "";
}

my @in_str =
    ( "x * * * x * x x x x",
      "* * * * * * * * * x",
      "* * * * x * x * x *",
      "* * * x x * * * * *",
      "x * * * x * * * * x" );

# Populating an AoA from the array of strings
for my $line (@in_str) {
    push @mine_field, [split /\s+/, $line];
}

$max_i = $#mine_field;
$max_j = $#{$mine_field[0]};
print_grid @mine_field;

for my $i (0..$max_i) {
    for my $j (0..$max_j) {
        next if $mine_field[$i][$j] eq 'x';
        $mine_field[$i][$j] = get_count $i, $j;
    }
}
print_grid @mine_field;
