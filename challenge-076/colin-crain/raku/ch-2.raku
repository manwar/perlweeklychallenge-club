#!/usr/bin/env perl6
# 
#
#       where_is_wigged.raku
# 
#         "departed succor blunts malignant social viruses"
#
#         it's an unexpectedly dark list of hidden words
#
#         TASK #2 › Word Search
#         Submitted by: Neil Bowers
#         Reviewed by: Ryan Thompson
#             Write a script that takes two file names. The first file would
#             contain word search grid as shown below. The second file contains
#             list of words, one word per line. You could even use local
#             dictionary file.
# 
#             Print out a list of all words seen on the grid, looking both
#             orthogonally and diagonally, backwards as well as forwards.
# 
#         Search Grid
#             B I D E M I A T S U C C O R S T
#             L D E G G I W Q H O D E E H D P
#             U S E I R U B U T E A S L A G U
#             N G N I Z I L A I C O S C N U D
#             T G M I D S T S A R A R E I F G
#             S R E N M D C H A S I V E E L I
#             S C S H A E U E B R O A D M T E
#             H W O V L P E D D L A I U L S S
#             R Y O N L A S F C S T A O G O T
#             I G U S S R R U G O V A R Y O C
#             N R G P A T N A N G I L A M O O
#             E I H A C E I V I R U S E S E D
#             S E T S U D T T G A R L I C N H
#             H V R M X L W I U M S N S O T B
#             A E A O F I L C H T O D C A E U
#             Z S C D F E C A A I I R L N R F
#             A R I I A N Y U T O O O U T P F
#             R S E C I S N A B O S C N E R A
#             D R S M P C U U N E L T E S I L
#         Output
#             Found 55 words of length 5 or more when checked against the local
#             dictionary. You may or may not get the same result but that is fine.

#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

## NOTE: when it comes down to it, /dict/words really isn't a very good wordlist. 
##       lacking common plurals and constructions. My own scrabble dictionary 
##       has about 50,000 more words, and finds 68 5+ letter words vs. 40 for this.


unit sub MAIN (Str $file = 'wordsearch.txt', Str $dict = '/usr/share/dict/words') ;


## cfg
my $MINWORD = 5;        ## val > 1 

## in 
my @matrix = $file.IO.lines 
                  .map( { .comb(/\w/).cache; } ); ## <-- need to cache the internal Seqs
my %lookup = $dict.IO.lines
                  .map( { my $copy = $_; $copy.=uc; $copy => 1} );

## work   
my @possibles;
for 0..@matrix.end -> $y {          ## height
    for 0..@matrix.head.end -> $x {   ## width
        @possibles.append: |word_vectors( $x, $y, @matrix);
    }
}
my @output = @possibles.grep:{ %lookup{$_}:exists }                 

## out
.put for @matrix;
say '';
say "found ", @output.elems, " words of minimum length $MINWORD: \n";
.say for sort @output;
     
# + + + + + + + + + + + + + + + + + + + + + +    

sub word_vectors ($x, $y, @mat)  {
    my $height = @mat.end;
    my $width  = @mat.head.end;
    my @words;
    my @vectors ;
    my $i = $x;
    
    ## formulae for the 8 vectors
    @vectors.push( $_() ) for 
        { ($x..$width).map:    { @mat[$y][$_]} },                          ## horz forward
        { (0..$x).reverse.map: { @mat[$y][$_]} },                          ## horz back
        { ($y..$height).map:   { @mat[$_][$x]} },                          ## vert down
        { (0..$y).reverse.map: { @mat[$_][$x]} },                          ## vert up
        { ($y..$height).map:   { last if $i > $width; @mat[$_][$i++] } },  ## diag down forward
        { ($y..$height).map:   { last if $i < 0;      @mat[$_][$i--] } },  ## diag down back
        { (0..$y).reverse.map: { last if $i > $width; @mat[$_][$i++] } },  ## diag up forward
        { (0..$y).reverse.map: { last if $i < 0;      @mat[$_][$i--] } } ; ## diag up back  
    
    ## turn vectors into strings $MINWORD letters or longer
    for @vectors -> @v {
        $i = $x;       ## <-- lazy evaluation in map Seqs above need the reset to be here!
        next if @v.elems < $MINWORD;
        my $stem      = ( @v[0..$MINWORD-2] ).join;
        my @vec_words = ( @v[$MINWORD-1..@v.end] ).map: { $stem ~= $_ } ;
        @words.push: |@vec_words;
    }
    return @words;
}                  
