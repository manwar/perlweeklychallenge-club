#!/usr/bin/perl
use strict;
use warnings;

sub string_lie_detector {
    # Accept a self-describing string as input.
    # Example input: "aa - two vowels and zero consonants"
    my ($self_describing_string) = @_;

    # Split the input string into two parts:
    # $text is the string to analyze, $description is its textual description.
    # Example: "aa - two vowels and zero consonants" ->
    # $text = "aa", $description = "two vowels and zero consonants"
    my ($text, $description) = split /\s*-\s*/, $self_describing_string, 2;

    # if the string doesn’t contain -, $description becomes undef
    return "False\n" unless defined $description;

    # Trim whitespace
    $text =~ s/^\s+|\s+$//g;
    $description =~ s/^\s+|\s+$//g;

    # Count vowels in $text (case-insensitive)
    # Example: "aa" -> 2 vowels
    my $number_vowels = () = $text =~ /[aeiou]/ig;

    # Count consonants in $text (case-insensitive)
    # Example: "aa" -> 0 consonants
    my $number_consonants = () = $text =~ /[b-df-hj-np-tv-z]/ig;

    # Create a hash to map number words (e.g., "two") to their numeric values
    # Example: "two" -> 2, "zero" -> 0, etc.
    # One could use Lingua::EN::Words2Num, but since it’s safe to assume that everyday English
    # words contain fewer than 15 vowels or consonants, the following approach is simpler.
    my $i = 0;
    my %word_to_number = map { $_ => $i++ }
                             qw( zero one two three four five six seven eight nine
                                 ten eleven twelve thirteen fourteen fifteen );

    # Extract the described vowel and consonant counts from the description
    # Assumes format: <number> vowel(s) ... <number> consonant(s)
    # Example: "two vowels and zero consonants" ->
    # $vowel_number_in_description = "two", $consonant_number_in_description = "zero"
    my ($vowel_number_in_description, $consonant_number_in_description) =
        $description =~ /\b(\w+)\s+vowel.*?(\w+)\s+consonant/i;

    # Map description words to numbers (lookup once)
    my $vowel_count_expected     = $word_to_number{ lc $vowel_number_in_description };
    my $consonant_count_expected = $word_to_number{ lc $consonant_number_in_description };

    # Validate that both mappings succeeded
    unless (defined $vowel_count_expected && defined $consonant_count_expected) {
        return "False\n";
    }

    # Compare actual counts with described counts
    # Return "True" if they match, otherwise "False"
    return ($number_vowels == $vowel_count_expected &&
        $number_consonants == $consonant_count_expected)
        ? "True\n" : "False\n";
}


# Tests
my $str;

# Example 1
$str = "aa - two vowels and zero consonants";
printf "%s\n", string_lie_detector($str); # Output: True

# Example 2
$str = "iv - one vowel and one consonant";
printf "%s\n", string_lie_detector($str); # Output: True

# Example 3
$str = "hello - three vowels and two consonants";
printf "%s\n", string_lie_detector($str); # Output: False

# Example 4
$str = "aeiou - five vowels and zero consonants";
printf "%s\n", string_lie_detector($str); # Output: True
