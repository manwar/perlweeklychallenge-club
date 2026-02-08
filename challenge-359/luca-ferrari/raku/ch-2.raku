sub MAIN( Str $string where { $string ~~ / ^ <[a..zA..Z]>+ $ / } ) {

    my $reduced = $string;
    $reduced ~~ s:g/ (.) $0 //;
    $reduced.say;
}
