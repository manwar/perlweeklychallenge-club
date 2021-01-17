#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

use List::Util qw [min];

#
# Read in the list of words. Grep all the words longer than 4 characters.
#
my $dictionary = "/Users/abigail/Words/enable.lst";
open my $fh, "<", $dictionary or die "open: $!";
chomp (my @words = grep {/.{5}/} <$fh>);

#
# Turn the word list into a pattern. Longest word first.
# This means if there are words 'foo' and 'foobar', and a
# row contains 'foobar', we grep the 'foobar', not the 'foo'.
#
my $pat = join '|' => sort {length ($b) <=> length ($a)} @words;
   $pat = qr /$pat/;


#
# Read in the grid; lowercase the letters.
#
my @grid = map {[split ' ' => lc]} <>;
my $nr_of_rows = @grid;
my $nr_of_cols = @{$grid [0]};

{
    my %words;
    #
    # Given a list of letters, find any words in them, either
    # in the give direction, or reversed.
    #
    sub collect_words (@letters) {
        my $line = join "" => @letters;
        $words {$_} ++ for          $line  =~ /(?=($pat))/g;
        $words {$_} ++ for reverse ($line) =~ /(?=($pat))/g;
    }
    #
    # Return the list of found words, sorted.
    #
    sub words () {
        sort keys %words;
    }
}

#
# Collect words
#

# Rows:
map {collect_words @$_} @grid;

# Columns:
map {my $i = $_; collect_words map {$$_ [$i]} @grid} 0 .. $nr_of_cols - 1;

# Diagonals in NE & SE quadrants:
for my $i (0 .. $nr_of_cols - 1) {
    my $max = min $nr_of_cols - $i - 1, $nr_of_rows - 1;
    collect_words map {$grid [$_]                        [$_ + $i]} 0 .. $max;
    collect_words map {$grid [$nr_of_rows - 1 - $_]      [$_ + $i]} 0 .. $max;
}

# Diagonals in SW & NW quadrants:
for my $j (0 .. $nr_of_rows - 1) {
    my $max = min $nr_of_rows - $j - 1, $nr_of_cols - 1;
    collect_words map {$grid [$_ + $j]                   [$_]}      0 .. $max;
    collect_words map {$grid [$nr_of_rows - 1 - $_ - $j] [$_]}      0 .. $max;
}

#
# Print the results
#
say for words;

__END__
