use strict;
use warnings;
use Data::Dumper;

sub remove_duplicates {
    my @array = @_;
    my %seen;
    my @result;

    local $Data::Dumper::Terse  = 1;    # remove "$VAR1 = " prefix
    local $Data::Dumper::Indent = 0;    # output in a single line

    for my $element (@array) {
        my $key = Dumper($element);
        if ( !exists $seen{$key} ) {
            push @result, $element;
            $seen{$key} = 1;
        }
    }

    return @result;
}

my @list1 = ( [ 1, 2 ], [ 3, 4 ], [ 5, 6 ], [ 1, 2 ] );
my @list2 = ( [ 9, 1 ], [ 3, 7 ], [ 2, 5 ], [ 2, 5 ] );

print Dumper( remove_duplicates(@list1) );
print "\n";
print Dumper( remove_duplicates(@list2) );
