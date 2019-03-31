use v6;

# Challenge #1
# Write a script to replace the character ‘e’ with ‘E’ in the string ‘Perl Weekly Challenge’.
# Also print the number of times the character ‘e’ found in the string.
my ($substy-version, $original) = 'The Weekly Perl Challenge' xx 2;
my $matches = $substy-version ~~ s:g/e/E/;
say qq["$original" string becomes "$substy-version",\n\twith {$matches.elems} e's having been uppercased];

