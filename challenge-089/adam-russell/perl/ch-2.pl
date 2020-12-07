use strict;
use warnings;
##
# Write a script to display matrix as below with numbers 1 - 9. 
# Please make sure numbers are used once.
##
use boolean;
use Math::GSL::Permutation q/:all/;

sub validate {
    my($a, $b, $c, $d, $e, $f, $g, $h, $i) = @_;
    return false if ($a + $b + $c) != 15;
    return false if ($d + $e + $f) != 15;
    return false if ($g + $h + $i) != 15;
    return false if ($a + $d + $g) != 15;
    return false if ($b + $e + $h) != 15;
    return false if ($c + $f + $i) != 15;
    return false if ($a + $e + $i) != 15;
    return false if ($c + $e + $g) != 15;
    return true;
}

sub print_matrix {
    my($a, $b, $c, $d, $e, $f, $g, $h, $i) = @_;
    print "[ $a $b $c ]\n";
    print "[ $d $e $f ]\n";
    print "[ $g $h $i ]\n";
}    

MAIN:{
    my $permutation = new Math::GSL::Permutation(9);
    while(gsl_permutation_next($permutation->raw) == 0){
        my @values =  $permutation->as_list();
        @values = map { $_ + 1 } @values;
        do { 
            print_matrix(@values);
            print "\n";
        }if validate(@values);  
    }
}