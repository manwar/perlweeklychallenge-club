sub is_self_descriptive {
    my $num     = shift;
    my $str_num = "$num";
    my $length  = length($str_num);

    for my $i ( 0 .. ( $length - 1 ) ) {
        my $digit = substr( $str_num, $i, 1 );
        my $count = () = $str_num =~ /\Q$i/g;
        return 0 if $count != $digit;
    }

    return 1;
}

sub find_self_descriptive {
    my $n     = shift;
    my $found = 0;
    my $num   = 0;
    while ( $found < $n ) {
        if ( is_self_descriptive($num) ) {
            print "$num\n";
            $found++;
        }
        $num++;
    }
}

find_self_descriptive(3);
