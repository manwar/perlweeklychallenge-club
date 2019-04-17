$ARGV[0] > 2 or die "This program requires at least 3 rows to work";
for (my $i = 1; $i<=$ARGV[0]; $i++) {
    my $c = 1;
    print " "x($ARGV[0]-$i);
    for (my $e = 1; $e<=$i; $e++) {
        print "$c ";
        $c = int($c*($i-$e)/$e);
    }
    print "\n";
}
