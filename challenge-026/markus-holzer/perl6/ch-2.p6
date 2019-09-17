use v6;
use Test;

sub radians( $degrees )
{
    $degrees * π / 180
}

sub degrees( $radians )
{
    $radians * 180 / π
}

sub mean-angle( *@angles )
{
    my $inv = 1 / @angles.elems;

    degrees( atan2(
        $inv * [+] @angles.map({ radians( $_ ).sin }),
        $inv * [+] @angles.map({ radians( $_ ).cos })
    ));
}

ok( mean-angle( 10, 10, 10 ) =~= 10 );
ok( mean-angle( 10, 20, 30 ) =~= 20 );
ok( mean-angle( 355, 5, 15 ) =~= 5 );
