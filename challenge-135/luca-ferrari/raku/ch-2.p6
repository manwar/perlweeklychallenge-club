#!raku

sub MAIN( Str $name = 'Katie' ) {
    my $first-char = $name.substr( 0, 1 ).lc;
    my $mangled-name = qw< a e i o u >.grep( * ~~ $first-char ) ?? $name !! $name.substr( 1, $name.chars ).lc;
    my @special-chars = qw< b f m >.map: { $_ !~~ $first-char ??  $_  !!  '' };

    say qq:to/SONG/;
    $name, $name bo-{ @special-chars[ 0 ] ~ $mangled-name.lc }
    Bonana-fanna fo-{ @special-chars[ 1 ] ~ $mangled-name.lc }
    Fee fi mo-{ @special-chars[ 2 ] ~  $mangled-name.lc }
    $name !
SONG
}
