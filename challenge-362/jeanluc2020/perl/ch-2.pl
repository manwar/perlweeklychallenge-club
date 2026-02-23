#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-362/#TASK2
#
# Task 2: Spellbound Sorting
# ==========================
#
# You are given an array of integers.
#
# Write a script to return them in alphabetical order, in any language of your
# choosing. Default language is English.
#
## Example 1
##
## Input: (6, 7, 8, 9 ,10)
## Output: (8, 9, 7, 6, 10)
##
## eight, nine, seven, six, ten
#
#
## Example 2
##
## Input: (-3, 0, 1000, 99)
## Output: (-3, 99, 1000, 0)
##
## minus three, ninety-nine, one thousand, zero
#
#
## Example 3
##
## Input: (1, 2, 3, 4, 5)
##
## Output: (5, 2, 4, 3, 1) for French language
## cinq, deux, quatre, trois, un
##
## Output: (5, 4, 1, 3, 2) for English language
## five, four, one, three, two
#
#
## Example 4
##
## Input: (0, -1, -2, -3, -4)
## Output: (-4, -1, -3, -2, 0)
##
## minus four, minus one, minus three, minus two, zero
#
#
## Example 5
##
## Input: (100, 101, 102)
## Output: (100, 101, 102)
##
## one hundred, one hundred and one, one hundred and two
#
############################################################
##
## discussion
##
############################################################
#
# The most tricky part here is to get the spelling of the numbers
# right. For this, we write a function for each language which returns
# the written representation of the number (implemented below are
# English and French, supporting numbers up until 9999).
# Then we just need to sort by the result of this function.
# The real magic happens inside those functions turning numbers into
# their string representations as that's a long list of checking
# various cases.

use v5.36;

spellbound_sorting(6, 7, 8, 9 ,10);
spellbound_sorting(-3, 0, 1000, 99);
spellbound_sorting(1, 2, 3, 4, 5);
spellbound_sorting(0, -1, -2, -3, -4);
spellbound_sorting(100, 101, 102);

sub spellbound_sorting(@ints) {
    say "Input: (" . join(", ", @ints) . ")";
    say "Output for English: (" .
       join(", ", sort { number_to_english($a) cmp number_to_english($b) } @ints) . ")";
    say "Output for French: (" .
       join(", ", sort { number_to_french($a) cmp number_to_french($b) } @ints) . ")";
}

sub number_to_english($number) {
    return "minus " . number_to_english(-$number) if $number < 0;
    my @numbers = ("zero", "one", "two", "three", "four", "five",
        "six", "seven", "eight", "nine", "ten", "eleven", "twelve",
        "thirteen", "fourteen", "fifteen", "sixteen", "seventeen",
        "eighteen", "nineteen", "twenty");
    return $numbers[$number] if $number < 21;
    my $tens = { 20 => "twenty", 30 => "thirty", 40 => "forty",
        50 => "fifty", 60 => "sixty", 70 => "seventy",
        80 => "eighty", 90 => "ninety" };
    if(20 < $number && $number < 100) {
        my $t = 10 * int($number / 10);
        if($number % 10) {
            return $tens->{$t} . "-" . $numbers[$number % 10];
        } else {
            return $tens->{$t};
        }
    }
    if($number < 1000) {
        my $h = int($number / 100);
        return $numbers[$h] . " hundred " . number_to_english($number % 100) if $number % 100;
        return $numbers[$h] . " hundred";
    }
    my $t = int($number / 1000);
    return $numbers[$t] . " thousand " . number_to_english($number % 1000) if $number % 1000;
    return $numbers[$t] . " thousand";
}

sub number_to_french($number) {
    return "moins " . number_to_french(-$number) if $number < 0;
    my @numbers = ("zéro", "un", "deux", "trois", "quatre", "cinq",
        "six", "sept", "huit", "neuf", "dix", "onze", "douze",
        "treize", "quatorze", "quinze", "seize", "dix-sept",
        "dix-huit", "dix-neuf", "vingt");
    return $numbers[$number] if $number < 21;
    my $tens = { 20 => "vingt", 30 => "trente", 40 => "quarante",
        50 => "cinquante", 60 => "soixante", 80 => "quatre-vingts" };
    if(20 < $number && $number < 70) {
        my $t = 10 * int($number / 10);
        if($number % 10) {
            return $tens->{$t} . " et un" if $number % 10 == 1;
            return $tens->{$t} . "-" . $numbers[$number % 10];
        } else {
            return $tens->{$t};
        }
    }
    if($number < 80) {
        return "soixante-dix" if $number == 70;
        return "soixante et onze" if $number == 71;
        return "soixante-" . $numbers[$number - 60];
    }
    if($number < 100) {
        return "quatre-vingts" if $number == 80;
        return "quatre-vingt-" . $numbers[$number - 80];
    }
    if($number < 200) {
        return "cent" if $number == 100;
        return "cent " . number_to_french($number % 100);
    }
    if($number < 1000) {
        my $h = int($number / 100);
        return $numbers[$h] . " cent " . number_to_french($number % 100) if $number % 100;
        return $numbers[$h] . " cent";
    }
    my $t = int($number / 1000);
    if($number < 2000) {
        return "mille " . number_to_french($number % 1000) if $number % 1000;
        return "mille";
    } else {
        return $numbers[$t] . " mille " . number_to_french($number % 1000) if $number % 1000;
        return $numbers[$t] . " mille";
    }
}
