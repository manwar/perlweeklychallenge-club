use v5.36;
use strict;
use warnings;
##
# You are given an encoded string consisting of a sequence $s of numeric characters: 0..9.
# Write a script to find the all valid different decodings in sorted order.
##
use AI::Prolog;
use Hash::MultiKey;

my $prolog_code;
sub init_prolog{
    $prolog_code = do{
        local $/;
        <DATA>;
    };
}

sub decoded_list{
    my($s) = @_;
    my $prolog = $prolog_code;
    my @alphabet = qw/A B C D E F G H I J K L M N O P Q R S T U V W X Y Z/;
    my @encoded;
    my @decoded;
    my $length = length($s);
    $prolog =~ s/_LENGTH_/$length/g;
    $prolog = AI::Prolog->new($prolog); 
    $prolog->query("sum(Digits).");
    my %h;
    tie %h, "Hash::MultiKey";
    while(my $result = $prolog->results){
        $h{$result->[1]} = undef;
    }
    for my $pattern (keys %h){
        my $index = 0;
        my $encoded = [];
        for my $i (@{$pattern}){
            push @{$encoded}, substr($s, $index, $i);
            $index += $i;
        }
        push @encoded, $encoded if 0 == grep { $_ > 26 } @{$encoded};
    }
    @decoded = sort { $a cmp $b } map { join("", map { $alphabet[$_ - 1] } @{$_}) } @encoded;
}

MAIN:{
    init_prolog;
    say join(", ", decoded_list(11));
    say join(", ", decoded_list(1115));
    say join(", ", decoded_list(127));
}

__DATA__
member(X,[X|_]).
member(X,[_|T]) :- member(X,T).

digits([1, 2]).

sum(Digits):-
    sum([], Digits, 0).

sum(Digits, Digits, _LENGTH_). 

sum(Partial, Digits, Sum):-   
    Sum < _LENGTH_, 
    digits(L),
    member(X,L),
    S is Sum + X,
    sum([X | Partial], Digits, S). 