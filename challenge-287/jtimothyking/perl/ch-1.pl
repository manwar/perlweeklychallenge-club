#!/usr/bin/perl
use v5.38;
use warnings;

use List::Util qw(max);

my $password = shift // 'Paaasw0rd';

# Minimum length is 6 characters.
my $num_chars_needed = 6 - length($password);
# We never need to delete characters in order to satisfy the minimum length.
$num_chars_needed = 0 if ($num_chars_needed < 0);

# We need at least one character from each of the following character classes.
my $is_lowercase = $password =~ /[a-z]/;
my $is_uppercase = $password =~ /[A-Z]/;
my $is_digit = $password =~ /\d/;
my $num_classes_needed = !$is_lowercase + !$is_uppercase + !$is_digit;

# We need to assure that at most two characters repeat in a row.
my $num_replacements_needed = 0;
# Find sequences of characters that repeat at least 3 times.
while ($password =~ /((.)\2{2,})/g) {
    # We need to replace each third repeated character in order to make sure
    # at most only two characters repeat in a row.
    $num_replacements_needed += int(length($1) / 3);
}

# Here's where a nifty optimization comes into play:
# We can add additional character classes by adding chars or by making
# replacements to the existing password. Additionally, we can reduce the
# number of replacements needed by inserting characters rather than
# changing existing ones and appending characters.
# Consider:
# - If the password is 4 characters or less, we need to add at least 2
#   characters. We will choose the new characters to be from the missing
#   classes. $num_chars_needed >= $num_classes_needed, and we will use
#   $num_chars_needed as the number of steps.
# - If the password is 3 or 4 *repeating* characters, we will insert
#   at least one character instead of appending, so we don't need to
#   replace any existing characters.
#   $num_chars_needed > $num_replacements_needed, and we will use
#   $num_chars_needed as the number of steps.
# - If the password is 5 repeating characters, we will replace one of
#   the characters and insert one new character, each from a missing
#   class. $num_chars_needed > $num_classes_needed and
#   $num_chars_needed > $num_replacements_needed, and we will use
#   $num_chars_needed as the number of steps.
# - If the password is 6 or more repeating characters, we will replace
#   at least two of the characters, each from a missing class.
#   $num_replacements_needed >= $num_classes_needed, and we will use
#   $num_replacements_needed as the number of steps.
# In other words, we only need to choose the maximum of the three values
# as the number of steps.
my $num_steps = max($num_chars_needed, $num_classes_needed, $num_replacements_needed);

say $num_steps;

__END__
