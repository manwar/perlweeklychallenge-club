#Write a script to replace the character ‘e’ with ‘E’ in the string ‘Perl Weekly 
#Challenge’. Also print the number of times the character ‘e’ is found in the string.

my $string = "Perl Weekly Challenge";
my @count  = $string~~m:g/e/ ;
$string~~tr/e/E/;


say "Resulting string: $string";
say "Replaced e: "~0+@count~" times";