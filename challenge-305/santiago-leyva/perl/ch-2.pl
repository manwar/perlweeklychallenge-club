=begin
You are given a list of words and alien dictionary character order.

Write a script to sort lexicographically the given list of words based on the alien dictionary characters.

Example 1
Input: @words = ("perl", "python", "raku")
       @alien = qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/
Output: ("raku", "python", "perl")
Example 2
Input: @words = ("the", "weekly", "challenge")
       @alien = qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/
Output: ("challenge", "the", "weekly")
=cut

use strict;
##use warnings;
use Data::Dumper;

my @words_set = (["perl", "python", "raku"], 
                 ["the", "weekly", "challenge"]);

my @alien_set = (["h", "l", "a", "b", "y", "d", "e", "f", "g", "i", "r", "k", "m", "n", "o", "p", "q", "j", "s", "t", "u", "v", "w", "x", "c", "z"],
                 ["c", "o", "r", "l", "d", "a", "b", "t", "e", "f", "g", "h", "i", "j", "k", "m", "n", "p", "q", "s", "w", "u", "v", "x", "y", "z"]);

my $set = scalar(@words_set);
foreach (0..$set-1) {
    my @output = alien_sort(\@{$words_set[$_]}, \@{$alien_set[$_]});
    print "Sorted Words: (@output)\n";
}

sub alien_sort {
    my @words = @{$_[0]};
    my @alien = @{$_[1]};

    my %alien_rank;
    for my $index (0 .. $#alien) {
        $alien_rank{$alien[$index]} = $index;
    }
    
    my @sorted_words = sort {
        # Compare character by character based on alien ranks
        for (my $i = 0; $i < length($a) && $i < length($b); $i++) {
            my $char_a = substr($a, $i, 1);
            my $char_b = substr($b, $i, 1);
            
            # Compare ranks of the current character
            return $alien_rank{$char_a} <=> $alien_rank{$char_b} if $char_a ne $char_b;
        }
    
        return length($a) <=> length($b);
    } @words;
    
    return @sorted_words;
}

