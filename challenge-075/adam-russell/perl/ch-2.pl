use strict;
use warnings;

sub print_histogram{
    my($values) = @_;
    my @sorted_values = sort @{$values};
    my $max = $sorted_values[-1];
    my $x = $max;
    while($x >= 1){
        print "$x ";
        for my $h (@{$values}){
            print "# " if $h >= $x;
            print "  " if $h < $x;
        }
        print "\n";
        $x--;
    }
    print "- " x (@{$values} + 1);
    print "\n  " . join(" ", @{$values}) ."\n";
}

MAIN:{
    #my @A = (2, 1, 4, 5, 3, 7);
    my @A = (3, 2, 3, 5, 7, 5);
    print_histogram(\@A);
    my $maximum_rectangle = -1;
    for my $i (@A){
        my $rectangle;
        for my $j (@A){
            if($i > $j){
                $rectangle = 0;
            }
            if($i <= $j){
                $rectangle += $i;
            }
        }
        $maximum_rectangle = $rectangle if $rectangle > $maximum_rectangle;
    }
    print "Largest Rectangle: $maximum_rectangle\n";
}
