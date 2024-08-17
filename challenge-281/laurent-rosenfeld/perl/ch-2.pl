use strict;
use warnings;
use feature 'say';

my @moves = ( [<2 1>], [<2 -1>], [<1 2>], [<1 -2>],
              [<-1 2>], [<-1 -2>], [<-2 1>], [<-2 -1>] );

sub to_coordinates {
    my ($col, $row) = split //, shift;
    return ord($col) - ord('a'), $row - 1;
}

sub find_shortest  {
    my ($st_in, $end_in) = @_;
    # convert input to Cartesian coordinates
    my @start = to_coordinates $st_in;
    my @end = to_coordinates $end_in;

    my @to_be_explored;  # a queue of squares to be visited
    push @to_be_explored, [0, @start];
    my %seen = ("@start" => 1);  # already visited squares
    while (@to_be_explored) {
        my $node = shift @to_be_explored;
        my ($depth, @current) = @$node;
        return $depth if "@current" eq "@end";
        for my $move (@moves) {
            my @next = ( $current[0] + $move->[0],
                         $current[1] + $move->[1] );
            # dismiss if computed position not on chessboard
            next if $next[0] > 7 or $next[0] < 0 or
                    $next[1] > 7 or $next[1] < 0;
            # dismiss if computed position already visited
            next if exists $seen{"@next"};
            # update seen hash and to_be_explored queue
            $seen{"@next"} = 1;
            push @to_be_explored, [$depth + 1, @next];
        }
    }
}

my @tests = ([<g2 a8>], [<g2 h2>]);
for my $test (@tests) {
    printf "%-6s => ", "@$test";
    say find_shortest @$test;;
}
