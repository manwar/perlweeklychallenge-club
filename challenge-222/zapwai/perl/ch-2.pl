use v5.30;
my @ints = (2, 7, 4, 1, 8, 1);
say "Input: \@ints = (" . join(",",@ints) . ")";
while (@ints > 1) {
    my $i = int rand(@ints);
    my $x = splice @ints, $i, 1;    
    my $j = int rand(@ints);
    my $y = splice @ints, $j, 1;
    nicely_print($x,$y);
    push @ints, ($y - $x) unless ($y - $x == 0);
    say "(" . join(",",@ints) . ")";
}
say "Output: @ints";

sub nicely_print {
    my ($x, $y) = @_;
    my $cnt = 0;
    $cnt++ if ( $x < 0 );
    $cnt++ if ( $y < 0 );    
    $cnt++ if (abs $x > 9);
    $cnt++ if (abs $y > 9);
    my $width = 6 - $cnt;
    print " " x $width, "$x, $y --> ";
}
