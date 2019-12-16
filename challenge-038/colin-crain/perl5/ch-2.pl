#! /opt/local/bin/perl
#
#        wordgame.pl
#
#        TASK #2
#         Word Game
#             Lets assume we have tiles as listed below, with an alphabet (A..Z)
#             printed on them. Each tile has a value, e.g. A (1 point), B (4
#             points) etc. You are allowed to draw 7 tiles from the lot
#             randomly. Then try to form a word using the 7 tiles with maximum
#             points altogether. You don’t have to use all the 7 tiles to make a
#             word. You should try to use as many tiles as possible to get the
#             maximum points.
#
#             For example, A (x8) means there are 8 tiles with letter A.
#
#                 1 point
#                 A (x8), G (x3), I (x5), S (x7), U (x5), X (x2), Z (x5)
#
#                 2 points
#                 E (x9), J (x3), L (x3), R (x3), V (x3), Y (x5)
#
#                 3 points
#                 F (x3), D (x3), P (x5), W (x5)
#
#                 4 points
#                 B (x5), N (x4)
#
#                 5 points
#                 T (x5), O (x3), H (x3), M (x4), C (x4)
#
#                 10 points
#                 K (x2), Q (x2)
#
#         method: so many parts to this puzzle. The three basic structures
#             are to:

#                 1. select a hand,
#                 2. determine every possible combination of letters from that hand,
#
#             then for each of these combinations,

#                 3. determine whether it is a valid word, and its point score,
#                     while keeping track of the highest point score. It's a new
#                     high score, zero out the previous talley and begin anew.
#
#             To select a hand, I found it easier to explicitly parse the
#             configuration stated above and use that to construct a data
#             structure to hold it, loading the constructed perl code using eval.
#             Beats typing it out and and errors will be structural rather than
#             lexical. Once we have the configuration we can use that to construct
#             a bag of numbered tiles 0-108 with letters for values. We draw from
#             this to build a hand of 7 tiles, with duplicate draws "thrown back"
#             and redrawn until we have 7 unique numbered tiles. To finish we
#             construct an array by mapping the tile numbers to their respective
#             letter values.
#
#             To determine letter combinations we will look to a the
#             Algorithm::Permute module, which, given a list and a length,
#             impliments nPr permutations, outputting a rearranged list for each
#             one. To gauge the scope of this task I wrote a function to calculate
#             the sum of the number of permutations of 7 tiles into 7 letter
#             words, plus the permutations of 6 letter words, 5 letter, etc. That
#             number grows large quickly as the number of chits grows, but for 7
#             is only 13699 permutations, quite managable. That routine is
#             included here, with an auxillary factorial function, but not used
#             for this script. 13699 permutations is managable, and I considered
#             writing my own, but the Algorithm::Permute module is written in XS,
#             so is very fast.
#
#             By joining a permutation list into a string we can then compare it
#             to a list of words and see if we find a match. NLP and verifying
#             words as valid English would be very, very cool but a little more
#             than a week's work I'd imagine. Perhaps there's a module for that,
#             but I don't know it. So word lists it is.
#
#             For possible words, most *NIX systems have a /usr/share/dict/words
#             dictionary file somewhere. I found this a bit lacking in plurals, so
#             found a Scrabble Dictionary txtfile, pulled it down and used that.
#             Seeing as our game is quite similar to yet legally distinct from
#             Scrabble(tm), this is better as it will list, as I understand, all
#             legal words, with separate entries for conjugations and declensions.
#             Perusing this list makes it clear why I will probably never be a
#             top-field Scrabble player. Then again, I would consider it a
#             personal victory to ever find a way to use the word cwtch in a
#             sentence. If it's good enough for those maniacs, it's good enough
#             for me.
#
#             To get a point value for the word, should the lookup match, we can
#             use the config hash again to translate to the point values from the
#             list returned by the permute iterator and sum that. The iterator
#             doesn't care about duplicate words if the initial set has duplicate
#             letters, for example CATSAXZ will make the word CATS twice, once
#             from each A. So the current list of best words is kept in a hash,
#             with a single key per word. Every time the highest value is
#             exceeded, the hash is restarted with the new best word.
#
#         results: For amusement, I broke off the 7 tile hand size into a
#             configuration variable. As we can see from running our perviously
#             mentioned permute_sum routine,
#                 tiles:  3           15 permutations
#                 tiles:  4           64 permutations
#                 tiles:  5          325 permutations
#                 tiles:  6         1956 permutations
#                 tiles:  7        13699 permutations
#                 tiles:  8       109600 permutations
#                 tiles:  9       986409 permutations
#                 tiles: 10      9864100 permutations
#                 tiles: 11    108505111 permutations
#                 tiles: 12   1302061344 permutations
#             the number of possible words grows exponentially, at an expanding
#             rate that works to about 10x with each tile added within this range.
#             There is also an added dictionary size penalty, as we no longer
#             disallow longer words, but that increase will diminish as we grow. A
#             10-chit hand takes about 30 seconds on my machine. Good thing we
#             used an XS permutor. Of note adding letters doesn't really scale the
#             point values found, although I was able to find the word PAMPHREY
#             for 23 points on an 11-tile hand.
#
#             One notable thing that came to light during the output procedure is
#             that Algorithm::Permute under certain conditions changes its input
#             array in place, keeping the reference but removing the contents of
#             the array. It only does this when the output length is equal to the
#             input length; apparently it uses a different algorithm in this
#             specific case than that for generating nPr where n > r. Consequently
#             the loop for 7 tiles from lengths 2..7 succeeds but looping
#             (reverse(2..7)) fails, because in the first case the $hand array
#             referance is still populated until after the last iteration, but in
#             the second is depopulated on first pass and subsequent calls to the
#             iterator->new method fail. In order to display the initial hand
#             after the premutation logic we need to previously have made a deep
#             copy of this initial array, by dereferencing, copying the array to a
#             new variable and then re-referencing that. This side effect does not
#             appear to be documented, but has been reported to the author.
#
#         example:
#             tiles:               [S] [U] [N] [E] [R] [P] [T]
#
#             best words found:
#                                  PUNSTER
#                                  PUNTERS
#
#             point score:         18
#
#
#

