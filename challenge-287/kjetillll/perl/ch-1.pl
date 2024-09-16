use strict; use warnings; use Test::More tests=>5;

sub strong_pw_steps {
    my @check = ([0,shift]); #work list for BFS https://en.wikipedia.org/wiki/Breadth-first_search
    while( my($steps,$pw) = @{ shift @check } ){
        return $steps
            if  $pw =~ /[a-z]/
            and $pw =~ /[A-Z]/
            and $pw =~ /[0-9]/
            and $pw =~ /.{6}/
            and $pw !~ /(.)\1\1/;
        my @unused_lower = grep $pw !~ /$_/, 'a'..'z';
        my @unused_upper = grep $pw !~ /$_/, 'A'..'Z';
        my @unused_digit = grep $pw !~ /$_/, '0'..'9';
        my @candidates = ( #new chars for insert or replace, if no unused then all is candidate in each class
            ( @unused_lower ? ($unused_lower[0]) : 'a'..'z' ),
            ( @unused_upper ? ($unused_upper[0]) : 'A'..'Z' ),
            ( @unused_digit ? ($unused_digit[0]) : '0'..'9' )
        );
        push @check,
            grep $$_[1] ne $pw,                     # remove if no 3 repeating
            map {
              [$steps+1, $pw.$_],                   # insert new at end
              [$steps+1, $pw =~ s/(.)\1\1/$1$1$_/r] # replace last in 3 repeating
            }
            @candidates
    }
}


is strong_pw_steps( "a" )         => 5;
is strong_pw_steps( "aB2" )       => 3;
is strong_pw_steps( "PaaSW0rd" )  => 0;
is strong_pw_steps( "Paaasw0rd" ) => 1;
is strong_pw_steps( "aaaaa" )     => 2;
