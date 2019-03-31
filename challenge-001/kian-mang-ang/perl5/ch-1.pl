use strict;
use warnings;

my $string = 'Perl Weekly Challenge';
my $e_count = $string =~ tr/e/E/;

print "New replaced string: ", $string, "\n";
print "Number of times 'e' character found: ", $e_count, "\n";
