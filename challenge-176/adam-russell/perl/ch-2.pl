use strict;
use warnings;
##
# Write a script to find out all Reversible Numbers below 100.
##
sub is_reversible{
    my($x) = @_;
    my @even_digits = grep { $_ % 2 == 0 } split(//, ($x + reverse($x)));
    return @even_digits == 0;
}

sub reversibles_under_n{
    my($n) = @_;
    my @reversibles;
    do{
        $n--;
        unshift @reversibles, $n if is_reversible($n);
    
    }while($n > 0);
    return @reversibles;
}

MAIN:{
    print join(", ", reversibles_under_n(100)) . "\n";
}