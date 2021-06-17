use constant TRIANGLE_TOP => q|/\\| ;
use constant TRIANGLE_BOTTOM => q|/__\\|;

sub print_triangle_3{
    my($n) = @_;
    print " " x 5;
    print TRIANGLE_TOP x 1;
    print "\n";
    print " " x4;
    print TRIANGLE_BOTTOM x 1;
    print "\n";

    print  " " ." " . " ".TRIANGLE_TOP .  " " . " " .TRIANGLE_TOP ;
    print "\n";
    print  " ". " ".TRIANGLE_BOTTOM . TRIANGLE_BOTTOM;
    print "\n";

    print  " " .TRIANGLE_TOP .  " ".  " ".TRIANGLE_TOP . " ". " ". TRIANGLE_TOP;
    print "\n";
    print  TRIANGLE_BOTTOM . TRIANGLE_BOTTOM .TRIANGLE_BOTTOM;
    print "\n";

}

sub print_triangle_2{
    my($n) = @_;
    print " " x 4;
    print TRIANGLE_TOP x 1;
    print "\n";
    print " " x3;
    print TRIANGLE_BOTTOM x 1;
    print "\n";

    print " " x1;
    print  " " .TRIANGLE_TOP .  " " . " " .TRIANGLE_TOP;
    print "\n";
    print  " ".TRIANGLE_BOTTOM . TRIANGLE_BOTTOM;
    print "\n";

}

sub print_triangle{
    my($n) = @_;
    my $top = TRIANGLE_TOP . "  ";
    for my $i (1 .. $n ){
        print " ";
        print "  " x ($n - $i);
        print $top x $i  ;
        print "\n";
        print "  " x ($n - $i );
        print TRIANGLE_BOTTOM x ($i );
        print "\n";
    }
}

MAIN:{
    print_triangle(1);
        print "\n";
        print "\n";
    print_triangle(2);
        print "\n";
        print "\n";
    print_triangle(3);
        print "\n";
        print "\n";
    print_triangle(4);
        print "\n";
        print "\n";
    print_triangle(7);
        print "\n";
        print "\n";
    print_triangle(10);
        print "\n";
        print "\n";
    print_triangle(20);
        print "\n";
        print "\n";
} 
