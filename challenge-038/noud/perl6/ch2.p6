# Word Game
#
# Lets assume we have tiles as listed below, with an alphabet (A..Z) printed on
# them. Each tile has a value, e.g. A (1 point), B (4 points) etc. You are
# allowed to draw 7 tiles from the lot randomly. Then try to form a word using
# the 7 tiles with maximum points altogether. You don’t have to use all the 7
# tiles to make a word. You should try to use as many tiles as possible to get
# the maximum points.
#
# For example, A (x8) means there are 8 tiles with letter A.
# 1 point
#     A (x8), G (x3), I (x5), S (x7), U (x5), X (x2), Z (x5)
#
# 2 points
#     E (x9), J (x3), L (x3), R (x3), V (x3), Y (x5)
#
# 3 points
#     F (x3), D (x3), P (x5), W (x5)
#
# 4 points
#     B (x5), N (x4)
#
# 5 points
#     T (x5), O (x3), H (x3), M (x4), C (x4)
#
# 10 points
#     K (x2), Q (x2)

my %points = {
    1 => "AGISUXZ".comb,
    2 => "EJLRVY".comb,
    3 => "FDPW".comb,
    4 => "BN".comb,
    5 => "TOHMC".comb,
    10 => "KQ".comb,
}.invert;

my %num_tiles = {
    2 => "XKQ".comb,
    3 => "GJLRVDOH".comb,
    4 => "NMC".comb,
    5 => "IUZYPWBT".comb,
    7 => "S",
    8 => "A",
    9 => "E",
}.invert;

my @tileset;
for %num_tiles.kv -> $key, $value {
    for 1..$value -> $i {
        @tileset.push($key);
    }
}

sub get_best_word(%picked) {
    my @picked_words;
    for "/usr/share/dict/words".IO.slurp.uc.words -> $word {
        if ($word.comb ⊆ %picked) {
            @picked_words.push(((%points{$_} for $word.comb).sum, $word));
        }
    }

    sort(@picked_words)[*-1];
}

sub MAIN() {
    my @picked = @tileset.pick(7);
    say "Picked tiles: " ~ @picked;
    say "Best word: " ~ get_best_word(@picked.Bag);
}
