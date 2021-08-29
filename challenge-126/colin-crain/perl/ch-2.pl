#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       126-2-clean-sweep.pl
#
#       Minesweeper Game
#         Submitted by: Cheok-Yin Fung
# 
#         You are given a rectangle with points marked with either x or *.
#         Please consider the x as a land mine.
# 
#         Write a script to print a rectangle with numbers and x as in the
#         Minesweeper game.
# 
#         A number in a square of the minesweeper game indicates the number
#         of mines within the neighbouring squares (usually 8), also
#         implies that there are no bombs on that square.
# 
#         Example
#         Input:
#             x * * * x * x x x x
#             * * * * * * * * * x
#             * * * * x * x * x *
#             * * * x x * * * * *
#             x * * * x * * * * x
# 
#         Output:
#             x 1 0 1 x 2 x x x x
#             1 1 0 2 2 4 3 5 5 x
#             0 0 1 3 x 3 x 2 x 2
#             1 1 1 x x 4 1 2 2 2
#             x 1 1 3 x 2 0 0 1 x
#
#         theory:
# 
#             Well let me say I thought at first we'd been tasked with
#             actually making a minesweeper game. I mean, on thinking it
#             through it wouldn't be particularly difficult or anything;
#             just take coordinate coded input and reprint the updated map.
#             Or even provide terminal blanking tricks to make a proper
#             ascii gui or sorts.
# 
#             Really the hard part would be thinking up and implementing
#             all the fiddly details that go into an effort like that more
#             than the code logic.
# 
#             I get the feeling someone will go the extra distance and do
#             it; we may more likely get several versions to play arond
#             with.
# 
#             Me, on the other hand I think I'll stick with the request as
#             written. Perhaps when I'm done rooting through all the other
#             rabbit holes permeating my life this week I'll have time to
#             come back and fancy it up.
# 
#             Not likely though. I wouldn't wait up.
# 
#             So we have a request for the minesweeper *interface map*,
#             rather than the *game*, which is an imprtant and neccessary
#             subtask to breating the game, determining the information
#             revealed to the user with every test made. The ultimate goal
#             of the game is to reveal the entirely of this map, position
#             by position, without testing a square with a mine in it.
# 
#             What we start with is the secret map of the minefield, which
#             the player never directly sees. The player moves to a
#             coordinate position, and the number of mines surrounding that
#             square is revealed. By combining this information from a
#             number of directions inferences can be made and the location,
#             in theory, of the mines can be determined.
# 
#             WHat we need to construct is the map of the neighboring mine
#             counts for each square that isn't a mine itself. If the
#             player picks one of those squares the mine goes off, terrible
#             things happen and the game is over, so we need never compute
#             those positions.
# 
#         implementation:
# 
#             We could go about this two ways. We could either loop through
#             the array, and for each cell scan the surrounding 8 cells,
#             augmenting a count to each if the current cell contains a
#             mine, or loop through each cell and search the surrounding
#             area for active mines and count them up all at once that way.
#             Either way involves a double iteator through the matrix,
#             followed by another loop to encircle the candidate. Hoewever
#             in the first strategy if a cell does not contain a mine we
#             can skip the surrounding scan, so we'll use that. When
#             implementing the game we only need to precompute this step
#             once so we needn't worry too much about time complexity but
#             it shouldn't be ignored either.
# 
#             Persenting the deltas as a list of arrays rather than
#             generating them on the fly is less redundant processing, and
#             we have no need to skip the no-op step of delta [0,0] as it's
#             never addressed.
# 
#             In an actual game we'd just probably just roll this
#             neighbor-data step into the map-generation phase, unless
#             perhaps we wanted to present just the mines for display
#             design, say at the end or when the player lost or such. But
#             we won't worry about that. In any case a simple map generator
#             is included, with parameters for height, width and %
#             probability of a cell being a mine.
# 
#             
#         
#             
#             
#             
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


# ## uncomment for the example:
# 
# my $mat = [ [ qw( x * * * x * x x x x ) ],
#             [ qw( * * * * * * * * * x ) ],
#             [ qw( * * * * x * x * x * ) ],
#             [ qw( * * * x x * * * * * ) ],
#             [ qw( x * * * x * * * * x ) ] ];

my $mat = generate_map(10,10,30);
            
my @mat = map { [ map { $_ eq '*' ? 0 : $_ } $_->@* ] } $mat->@* ;
my @deltas = (  [-1,-1], [-1,0 ], [-1, 1], 
                [ 0,-1],          [ 0,1 ], 
                [ 1,-1], [ 1, 0], [ 1, 1]  );

for my $i ( 0..$#mat ) {
    for my $j ( 0..$mat[0]->$#* ) {
        next unless $mat->[$i][$j] eq 'x';
        for my $d ( @deltas ) {
            my $r = $i + $d->[0];
            my $c = $j + $d->[1];
            if ( @mat > $r >= 0 and $mat[0]->@* > $c >= 0 ) {
                next if $mat[$r][$c] eq 'x';
                $mat[$r][$c]++;
            }
        }
    }
}
say "\nInput:\n";
say "$_->@*" for $mat->@*;

say "\nOutput:\n";
say "$_->@*" for @mat;


sub generate_map ($r, $c, $pct) {
## height in rows, width in columns, % chance of cell being a mine
    my $mat = [];
    for my $row ( 0..$r ) {
        for my $col ( 0.. $c ) {
            $mat->[$row][$col] =  rand(100)-$pct < 0 
                                    ? 'x'
                                    : '*' ;
        }
    }
    return $mat;
}
