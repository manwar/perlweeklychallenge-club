#!/usr/bin/env perl6
use v6;

my ($word_file, $grid_file) = @*ARGS[0,1];

my @words=$word_file.IO.lines;
my $grid = (($grid_file) ?? ($grid_file.IO.slurp) !! ($=finish))
.lc.split(/\n+/).grep(* ~~ /\S+/).map(*.split(/\s+/)).map(*.List);

my @range=(-($grid+$grid[0])..^$grid+$grid[0]);
my ($ver, $se, $ne) = ((1,0),(1,1),(1,-1))
.map( -> $coord { @range.map( -> $x { @range.map({ $grid[$coord.[0]*$_][$x+$coord.[1]*$_] }).grep(*.defined) }).grep(*.elems).map(*.List) })
.map(*.List)
.map({ $_.map(*.join) });

my @grid_strings_to_match=(|$grid.map(*.join), |$ver, |$se, |$ne);

for @words.grep(*.chars >= 5).grep( -> $word { @grid_strings_to_match.grep({ $_.contains($word) || $_.contains($word.flip) }) }) { .say};

=finish
B I D E M I A T S U C C O R S T
L D E G G I W Q H O D E E H D P
U S E I R U B U T E A S L A G U
N G N I Z I L A I C O S C N U D
T G M I D S T S A R A R E I F G
S R E N M D C H A S I V E E L I
S C S H A E U E B R O A D M T E
H W O V L P E D D L A I U L S S
R Y O N L A S F C S T A O G O T
I G U S S R R U G O V A R Y O C
N R G P A T N A N G I L A M O O
E I H A C E I V I R U S E S E D
S E T S U D T T G A R L I C N H
H V R M X L W I U M S N S O T B
A E A O F I L C H T O D C A E U
Z S C D F E C A A I I R L N R F
A R I I A N Y U T O O O U T P F
R S E C I S N A B O S C N E R A
D R S M P C U U N E L T E S I L

# run as <script> <path-to-word-file> <path-to-grid-file> 
# the example grid is included for convenience as a fallback if you want to run it without the grid-file argument (i.e. with only the word-file argument)
