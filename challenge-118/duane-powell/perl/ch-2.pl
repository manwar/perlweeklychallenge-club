#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

=pod
    Problem: 
    https://perlweeklychallenge.org/blog/perl-weekly-challenge-118/ TASK #2

    Approach: 
    Generate all Knight moves, search via stochastic recursion at each ply, prune out obsolete paths. 
   
    Result: 
    This is script reports, in Chess notation, the best path.
    If more than one path exists it returns the first path found. 
=cut

# Slow down so we can watch the Knight move around the board 
my $sleep = shift || 0;

# Knight $N, Treasure $T, Empty $E
my ($N,$T,$E) = ('N','x','0');

# Let's go on a new Adventure!
my $AoK = AdventureOfKnight->new();

# Place Knight and Treasure on the board
$AoK->piece_put($N,1,8);
my $treasure_list = [[1,2],[2,1],[2,2],[2,3],[3,4],[5,6]]; 
#my $treasure_list = [[2,6],[3,4],[4,2],[5,4],[6,6],[7,8],[8,6],[6,5],[4,4],[2,3],[1,1]]; 
#my $treasure_list = [[1,4],[2,4],[3,4],[4,4],[5,4],[6,4],[7,4],[8,4]]; 
$AoK->piece_put($T,$_->[0],$_->[1]) foreach ( @{$treasure_list} );

# Render starting board postion
my $board = $AoK->board_render();
say $board;

# Find the shortest path to all the treasure
$AoK->shortest_path_find();

# Say best solution 
$AoK->best_path_say($board,1);
exit;


package AdventureOfKnight;
# use Data::Dumper; 
sub new {
    my $class = shift;
    my $self = {
        # Current location of Knight
        file => 0,
        rank => 0,

        # Count of treasure items
        treasure_count => 0,

        # Nested array ref indexed by file and rank, 
        # representing the state of the board, $self->{squares}[$f][$r]
        squares => [], 

        # Hash of unique board positions seen, so
        # we can short circuit recursion. 
        board_pos => {},

        # Nested array ref of moves representing current path.
        # A move is a array ref [a,b,c,d,x] where a,b is from square,
        # c,d is target square and x is capture of treasure.
        this_path => [],

        # Best solution found 
        best_path => [],
    };

    # init board to empty squares
    foreach my $r (1..8) {
        foreach my $f (1..8) {
            $self->{squares}[$f][$r] = "$E";
        }
    }

    bless $self, $class;
    return $self;
}
sub shortest_path_find {
    my $self = shift;

    # Note initial board position 
    $self->board_position_visited();

    # Recurse 
    $self->shortest_path_recurse();
}        

