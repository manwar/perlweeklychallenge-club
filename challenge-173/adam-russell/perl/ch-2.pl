use strict;
use warnings;
##
# Write a script to generate first 10 members of Sylvester's sequence
##
use bigint; 

sub sylvester_n{
    my($n) = @_;
    my @terms = (2, 3);
    my %product_table;
    $product_table{"2,3"} = 6;
    while(@terms < $n){
        my $term_key = join(",", @terms);
        my $term = $product_table{$term_key} + 1;
        push @terms, $term;
        $product_table{"$term_key,$term"} = $term * $product_table{$term_key}; 
    }
    return @terms;
}


MAIN:{
    print join(", ", sylvester_n(10)). "\n";
}