use strict;
use warnings;
##
# Write a script to print 11x11 multiplication 
# table, only the top half triangle.
##
use Perl6::Form; 
sub print_table11{
    my($x,$x1,$x2,$x3,$x4,$x5,$x6,$x7,$x8,$x9,$x10,$x11); 
    my $header = form  
        '    x|   1   2   3   4   5   6   7   8   9   10   11', 
        '  ---+----------------------------------------------'; 
    print "$header"; 
    for $x (1 .. 11){
        my @a;
        @a = (0) x ($x -1) if $x > 1; 
        push @a, ($x .. 11);
        ($x1,$x2,$x3,$x4,$x5,$x6,$x7,$x8,$x9,$x10,$x11) = map {$_ ==  0 ? "" : $_} map { $x * $_ } @a;  
        my $row = form
            ' {>>}|{>>}{>>}{>>}{>>}{>>}{>>}{>>}{>>}{>>}{>>>}{>>>}', 
            $x,$x1,$x2,$x3,$x4,$x5,$x6,$x7,$x8,$x9,$x10,$x11;  
        print "$row";
    }
}

MAIN:{
    print_table11; 
}
