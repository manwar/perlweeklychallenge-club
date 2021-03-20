#!/usr/bin/env raku

sub random ( $tokens ) {
    (1..3).pick min $tokens
}

sub smart ( $tokens ) {
    ($tokens % 4) max 1
}

sub semi-smart ( $tokens ) {
    (&smart,&random).pick.($tokens)
}

sub human ( $tokens )  {
    prompt('pick 1, 2 or 3: ')
}

my %players = :&human, :&smart, :&random, :&semi-smart;

subset Pick of Int where * ∈ 1..3;
sub play ($tokens, &rival) {
    my Pick $pick = $tokens.&rival;
    $tokens - $pick;
}

sub nim ( :&fp, :&sp, :$tokens = 12  ) {
    $tokens, |(|(&fp, &sp) xx *)
    andthen $_ Z=> .produce: &play
    andthen .first: *.value ≤ 0
    andthen .key.name;
}


multi MAIN (
    $first-player = 'human',        #= human. smart, semi-smart or random
    $second-player = 'semi-smart',  #= human. smart, semi-smart or random
    Int :$tokens = 12,
) {
    &play.wrap: -> $tokens, &rival {
        say "$tokens tokens {&rival.name} plays";
        callsame;
    }
    say nim( fp => %players{$first-player}, sp =>  %players{$second-player}, :$tokens ), ' wins'
}


multi MAIN (Bool :$test! ) {
    use Test;
    is smart(4), 1;
    is smart(17),1;
    is play(12,&smart), 11;
    is play(23,&smart), 20;
    is nim(fp => &smart, sp => &random, tokens => 21), 'smart', 'smart wins with 21 tokens';
    done-testing;
}
