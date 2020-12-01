use strict;
use warnings;

require './Task089_2.pm';

my @solutions = Task089_2::magical_matrix();

for my $matrix( @solutions ) {
    for my $row( $matrix->@* ) {
        print "[ @$row ]", "\n";
    }
    print "\n";
}