#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       night-moves.pl
# 
#       Adventure of Knight
#         Submitted by: Cheok-Yin Fung
#         A knight is restricted to move on an 8×8 chessboard. The knight is
#         denoted by N and its way of movement is the same as what it is defined
#         in Chess. * represents an empty square. x represents a square with
#         treasure.
# 
#         The Knight’s movement is unique. It may move two squares vertically
#         and one square horizontally, or two squares horizontally and one
#         square vertically (with both forming the shape of an L).
# 
#         There are 6 squares with treasures.
# 
#         Write a script to find the path such that Knight can capture all
#         treasures. The Knight can start from the top-left square.
# 
#               a b c d e f g h
#             8 N * * * * * * * 8
#             7 * * * * * * * * 7
#             6 * * * * x * * * 6
#             5 * * * * * * * * 5
#             4 * * x * * * * * 4
#             3 * x * * * * * * 3
#             2 x x * * * * * * 2
#             1 * x * * * * * * 1
#               a b c d e f g h
# 
#         BONUS: If you believe that your algorithm can output one of the
#         shortest possible path.
# 
#       method:
#             just went of it and started writing functions. Read the board from
#             DATA, leaving xs and undefining stars. Established all 8 knight
#             moves as deltas, then a function that when given a square as a
#             tuple of coordinates returns positions the knight can move to
#             next. Then a recursive function to start trying paths. Ok, not all
#             paths as we don't allow going back to the square we just left
#             unless there's no other move, to avoid immediate loops. But what
#             about larger loops?
# 
#             Got the recursive solver sort of working, enough to figure out it
#             was rapidly falling into a 6-part cycle. If we were to keep a
#             lookup table for moves made from one square to the next, and
#             disallow, or at least avoid, repeating the last move made from a
#             given position that *might* work. But we're rather far afield now
#             and that might not be enough. It might also eliminate solutions;
#             it's hard to say and I don't like that. In the end we're just sort
#             of wandering around hoping to snatch up the treasures. It seems
#             less like our knight is off to slay a dragon and more like he's
#             driving aimlessly looking for America. In the fourth act he'll
#             discover it was with him the whole time.

#             I'm tempted to implement this no-repeating loop-breaker hash but I
#             think the strategy is doomed from the outset. I wonder what it
#             would look like? Do we exclude the last move or every move,
#             somehow? The idea is both intreaging and a total hack.
# 
#             Alternately we could take a more directed approach. We could
#             determine the closest treasure and home in on it, snatch it and
#             then move to the next. This would involve more familiarity with
#             the game of chess that I can just whip out of local memory. But I
#             suppose I could figure it out.
# 
#             I don't really do chess; never have. I know the rules, how to play, but
#             never pursued any deep understanding of the game. I suppose I'll just
#             need to make it up.

#             If we make a distance algorithm we can find which of the available
#             moves gets us closest to the target, then repeat. A little
#             analysis determines we can generally employ some stock patterns to
#             move one square diagonally, or orthogonally. This sounds like a
#             bother to configure but maybe not too hard. 

#             I wish I had a chess board to make working some of this stuff out a 
#             little easier. There may be one in the back. The basic patterns would
#             be more familiar to someone with a lot of experience in the game. OTOH
#             fresh eyes can often see patterns for what they are, rather then 
#             what's common knowledge. Forward!
# 
#             new algorithm:
#                 * select closest treasure by cart dist
#                 * loop (select):
#                     * d > 2.5  approach with best move
#                     * d > 2.1  capture
#                     * d > 1.4  2-space ortho
#                     * d > 1    1-space diag
#                     * d > 0    1-space ortho
#                     * d == 0   remove treasure from board and select next target
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

use constant { START     => 'a8' };

## we have four package variables:
## 1. the current location of the knight
## 2. the path of squares the knight has already travelled
## 3. the treasure map, a hash of treasure squares
## 4. a list of the loot spot we've collected
our $knight    = START;
our $quest     = [ START ];
our $treasures = get_treasure_map();
our $loot      = [ ];

search_for_treasure();

###
###     MAIN LOOP
###

