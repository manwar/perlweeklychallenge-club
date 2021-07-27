# sub ra { ( [\+] @^s ) Z/ ( 1 .. * ) }

sub running_average ( @s ) {
    constant @running_count = 1 .. *;
    my       @running_sum   = [\+] @s;

    return @running_sum Z/ @running_count;
}

put running_average( 10, 20 … * ).head(25);
