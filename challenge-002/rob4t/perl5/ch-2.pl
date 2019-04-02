my $number = $ARGV[0];
die "supply a valid integer number" if($number ne int($number));

my @b35 = ( 0 .. 9, 'A' .. 'Y' );
my @res = ();

sub calc {
    my $num = shift;
    return if ( !$num );

    push @res, $b35[ $num % 35 ];
    calc( int( $num / 35 ) );
}

calc($number);

my $res = join( '', reverse @res );

print $res . "\n";
