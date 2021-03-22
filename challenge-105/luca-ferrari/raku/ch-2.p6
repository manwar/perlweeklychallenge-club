#!raku

sub MAIN( Str $name = 'Katie' ) {
    my $mangled-name = $name.substr( 1, $name.chars ).lc;
    my @special-chars = qw< b f m >.map: { $_ !~~ $name.substr( 0, 1 ).lc ??  $_  !!  '' };

    say qq:to/SONG/;
    $name, $name bo-{ @special-chars[ 0 ] ~ $mangled-name }
    Bonana-fanna fo-{ @special-chars[ 1 ] ~ $mangled-name }
    Fee fi mo-{ @special-chars[ 2 ] ~  $mangled-name }
    $name !
SONG
}
