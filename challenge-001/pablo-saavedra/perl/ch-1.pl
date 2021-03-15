use strict;
use warnings;

my $var = 'Perl Weekly Challenge';
my $count = $var =~ s/e/E/g;

print "$var\n";
print 'Number of times: ', $count;
