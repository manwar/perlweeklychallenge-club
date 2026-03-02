#!/usr/bin/perl
use strict;
use warnings;
use Lingua::Any::Numbers qw(num2str);

sub spellbound_sorting {

    my ($numbers, $lang) = @_;
    my @result;

# ---------------------------------------------------------------
# The newbie long version:
# ---------------------------------------------------------------
    # Step 1: Decorate
    # Attach the word form to each number
    my @decorated;
    for my $n (@$numbers) {
        my $word = num2str($n, $lang);
        push @decorated, [ $word, $n ];
    }

    # Step 2: Sort by the word (element [0])
    my @sorted =
        sort { $a->[0] cmp $b->[0] }
        @decorated;

    # Step 3: Undecorate
    # Extract the original numbers
    for my $pair (@sorted) {
        push @result, $pair->[1];
    }
# ---------------------------------------------------------------
The advanced, short solution:
# ---------------------------------------------------------------
# @result = map  { $_->[1] }
#           sort { $a->[0] cmp $b->[0] }
#           map  { [ num2str($_, $lang), $_ ] }
#           @$numbers;
# ---------------------------------------------------------------

    return @result;
}

# Tests

my @numbers = (1, 2, 7, 8, 11, 21);
my $language;

# Example 1 EN
$language = "EN";
printf "%s\n", join(", ", spellbound_sorting_alternative(\@numbers, $language)); # Output: (8, 11, 1, 7, 21, 2)

# Example 2 DE
$language = "DE";
printf "%s\n", join(", ", spellbound_sorting_alternative(\@numbers, $language)); # Output: (8, 1, 21, 11, 7, 2)

# Example 3 NL
$language = "NL";
printf "%s\n", join(", ", spellbound_sorting_alternative(\@numbers, $language)); # Output: (8, 1, 21, 11, 2, 7)

# Example 4 FR
$language = "FR";
printf "%s\n", join(", ", spellbound_sorting_alternative(\@numbers, $language)); # Output: (2, 8, 11, 7, 1, 21)
