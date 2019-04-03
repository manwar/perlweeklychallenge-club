use strict;
use warnings;
##
# Challenge #1
# Write a script to replace the character 'e' with 'E' in the string 'Perl Weekly Challenge'.
# Also print the number of times the character 'e' is found in the string.
##
my $challenge_string = "Perl Weekly Challenge";
my $number = do {
    $challenge_string =~ tr/e/E/;
};
print "$number $challenge_string\n";