#        2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



# use warnings;
use strict;
use feature ":5.26";

use Algorithm::Permute;

use Data::Dumper;
$Data::Dumper::Sortkeys = sub { [sort {$a <=> $b} keys $_[0]->%*] };

# normally dictionaries don't have separate entries for plural forms etc, so a
# scrabble dictionary is a better choice here. I found this one without too much
# difficulty. YMMV.
my $dictionary_file_path = './collins_scrabble_words_2019.txt';

## alternately, this file exists on most UNIX based systems:
#my $dictionary_file_path = '/usr/share/dict/words';

my $number_of_tiles = 7;

## ## ## ## ## MAIN

## massage the descriptive table above into perl code and eval it into a hash structure and return it
##      $pool_config = { A => { quan  => 8, value => 1 }, etc... };
## we will want this hash later for its 'value' values
my $pool_config = parse_data();

## from the config make a pool of chits, keyed on a number 0 to 108, with the value of the letter.
my $pool;
my ($start, $end) = (0,0);
for my $key ( sort keys $pool_config->%* ) {
    $end = $start + $pool_config->{$key}->{quan};
    @$pool{ $start..($end - 1) } = ($key) x ($end - $start + 1);  ## hash slices on the lvalue
    $start = $end;
}

## draw a hand of chits
my $hand = draw_hand( $pool, $number_of_tiles );

## deep copy of $hand for later, as the permutation engine will mysteriously gut it when r == n
my $safe_hand = [@{$hand}];

## permute words and calculate point values, preserving against a high score
my $highest_point_score = 0;
my %highest_point_words;
my $dict = load_dictionary();

for my $word_length ( 2..$number_of_tiles ) {
    my $permutor = Algorithm::Permute->new($hand, $word_length);
    while (my @perm = $permutor->next) {
        my $word = join '', @perm;
        if (exists $dict->{$word_length}->{$word}){
            my @points = map { $pool_config->{$_}->{value} } @perm;
            my $points;
            $points += shift @points while @points;            ## quick sum function
            if ( $points > $highest_point_score ){
                %highest_point_words = ($word => 1);
                $highest_point_score = $points;
            }
            elsif ( $points == $highest_point_score ){
                $highest_point_words{$word}++;
            }
        }
    }
}

## output the results
say "tiles:               ", join ' ', map { "[$_]" } $safe_hand->@*;
say '';
say "best words found:";
printf "                     %s\n", $_ for (sort keys %highest_point_words);
say '';
say "point score:         ", $highest_point_score;





## ## ## ## ## SUBS

sub parse_data {
    my $pool_config;
    my $code = '$pool_config = {' . "\n";
    my $points;
    while (my $line = <DATA>) {
        next if $line =~ /^\s*$/;
        if ($line =~ /^(\d+) point/) {
            $points = $1;
            next;
        }
        $line =~ s/(\w) \(x(\d)\),?\s?/\t$1 => { quan  => $2  \t,\n\t       value => $points }\t,\n/g;
        $code .= $line;
    }
    $code .= '};';

    eval $code;
    return $pool_config;

}

sub draw_hand {
## given a pool to draw from and a number of chits to draw, returns an array of letters
    my ($pool, $size) = @_;

    ## gather a hash of unique chit numbers:
    ## while the hand is not filled, select new chits from the pool
    my %hand;
    while ( scalar keys %hand < $size ) {
        my $chit = int(rand( scalar(keys $pool->%*) )) ;
        next if exists $hand{$chit};
        $hand{$chit} = 1;
    }

    ## convert the hash into an array of letters
    return [ map { $pool->{$_} } keys %hand ];
}

sub load_dictionary {
## loads a dictionary file into a hash structure, keyed on word length and then the word itself
    open( my $fh, "<", "$dictionary_file_path" ) or die "can't open dict! $!\n";
    my $dict = {};
    while ( my $word = uc( <$fh> ) ){
        $word =~ s/^\s*([A-Z]+)\s*\n?\r?/$1/;
        my $length = length( $word );
        next if $length > $number_of_tiles;
        $dict->{$length}->{$word} = 1;
    }
    return $dict;
}

sub permute_sum {
## sum of number of permutations of a given length and all smaller lengths r -> 0 for a given set
## permutation: nPr = n!/(n-r)!
##
##                     n
## sum:      ∑(nPr) =  ∑  n!/(n-r)!
##                    r=1
##
    my ($letters, $length) = @_;
    $length = $letters if (! defined $length);
    return 0 if $length == 0;
    return  factorial($letters)/factorial($letters - $length) + permute_sum( $letters, $length - 1);
}

sub factorial {
    my $num = shift;
    return undef if $num < 0;
    return 1 if $num <= 1;
    my $out = $num;
    while ( --$num > 1) {
        $out *= $num;
    }
    return $out;
}


__DATA__
1 point
A (x8), G (x3), I (x5), S (x7), U (x5), X (x2), Z (x5)

2 points
E (x9), J (x3), L (x3), R (x3), V (x3), Y (x5)

3 points
F (x3), D (x3), P (x5), W (x5)

4 points
B (x5), N (x4)

5 points
T (x5), O (x3), H (x3), M (x4), C (x4)

10 points
K (x2), Q (x2)
