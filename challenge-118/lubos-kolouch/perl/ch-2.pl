use strict;
use warnings;

my @board = (
    ['N', '*', '*', '*', '*', '*', '*', '*'],
    ['*', '*', '*', '*', '*', '*', '*', '*'],
    ['*', '*', '*', '*', 'x', '*', '*', '*'],
    ['*', '*', '*', '*', '*', '*', '*', '*'], 
    ['*', '*', 'x', '*', '*', '*', '*', '*'],
    ['*', 'x', '*', '*', '*', '*', '*', '*'],
    ['x', 'x', '*', '*', '*', '*', '*', '*'],
    ['*', 'x', '*', '*', '*', '*', '*', '*']
);

my @moves = (
    [-2, -1], [-2, 1], [2, -1], [2, 1],
    [-1, -2], [1, -2], [-1, 2], [1, 2]
);

sub is_valid_move {
    my ($x, $y) = @_;
    return $x >= 0 && $x < 8 && $y >= 0 && $y < 8;
}

sub find_path {
    my ($x, $y, $path, $treasures) = @_;

    return $path if $treasures == 0;

    my @new_path = (@$path, [$x, $y]);
    my $new_treasures = $treasures - ($board[$x][$y] eq 'x' ? 1 : 0);

    my @shortest_path;
    my $shortest_length = 1e9;

    for my $move (@moves) {
        my ($dx, $dy) = @$move;
        my $new_x = $x + $dx;
        my $new_y = $y + $dy;

        next unless is_valid_move($new_x, $new_y);
        next if grep { $_->[0] == $new_x && $_->[1] == $new_y } @$path;

        my $result = find_path($new_x, $new_y, \@new_path, $new_treasures);
        my $result_length = scalar @$result;

        if ($result_length < $shortest_length) {
            @shortest_path = @$result;
            $shortest_length = $result_length;
        }
    }

    return \@shortest_path;
}

my $path = find_path(0, 0, [], 6);

print "One of the shortest paths is:\n";
for my $pos (@$path) {
    my ($x, $y) = @$pos;
    print "($x, $y) ";
}
print "\n";