sub search_for_treasure () {
## see note in the distance() sub on specific distance values
    QUEST: while ( 1 ) {
        my ($target, $dist) = select_treasure();
        last QUEST if not defined $target;
        while ( $dist > 0 ) {
            if    ($dist == 1)    { $dist = one_sq_ortho($target) }
            elsif ($dist == 2)    { $dist = one_sq_diag($target)  }
            elsif ($dist == 4)    { $dist = two_sq_ortho($target) }
            else                  { $dist = approach($target) }
        }

        ## take the treasure
        push $loot->@*, $target;
        delete $treasures->{ $target };
        undef $target;
    }
    
    say "quest complete!\n";
    say "the knight's quest took ", scalar $quest->@*, " steps";
    say "quest path: \n\t", join ' - ', $quest->@*;
    say "loot piles found: \n\t", join ' - ', $loot->@*;
}

####
####    DISPATCHES
####

sub approach ($target) {
## make the best move towards the target. All available moves from the current
## position are evaluated and the move resulting in the shortest remaining
## distance to the target is chosen.
    my @kpt   = chess2mat( $knight )->@*;
    my @moves = map  { mat2chess( $_ ) }
                grep { on_board( $_ ) }
                map  { add_pt( $_, chess2mat( $knight ) ) } 
                knight_move_deltas() ;
    my $dist;
    ($knight, $dist) = select_closest( $target, \@moves );
    push $quest->@*, $knight; 
    return $dist;
}

sub two_sq_ortho ($target) {
## to close two squares orthogonally we move one square, half-way, closer and
## dog-leg either left or right two squares. Then the mirror of this move will
## reverse the dog-leg and move forward the additional square. For every pair of
## squares on the board either the left or right movement will remain on the
## board.
    my $deltas   = point_pair_deltas( $target ) ;
    my @laterals = sub {    my @half = map { $_ / 2 } $_[0]->@*;
                            my @out  = ( [@half], [@half] );    
                            for ( (0,1) ) {
                            do { $out[0]->[$_] =  2; 
                                $out[1]->[$_] = -2 } if not $_[0]->[$_];
                            }
                            return @out;
                    } -> ($deltas);

    my @moves = map  { mat2chess( $_ ) }
                grep { on_board( $_ ) }
                map  { add_pt( $_, chess2mat( $knight ) ) } 
                @laterals;

    push $quest->@*, $moves[0], $target;  
    $knight = $target;
    return 0;
    
}

sub one_sq_diag ($target) {
## to close one square diagonally there are a pair of squares of the opposite
## color 0.5 square forward and 1.5 squares to the left or right, analogous to
## the "half-way closer and split left or right" algorithm to close two squares
## orthogonally. This works in all cases except the last two squares in the corners
## on the major and minor diagonals, which require special cases
    my $deltas = point_pair_deltas( $target ) ;
    
    my @moves = map  { mat2chess( $_ ) }
                grep { on_board( $_ ) }
                map  { add_pt( $_, chess2mat( $knight ) ) } 
                map  { mul_pt( $_, $deltas ) } 
                ( [-1,2], [2,-1] );

    if ( @moves ) {
        push $quest->@*, $moves[0], $target;  
        $knight = $target ;
        return 0;
    }
    ## if there are no viable half-way split positions on the board we're in a
    ## corner and will need to get out first before we can close.
    ## there are 2 cases:
    ## 1. moving diagonally out from a corner square
    ##      to move out we take either valid move to one square beyond 
    ##      the target. Then we are one square orthogonal to the target. 
    ## 2. moving diagonally into a corner square
    ##      to move into a corner we make one lateral diagonal step. Then 
    ##      we are a two-square orthogonal distance from the target
    if ($knight =~ /a8|a1|h8|h1/) {     ## case (1) moving out 
        approach( $target );
        one_sq_ortho( $target );
    }
    else {                              ## case (2) moving in 
        my @lateral_delta  = $deltas->@*;
        $lateral_delta[0] *= -1;            ## change direction 90°
        my $temp_target = mat2chess( add_pt( \@lateral_delta, chess2mat($knight) ) );

        one_sq_diag( $temp_target );
        two_sq_ortho( $target );
    
    }
    return 0;
                
}

