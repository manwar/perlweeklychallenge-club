#!/usr/bin/raku

sub MAIN(
    $s, #= sources (integers separated by whitespace) 
    $i  #= indices (integers separated by whitespace)
) {
    my @sources = $s.split(/\s+/).map({ .Int });
    my @indices = $i.split(/\s+/).map({ .Int });
    my @output;

    for @sources.keys -> $i {
        @output.splice(@indices[$i], 0,  @sources[$i]);
    }

     say q{(}, @output.join(q{, }), q{)};
}