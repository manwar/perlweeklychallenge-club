sub countNumbers {
    my $n = shift;
    my $count = 0;

    for ( $i = 1; $i <= $n; $i++ ) {
        my @stringSplit = split(//, "$i");

        my $j = 0;
        foreach my $s ( @stringSplit ) {
            $s == 1 ? last : $j++;
        }
        $count++ if $j == scalar @stringSplit; # We arrived at the end of the list without finding 1
    }
    print "Count is : $count \n";
}

countNumbers(25);

