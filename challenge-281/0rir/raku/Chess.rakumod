
unit class Chess;

=begin comment
    Chess -- Miscellany supporting definitions of-- and  actions on-- a
            chess board.
=end comment

constant @square   is export = [ 0…63];         # a chessboard

our @file-name     is export = [ 'a' … 'h'];      
our @rank-name     is export = [ 1 … 8];
our @algebraic     is export = ( @file-name X[~]  @rank-name).sort( {.flip});
our %algebraic2sq  is export =   @algebraic Z[=>] @square;
sub algebraic2sq( Str $a --> Int) is export { %algebraic2sq{$a} }
