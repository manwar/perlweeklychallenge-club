##
# Write a script to print 11x11 multiplication
# table, only the top half triangle.
##
use Form; 
sub print_table11 {
    my ($x,$x1,$x2,$x3,$x4,$x5,$x6,$x7,$x8,$x9,$x10,$x11);
    my $header = form
        '    x|   1   2   3   4   5   6   7   8   9   10   11',
        '  ---+----------------------------------------------';
    print $header;
    for 1 .. 11 -> $x {
        my @a;
        @a = (0) xx ($x -1) if $x > 1;
        @a.append($x .. 11);
        my @b = map({$_ ==  0 ?? "" !! $_}, map({ $x * $_ }, @a));
        print sprintf '%5s|', $x;
        my $s = sprintf '%4s%4s%4s%4s%4s%4s%4s%4s%4s%5s%5s', @b;
        say $s;
    }
}

sub MAIN {
    print_table11;
}