sub one_sq_ortho ($target) {
## to close one square orthogonally, we first need to move forward into the
## target's rank, to either square two squares to the left or right as we fit on
## the board. The problem then becomes a two-square ortogonal close. Every pair
## of squares will have one of the two lateral position available, then the
## 2-ortho close works in all cases
  
    my $deltas = point_pair_deltas( $target ) ;

    my $laterals = sub { my @out  = ( [$_[0]->@*], [$_[0]->@*] );  
                         for ( (0,1) ) {
                         do { $out[0]->[$_] =  2; 
                              $out[1]->[$_] = -2 } if not $_[0]->[$_];
                         }
                         return @out;
                    };
    my @laterals = $laterals->($deltas);

    my @moves = map  { mat2chess( $_ ) }
                grep { on_board( $_ ) }
                map  { add_pt( $_, chess2mat( $knight ) ) } 
                @laterals;

    push $quest->@*, $moves[0]; 

    $knight = $moves[0] ;    
    two_sq_ortho ($target) ;      
    return 0;
}


###
###     HELPERS
###

sub add_pt ($pt1, $pt2) {
## sums point coordinates
    return [ $pt1->[0]+$pt2->[0], $pt1->[1]+$pt2->[1] ];
}

sub mul_pt ($pt1, $pt2) {
## multiplies point coordinates
    return [ $pt1->[0]*$pt2->[0], $pt1->[1]*$pt2->[1] ];
}

sub on_board( $pt ) {
## boolean for whether a point is on the chessboard
        return 0 <= $pt->[0] <= 7 && 0 <= $pt->[1] <= 7 ;
}

sub select_treasure ( ) {
## finds the closest treasure and 
## returns a tuple of chess position and distance
    return undef if scalar keys $treasures->%* == 0; 
    my @tr = keys $treasures->%*;
    return undef if @tr == 0;
    
    return select_closest( $knight, \@tr);
}

sub select_closest ( $sq, $arr ) {
## given a chess postion and an array of chess positions
## finds closest in array to square
## returns the closest square and distance
    my ($min, $sel) = ("Inf");
    for ( $arr->@* ) {
        my $dist = distance( $sq, $_ );
        if ($dist < $min) {
            $min = $dist;
            $sel = $_;
        }
    }
    return ($sel, $min);
}

sub distance ( $sq1, $sq2 ) {
## given 2 chess squares, returns sum of squares of sides of the cartesian
## deltas.  This maintains the relative relationships between distances without
## all those pesky floats and square roots. We never care too much about the
## quantity of the distance measured, only the comparative relationships between
## squares. This simplification is reflected in the dispatch table values. 
    my ($p1, $p2) = map { chess2mat( $_ ) } ( $sq1, $sq2 ) ;
    return ( ($p1->[0] - $p2->[0])**2 + ($p1->[1] - $p2->[1])**2 );
}

sub point_pair_deltas ( $target ) {
## return array tuple of point coordinate deltas
    my ($kpt, $tpt) = map {chess2mat( $_ )} ($knight, $target);
    return [ $tpt->[0] - $kpt->[0], $tpt->[1] - $kpt->[1] ]; 
}

sub knight_move_deltas {
## the eight possible knight movements, as tuples of deltas
    state @deltas = ( [1,2],    [2,1], 
                      [-1,2],   [-2,1], 
                      [1,-2],   [2,-1], 
                      [-1,-2],  [-2,-1] );
    return @deltas;
}

sub mat2chess ($tup) {
## given a 0-based 2-tuple [h,v]
## return string in chess notation [a-h][1-8]
## [2,3] -> c4
    my @alpha = qw( a b c d e f g h );
    return $alpha[$tup->[0]] . ($tup->[1]+1) ;
}

sub chess2mat ($str) {
## given chess notation string converts to point tuple reference
## c4 -> [2,3] 
    my $c = 0;
    my %alpha = map { $_ => $c++ } qw( a b c d e f g h );
    my @str = split //, $str;
    return [ $alpha{$str[0]}, $str[1]-1 ];
}

sub get_treasure_map {
## read in the board from DATA as an 8x8 matrix
## save treasure locations as hash keys in chess format
    my $row = 9;
    my %hash;
    my @lets = ("a".."h");
    while (<DATA>) {
        $row--;
        chomp;
        my @r = map  { $_ eq '*' ? undef : $_ } split / /;
        my @t = grep { defined $r[$_] } (0..7);
        $hash{ $lets[$_] . $row } = 1 for @t;
    }
    return \%hash;
}


__DATA__
* * * * * * * * 
* * * * * * * * 
* * * * x * * * 
* * * * * * * * 
* * x * * * * * 
* x * * * * * * 
x x * * * * * * 
* x * * * * * * 
