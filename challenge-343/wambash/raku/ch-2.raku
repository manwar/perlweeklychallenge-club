#!/usr/bin/env raku

sub champion-team (+grid) {
    my %adepts := (
        grid
        andthen .max: *.cache.sum, :p
        andthen .Map
    );
    
    %adepts
    andthen .nodemap: { $_[%adepts.keys] }\
    andthen .max: *.value.sum                   
    andthen .key                
}

multi MAIN (Bool :test($)!) {
    use Test;

    # Example cases from the challenge
    is champion-team([ [0,1,1], [0,0,1], [0,0,0] ]), 0,
        'Team 0 beats Team 1 and 2 → champion 0';
    is champion-team([ [0,1,0,0], [0,0,0,0], [1,1,0,0], [1,1,1,0] ]), 3,
        'Team 3 beats everyone → champion 3';
    is champion-team([ [0,1,0,1], [0,0,1,1], [1,0,0,0], [0,0,1,0] ]), 0,
        'Teams 0 and 1 tie with 2 wins, but 0 beats 1 → champion 0';
    is champion-team([ [0,1,1], [0,0,0], [0,1,0] ]), 0,
        'Team 0 beats both others → champion 0';
    is champion-team([ [0,0,0,0,0], [1,0,0,0,0], [1,1,0,1,1], [1,1,0,0,0], [1,1,0,1,0] ]), 2,
        'Team 2 beats almost everyone → champion 2';

    # Additional edge cases
    is champion-team([ [0] ]), 0, 'single team → champion 0';
    is champion-team([ [0,1], [0,0] ]), 0, 'two teams: team 0 beats team 1 → champion 0';
    is champion-team([ [0,0], [1,0] ]), 1, 'two teams: team 1 beats team 0 → champion 1';

    done-testing;
}

multi MAIN (+grid) {
    say champion-team grid».comb: / 0|1 /;
}
