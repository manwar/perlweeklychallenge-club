#!/usr/bin/perl6

sub generate(Int $n) {
    my %rules = (
        a => [< e i >],
        e => [< i >],
        i => [< a e o u >],
        o => [< a u >],
        u => [< e o >]
    );

    my @generated;
    for (1 .. $n) -> $i {
        if ($i == 1) {
            @generated = %rules.keys.sort;
        } else {
            @generated = @generated.map({
                my $e = $_;
                | %rules{$e.substr(*-1, 1)}.values.map({  $e ~ $_; });
            });
        }
    }

    return @generated;
}


multi sub MAIN (
    Int $n where { $n > 0 && $n < 6 }  #= length of vowel string to be generated from 1 to 5
) {
    for generate($n) -> $i {
        $i.say;
    }
}