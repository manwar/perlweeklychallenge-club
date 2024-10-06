#!/usr/bin/perl
use strict;
use warnings;

sub third_maximum {

    # remove duplicates: see example 3 and 4
    my @unique = keys %{{ map { $_ => 1 } @_ }};

    # sort numerically
    @unique = sort { $a <=> $b } @unique;

    # return the third largest or the largest if fewer than 3 elements
    return (scalar(@unique) >= 3) ? $unique[-3] : $unique[-1];
}

# Tests
my @ints;

Example 1
@ints = (5, 6, 4, 1);
print(third_maximum(@ints), "\n"); # Output 4

Example 2
@ints = (4, 5);
print(third_maximum(@ints), "\n"); # Output: 5

Example 3
@ints =  (1, 2, 2, 3);
print(third_maximum(@ints), "\n"); # Output: 1

Example 4
@ints =  (3, 3, 3, 3, 2, 2, 2, 1);
print(third_maximum(@ints), "\n"); # Output: 1


TASK #2: Jumbled Letters
An Internet legend dating back to at least 2001 goes something like this:

Aoccdrnig to a rscheearch at Cmabrigde Uinervtisy, it deosn’t mttaer in waht oredr the ltteers in a wrod are, the olny iprmoetnt tihng is taht the frist and lsat ltteer be at the rghit pclae. The rset can be a toatl mses and you can sitll raed it wouthit porbelm. Tihs is bcuseae the huamn mnid deos not raed ervey lteter by istlef, but the wrod as a wlohe.

This supposed Cambridge research is unfortunately an urban legend. However, the effect has been studied. For example—and with a title that probably made the journal’s editor a little nervous—Raeding wrods with jubmled lettres: there is a cost by Rayner, White, et. al. looked at reading speed and comprehension of jumbled text.

Your task is to write a program that takes English text as its input and outputs a jumbled version as follows:

    The first and last letter of every word must stay the same
    The remaining letters in the word are scrambled in a random order (if that happens to be the original order, that is OK).
    Whitespace, punctuation, and capitalization must stay the same
    The order of words does not change, only the letters inside the word

So, for example, "Perl" could become "Prel", or stay as "Perl", but it could not become "Pelr" or "lreP".

#!/usr/bin/perl
use strict;
use warnings;

sub shuffle_words {
    my $text = shift;
    # use a regular expression to match and shuffle each word
    $text =~ s/(\w+)([^\w]*)/shuffle_word($1). $2/ge;
    return $text;
}

sub shuffle_word {

    my $word = shift;
    # if the word has 2 or fewer characters, return it unchanged
    return ($word) if (length($word) <= 2);

    # call the fisher_yates_shuffle subroutine to shuffle the middle characters
    my $first_char = substr($word, 0, 1);
    my $middle = substr($word, 1, length($word) - 2);
    my $last_char = substr($word, -1);
    return $first_char . fisher_yates_shuffle($middle) . $last_char;
}

# define a subroutine to shuffle an array using the Fisher-Yates algorithm
sub fisher_yates_shuffle {

    my @chars = split(//, $_[0]);

    my $i = scalar (@chars);
    # iterate over the array, swapping each element with a random element
    while ($i--) {
        # generate a random index
        my $j = int rand($i + 1);
        # swap the current element with the element at the random index
        @chars[$i, $j] = @chars[$j, $i];
    }

    return (join('', @chars));
}

Tests

my $str;

Example 1
$str = "this is, this IS an exCellent Idea!!";

$str = shuffle_words($str);
print("$str\n"); # e.g. this is, tihs IS an eelelCxnt Ieda!!

Example 2
$str = "The Fisher-Yates shuffle is an efficient algorithm for producing
a random permutation of a finite sequence by repeatedly selecting and
swapping elements in place, ensuring that every possible arrangement is
equally likely.";

$str = shuffle_words($str);
print("$str\n"); # e.g. The Fsiehr-Yteas sfflhue is an encieffit alighotrm for prniucdog
a raodnm pimatoerutn of a fnitie sncqueee by relpeaetdy sienetlcg and
sniappwg etlmeens in palce, einnrsug taht ervey pssbiole aranrgenemt is
ellaquy likley.

