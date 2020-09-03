use strict;
use warnings;

use AI::Prolog;
use Hash::MultiKey;

MAIN:{
    my $S = $ARGV[0];
    my $C = "[" . $ARGV[1] . "]";

    my $prolog = do{
        local $/;
        <DATA>;
    }; 
    $prolog =~ s/_COINS_/$C/g;
    $prolog =~ s/_SUM_/$S/g;
    $prolog = new AI::Prolog($prolog); 
    $prolog->query("sum(Coins).");
    my %h;
    tie %h, "Hash::MultiKey";
    while(my $result = $prolog->results){
        my @s = sort @{$result->[1]};
        $h{\@s} = undef;
    }
    for my $k (keys %h){
        print "(" . join(",", @{$k}) . ")";
        print "\n";
    }
}

__DATA__
member(X,[X|_]).
member(X,[_|T]) :- member(X,T).

coins(_COINS_).

sum(Coins):-
    sum([], Coins, 0).

sum(Coins, Coins, _SUM_). 

sum(Partial, Coins, Sum):-   
    Sum < _SUM_, 
    coins(L),
    member(X,L),
    S is Sum + X,
    sum([X | Partial], Coins, S).  