sub shortest_path_recurse {
    my $self = shift;

    my @move = $self->knight_moves_get();
    while (@move) {
        # Random, stochastic search 
        my $r = int(rand(scalar @move)); 
        my $move = $move[$r];
        splice @move, $r, 1;

        # Move the knight.
        $self->knight_move($move);

        # Update best path if no treasure remains on a shorter path
        if (not $self->treasure_exists() and $self->this_path_is_shorter()) {
            # copy this_path to best_path, don't forget to deference before copy
            my @this_path = @{$self->{this_path}};
            $self->{best_path} = \@this_path;
        }

        # Render and sleep so we can see the Knight move around
        my $board = $self->board_render();
        $AoK->best_path_say($board);
        sleep $sleep; 

        # Only recurse if: we have not visited this postion before and this path is shorter than best path so far
        $self->shortest_path_recurse() if ( not $self->board_position_visited() and $self->this_path_is_shorter() );

        # Undo Knight move and try another
        $self->knight_move_undo($move);
    }
}
sub treasure_exists {
    my $self = shift;
    return $self->{treasure_count} > 0;
}
sub this_path_is_shorter {
    my $self = shift;
    return (scalar @{$self->{this_path}} < scalar @{$self->{best_path}} or scalar @{$self->{best_path}} == 0);
}
sub treasure_is_here {
    my $self = shift;
    my ($f, $r) = @_;

    return 1 if ( $self->{squares}[$f][$r] eq $T );
    return 0; 
}
sub piece_put {
    my $self  = shift;
    my $piece = shift; 
    my ($f, $r) = @_;

    # A piece can be a Knight $N, Treasure $T or Empty $E.
    # It's $E when we're undo'ing a move
    if ($piece eq $N) {
        # Side effects of placing Knight:
        # Note its location
        $self->{file} = $f;  
        $self->{rank} = $r;  
        if ($self->treasure_is_here($f,$r)) {
            # decrement Treasure if capture
            $self->{treasure_count}--;
        }
    } elsif ($piece eq $T) {
        # Treasure placed if undo'ing a capture
        # or initial Treasure placement
        $self->{treasure_count}++;
    }
    # put piece at file, rank
    $self->{squares}[$f][$r] = $piece;
}
sub knight_moves_get {
    my $self = shift;

    my @move;
    my @capture;

    # Use an offset to calculate all possible Knight moves
    my $offset = [
        [ 2, -1 ], [ 2,  1 ], [ -2, 1 ], [ -2, -1 ],
        [ 1,  2 ], [ 1, -2 ], [ -1, 2 ], [ -1, -2 ],
    ];
    my $a = $self->{file};
    my $b = $self->{rank};
    foreach ( @{ $offset } ) {
        my ($x, $y) = @{$_};
        my ($c, $d) = ($a + $x, $b + $y);

        # Discard move if its off board
        next if (($c < 1 or $c > 8) or ($d < 1 or $d > 8));

        if ($self->treasure_is_here($c,$d)) {
            push @capture, [$a, $b, $c, $d, 1];
        } else {
            push @move, [$a, $b, $c, $d, 0];
        }
    }

    # Focus on captures until we get at least one solution path.
    # This will find a relatively short path quickly but maybe not the shortest.
    # We will use it, though, to prime the pump and prune long dry paths.
    return @capture if (scalar @capture > 0 and scalar @{$self->{best_path}} == 0);

    # Otherwise, return all moves
    return (@capture, @move);

}
sub knight_move {
    my $self = shift;
    my $move = shift; 
    my ($a,$b,$c,$d,$capture) = @{$move};

    # Move Knight to target square [c,d]
    $self->piece_put($N, $c, $d); 
    # Set source square [a,b] to empty 
    $self->piece_put($E, $a, $b); 

    # add move to this path
    push @{ $self->{this_path} }, $move;
}
sub knight_move_undo {
    my $self = shift;
    my $move = shift;

    my ($a,$b,$c,$d,$capture) = @{$move};
    if ( $capture ) {
        # Put treasure back 
        $self->piece_put($T, $c, $d); 
    } else {
        # Set target square to empty
        $self->piece_put($E, $c, $d); 
    }

    # Put knight back on source square 
    $self->piece_put($N, $a, $b); 

    # discard move
    pop @{ $self->{this_path} };
}
sub board_position_visited {
    my $self = shift;

    # Generate unique key to id this board position
    my $key = $self->board_position_key_gen();

    # Note the path length it took to reach this board position
    my $this_path_len = scalar @{$self->{this_path}};

    if ($self->{board_pos}{$key}) {
        # We've been here before but ...
        if ($self->{board_pos}{$key} > $this_path_len) {
            # we're on a shorter path (so consider it not visited) Note this path length.
            $self->{board_pos}{$key} = $this_path_len;
            return 0;
        } else {
            # this path is longer, no need to revisit.
            return 1;
        }
    } else {
        # We've never seen this position before, note the path length it took to reach it
        $self->{board_pos}{$key} = $this_path_len;
        return 0;
    }
}
sub board_position_key_gen {
    my $self = shift;

    # Generate a unique key for each board position found
    my $key;
    foreach my $r (1..8) {
        foreach my $f (1..8) {
            $key .= $self->{squares}[$f][$r];
        }
    }
    return $key;
}
sub board_render {
    my $self = shift;

    # return text based square board with black and white squares
    my $render = '';
    my $black_square = "  . ";
    my $white_square = "    ";

    my @r = reverse (1..8);
    foreach my $r (@r) {
        $render .= " $r";
        my $square = ($r % 2 == 0) ? $white_square : $black_square;
        foreach my $f (1..8) {
            my $p = $self->{squares}[$f][$r];
            if ($p eq $E) { 
                $render .= $square;
            } else {
                $render .= "  $p ";
            }
            $square = ($square eq $white_square) ? $black_square : $white_square;
        }
        $render .= " \n\n";
    }
    foreach ('a'..'h') {
        $render .= "   $_";
    }
    return $render;
}
sub best_path_say {
    my $self      = shift;
    my $board     = shift;
    my $best_path = shift;

    system("clear");
    say $board; 
    say "\nunique positions reached: " . scalar(keys %{$self->{board_pos}});

    my ($path, $name); 
    if ($best_path) {
        $name = "best path: ";
        $path = $self->{best_path};
    } else {
        $name = "current path: ";
        $path = $self->{this_path};
    }
    say $name . scalar @{$path};

    # Translate moves into chess notation, for example
    # [2,1,3,3,1] => Nxc3 
    # [2,1,1,3,0] => Na3 
    my $i = 0;
    foreach my $move ( @{$path} ) {
        my ($a,$b,$c,$d,$capture) = @{$move};
        my $notation = 'N' . ($capture?'x':'') . chr($c+96) . $d;
        $i++;
        say "$i $notation";
    }
    # say Dumper($self);
}

1;

__END__


 8  N   .       .       .       .  

 7  .       .       .       .      

 6      .       .   x   .       .  

 5  .       .       .       .      

 4      .   x   .       .       .  

 3  .   x   .       .       .      

 2  x   x       .       .       .  

 1  .   x   .       .       .      

   a   b   c   d   e   f   g   h

unique positions reached: 3495
best path: 11
1 Nc7
2 Nxe6
3 Nc5
4 Nxb3
5 Nc1
6 Nxa2
7 Nc3
8 Nxb1
9 Na3
10 Nxc4
11 Nxb2



8  N   .       .       .       .

 7  .       .       .       .

 6      .       .       .       .

 5  .       .       .       .

 4  x   x   x   x   x   x   x   x

 3  .       .       .       .

 2      .       .       .       .

 1  .       .       .       .

   a   b   c   d   e   f   g   h

unique positions reached: 15304
best path: 17
1 Nb6
2 Nxa4
3 Nb2
4 Nxc4
5 Ne3
6 Nxg4
7 Nf6
8 Nxe4
9 Nf6
10 Nh5
11 Nxf4
12 Nd3
13 Nxb4
14 Nc6
15 Nxd4
16 Nf3
17 Nxh4



 8  N   .       .       .   x   .

 7  .       .       .       .

 6      x       .       x       x

 5  .       .       .   x   .

 4      .   x   x   x   .       .

 3  .   x   .       .       .

 2      .       x       .       .

 1  x       .       .       .

   a   b   c   d   e   f   g   h

unique positions reached: 3693
best path: 11
1 Nxb6
2 Nxc4
3 Nxd2
4 Nxe4
5 Nxf6
6 Nxg8
7 Nxh6
8 Nxf5
9 Nxd4
10 Nxb3
11 Nxa1


