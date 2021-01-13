#! /opt/local/bin/perl
#
#       where_is_wigged.pl
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
# 
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my $file     = shift @ARGV // 'wordsearch.txt';
my $dict     = shift @ARGV // '/usr/share/dict/words';
my $MINWORD  = shift @ARGV // 5;

my $matrix = load_search_matrix($file);
print_matrix($matrix);

my $words = build_word_hash($dict);

my @possibles; 

my $height = @$matrix - 1;
my $width  = $matrix->[0]->@* - 1 ;

for my $y (0..$height) {
    for my $x (0..$width) {
        push @possibles,  word_vectors( $x, $y, $matrix)->@*;
    }
}

my @output = grep { exists $words->{$_} } @possibles;
say '';
say "found ", scalar @output, " words of minimum length $MINWORD: \n";
say for sort @output;

## ## ## ## ## SUBS:

sub word_vectors {
    my ($x, $y, $matrix) = @_;
    my $height = @$matrix - 1;
    my $width  = $matrix->[0]->@* - 1 ;
    my @words;
    my @vec ;
    my $i;
    
    ## horz forward
    push $vec[0]->@*, $matrix->[$y][$_] for ($x..$width);
    
    ## horz back
    push $vec[1]->@*, $matrix->[$y][$_] for reverse (0..$x);
    
    ## vert down
    push $vec[2]->@*, $matrix->[$_][$x] for ($y..$height);
    
    ## vert up
    push $vec[3]->@*, $matrix->[$_][$x] for reverse (0..$y);

    ## diag down forward
    $i = $x;
    for ($y..$height) {         ## y to height index
        last if $i > $width;
        push $vec[4]->@*, $matrix->[$_][$i++];
    } 

    ## diag down back
    $i = $x;
    for ($y..$height) {         ## y to height index
        last if $i < 0;
        push $vec[5]->@*, $matrix->[$_][$i--];
    }
 
    ## diag up forward
    $i = $x;
    for (reverse (0..$y)) {         ## 0 to y 
        last if $i > $width;
        push $vec[6]->@*, $matrix->[$_][$i++];
    }

    ## diag up back
    $i = $x;
    for (reverse (0..$y)) {         ## 0 to y 
        last if $i < 0;
        push $vec[7]->@*, $matrix->[$_][$i--];
    }

    ## turn vectors into strings $MINWORD letters or longer
    for my $v (@vec) {
        next if @$v < $MINWORD;
        my $stem = join '', @$v[0..$MINWORD-2];
        push @words, map { $stem .= $_ } @$v[$MINWORD-1..@$v-1];
    }

    return \@words;
}

sub load_search_matrix {
    my $file = shift;
    open my $fh, '<', $file 
        or die "cannot open file $file: $!\n";
    my @search;
    
    while (my $line = <$fh>) {
        push @search, [split /\s/, $line];    
    }
    close $fh;
    return \@search;
}

sub print_matrix {
    my $matrix = shift;
    for (@$matrix) {
        say join ' ', @$_;
    }
}

sub build_word_hash {
    my $dict = shift;
    my %hash;
    open my $fh, "<",  $dict
        or die "can't open $dict to read: $!";
        
    while (my $word = <$fh>) {
        $word =~ s/[\n\r]//g;  
        $word = uc($word);
        $hash{$word} = 1;
    } 
    return \%hash;
}
