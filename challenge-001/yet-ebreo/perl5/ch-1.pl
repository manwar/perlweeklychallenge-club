#Write a script to replace the character ‘e’ with ‘E’ in the string ‘Perl Weekly 
#Challenge’. Also print the number of times the character ‘e’ is found in the string.
use 5.010;
sub get_e {
    return $_[0]=~y/e/E/;
}

my $string = "Perl Weekly Challenge";
my $count  = get_e( $string );

say "Resulting string: $string";
say "Replaced e: $count times";