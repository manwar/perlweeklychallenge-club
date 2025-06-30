#!/usr/bin/env raku

# Int Flag to run tests as we are accepting strings
multi sub MAIN(1) is hidden-from-USAGE {
    use Test;
    ok test-is-valid-result("abc"), 'Test valid result';
    ok ! test-is-valid-result("aa"), 'Test invalid Result';
    ok test-is-valid-input("a?b"), 'Test valid input string';
    ok ! test-is-valid-input("a??bb"), 'Test Invalid input string';
    ok test-is-valid-input("???????????"), 'Long string of QMs is valid';
    ok test-is-valid-result(replace-qms('a??c')), 'Simple test of replace';
    for (1..10) {
        ok test-is-valid-result(replace-qms('a?z')), "Test $_ : Example 1";
        ok test-is-valid-result(replace-qms('pe?k')), "Test $_ : Example 2";
        ok test-is-valid-result(replace-qms('gra?t')), "Test $_ : Example 3";
    }
    for (1..100) {
        ok test-is-valid-result(replace-qms('???????')), "Test $_ : All question marks";
    }
        
    done-testing;
}

subset AlphaLCAndQM of Str  where * ~~ /^ <[a..z ?]>+ $/;
subset ValidInput of AlphaLCAndQM where {
    $_.comb('').rotor(2=>-1).grep({ @_[0] !~~ '?' }).grep( { @_[0] ~~ @_[1] }).elems == 0;
}

multi sub test-is-valid-input( ValidInput $str ) { True }
multi sub test-is-valid-input( $_ ) { False }

subset AlphaLCOnly of Str where * ~~ /^ <[a..z]>+ $/;
subset ValidResult of AlphaLCOnly where {
    $_.comb('').rotor(2=>-1).grep( { @_[0] ~~ @_[1] }).elems == 0;
};

multi sub test-is-valid-result( ValidResult $str ) { True }
multi sub test-is-valid-result( $_ ) { False }

sub replace-qms( ValidInput $str ) {
    my @out = $str.comb().Array;
    for 0..^@out.elems -> $idx {
        next if @out[$idx] !~~ '?';
        my @not = [];
        if ( $idx > 0 ) { @not.push(@out[$idx-1]); }
        if ( $idx != (@out.elems)-1 ) { @not.push(@out[$idx+1]); }
        my $poss = ('a'..'z') (-) @not;
        @out[$idx] = $poss.keys.roll(1)[0];
    }
    return @out.join('');
}

#|( Given a string of lower case letters with question marks in it
replace the question marks with letters so that we don't have
repeated characters.
)
multi sub MAIN(
    ValidInput $str #= A string made up of lower case letters and question marks.
) { replace-qms($str).say }
