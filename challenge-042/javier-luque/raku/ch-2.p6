# Test: perl6 ./ch-2.p6
use v6.d;
constant $MAX_STRING_LENGTH = 4;

sub MAIN () {
    for ( 1 .. 20 ) {
        my $string = generate-random-string();
        my $ok = (validate-string($string)) ?? 'OK ' !! 'NOT OK';
        say $string ~ ' - ' ~ $ok;
    }
}

sub generate-random-string {
    return <( )>.roll(
        Int((2 .. $MAX_STRING_LENGTH + 1).rand)
    ).join;
}

sub validate-string(Str $word) {
    my $open_p;

    for $word.comb -> $letter {
        $open_p++ if ($letter eq '(');
        $open_p-- if ($letter eq ')');
        return 0 if ($open_p < 0);
    }

    return ($open_p == 0);
}
