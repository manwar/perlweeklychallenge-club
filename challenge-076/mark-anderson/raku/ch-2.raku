=begin usage

Usage: raku ch-2.raku grid.txt word-list.txt 5

Output:

70 words
align
alose
antes
arose
blunt
blunts
boids
broad
Butea
Buteas
clove
cloven
constitution
constitutions
croon
depart
departed
enter
filch
garlic
gings
goats
grieve
grieves
grith
gurrs
hazard
ileac
ileacs
Ionis
Iteas
liens
lunts
malign
malignant
malls
midst
midsts
neuma
neumas
obans
ought
ovary
parted
pasmo
quash
Raias
raias
rines
ruses
Shrine
Shrines
shrine
shrines
sices
social
soyas
spasm
spasmodic
staun
succor
succors
taars
talose
theorem
theorems
virus
viruses
wifie
wigged

=end usage

# My word list doesn't include plurals so if a word matches then 
# I'll use the below module to check if the plural is in the grid.

use Lingua::EN::Inflect:from<Perl5> 'PL';

sub MAIN(Str $grid, Str $word-list, UInt $word-length=5) {
    my @AoA = $grid.IO.lines.map(*.split(/\s/).Array).Array;

    my @strings = strings(@AoA, $word-length);

    my @words = gather {
        for $word-list.IO.lines -> $word {
            next if $word.chars < $word-length-1;

            for @strings -> $string { 
                if $string.contains(uc $word) {
                    if $word.chars >= $word-length {
                        take $word;
                    }

                    my $plural = PL($word);
                    if $plural.chars >= $word-length {
                        if $string.contains(uc $plural) {
                            take $plural;
                        }
                    }
                    #last;
                }
            }
        }
    }

    @words = @words.unique;
    say "{@words.elems} words";
    .say for @words;
}

#| returns an array of strings which consists of the horizontal, vertical,
#| and diagonals of @AoA. It also includes the reverse of each. 
sub strings(@AoA, $word-length) {
    my @AoA2 = [Z] @AoA;
    my @AoA3 = @AoA.reverse;
    my @AoA4 = [Z] @AoA3;

    my @strings;
    # @AoA horizontal lines
    @strings.push: $_ for @AoA.map(*.join);

    # @AoA vertical lines 
    @strings.push: $_ for (@AoA2).map(*.join);

    # @AoA upper right diagonals
    @strings.push: $_ for diagonals(@AoA).map(*.join);

    # @AoA lower left diagonals
    @strings.push: $_ for diagonals(@AoA2).map(*.join);

    # @AoA lower right diagonals
    @strings.push: $_ for diagonals(@AoA3).map(*.join);

    # @AoA upper left diagonals
    @strings.push: $_ for diagonals(@AoA4).map(*.join);

    @strings = @strings.grep(*.chars >= $word-length).unique;

    my @flipped = @strings.map(*.flip);

    @strings.append: @flipped;

    return @strings;
}

#| there's probably a neat raku trick to get the diagonals. 
sub diagonals(@AoA) {
    my @diagonals;

    for ^@AoA[0] -> $i {
        my @diagonal = gather {
            for ^(@AoA[0]-$i) -> $j {
                take @AoA[$j][$i+$j] || last;
            }
        }
        @diagonals.push: @diagonal;
    }

    return @diagonals;
}
