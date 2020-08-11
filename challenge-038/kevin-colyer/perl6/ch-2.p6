#!/usr/bin/perl6
use v6;

use Test;

=begin pod

Task 38.2

Word Game
Lets assume we have tiles as listed below, with an alphabet (A..Z) printed on them. Each tile has a value, e.g. A (1 point), B (4 points) etc. You are allowed to draw 7 tiles from the lot randomly. Then try to form a word using the 7 tiles with maximum points altogether. You don’t have to use all the 7 tiles to make a word. You should try to use as many tiles as possible to get the maximum points.

For example, A (x8) means there are 8 tiles with letter A.

...

=end pod

my %points;
%points<A G I S U X Z>= 1 xx * ;
%points<E J L R V Y>  = 2 xx * ;
%points<F D P W>      = 3 xx * ;
%points<B N>          = 4 xx * ;
%points<T O H M C>    = 5 xx * ;
%points<K Q>          = 10 xx * ;


my %tilebag is BagHash =
    :A(8), :G(3), :I(5), :S(7), :U(5), :X(2), :Z(5),
    :E(9), :J(3), :L(3), :R(3), :V(3), :Y(5),
    :F(3), :D(3), :P(5), :W(5),
    :B(5), :N(4),
    :T(5), :O(3), :H(3), :M(4), :C(4),
    :K(2), :Q(2),
;


my %wordlist;
# change to use a better dictionary - system directory is not a great one!
my $dict="/usr/share/dict/words";

my $cache="myWordList.txt";
if $cache.IO.e == False {

    say "Processessing wordlist and caching...";
    say "  Slurping...";
    # slurp in dictionary, split on lines, filter any comments (other dictionarys may have them)
    # trim by using .words (just in case), filter to length we want and remove punctuation and Acented words
    my @words=slurp($dict).uc.lines.grep( * !~~ /^ '#' / ).words.grep( *.chars <= 7 ).grep( * !~~ / <-[A..Z]> / );
    say "  Pre-computing...";
    for @words {
        %wordlist{$_.comb.sort.join} = [scoreTiles( $_.comb ), $_];
    }
    say "  Spurting {%wordlist.elems} words...";
    $cache.IO.spurt(%wordlist);

} else {

    say "Loading cached wordlist...";
    for $cache.IO.slurp.lines.words -> $a, $b, $c {
        %wordlist{$a}= [$b,$c];
    }
    say "  Loaded {%wordlist.elems} words.";

}

sub drawTiles ($num is copy = 7) {
    my @tiles;
    while $num>0 and %tilebag.total>0 {
        my $t=%tilebag.roll;
        %tilebag{$t}--;
        @tiles.push: $t;
        $num--;
    }
    return @tiles;
}

sub scoreTiles (@cand) {
    [+] (%points{$_} for @cand);
}

# create all combinations of words, check if exist and score
# note .combinations does not every anagrams so sort and compare with pre-sorted dictionary to find a word
sub makeWords(@tiles) {
    my @result = "", 0;
    for @tiles.combinations -> @cand {
        next if @cand.elems < 2;
        my $cand=@cand.sort.join;
        next unless %wordlist{$cand}:exists;
        my ($s,$w)= %wordlist{$cand};
        if $s > @result[1] and $cand.chars => @result[0].chars {
            @result[0,1]=$w,$s;
        };
    }
    return @result;
}

sub removeTiles(@hand is copy,@tiles) {
    my $i;
    for @tiles -> $t {
        $i = @hand.first: * eq $t, :k;
        @hand.splice( $i, 1 );
    }
    return @hand;
}

#####################################################

#| Tests
multi MAIN('test') {
    is makeWords(<G C N E S Z L>),("CENS",12),"test"; # will depend on how good your dictionary is...
    is removeTiles(<K E V I N>, <N I>), <K E V>,"test removeTiles";
    is removeTiles(<K E V I N>, <K I>), <E V N>,"test removeTiles";
    is removeTiles(<K E V I N>, <K E V I N>), (),"test removeTiles";
    done-testing;
}

#| Draw tiles and make a word
multi MAIN() {
    my @hand=drawTiles;
    say @hand ~ " gives " ~ makeWords(@hand).gist;
}

#| Suggest a set of seven letters to solve eg suggest lemons
multi MAIN('suggest', Str $tiles) {
    my $t=$tiles.words.uc;
    die "Only 7 letters please" if $t.chars>7;
    my $start=now;
    my @answer=makeWords($t.comb);
    my $elapsed=now - $start;
    if @answer[1]>0 {
        say "Using [$t] the best word to make is [{@answer[0]}] scoring {@answer[1]} points in $elapsed seconds";
    } else {
        say "I can't make any words from [$t] ($elapsed seconds)";
    }
}

#| Start by selecting tiles and make words for as long as possible
multi MAIN('play') {
     my @hand;
     my $total;
     loop {
        my @next=drawTiles(7-@hand.elems);
        # no more tiles...
        if @next==0 {
            say "Run out of tiles!";
            last;
        };
        @hand.append: @next;
        @hand=@hand.sort;

        my ($w,$s) = makeWords(@hand);
        # no possible score...
        if $s==0 { #last
            say "Can't make a word from {@hand.sort.gist}";
            last;
        };

        $total+=$s;
        say "{@hand.gist} => '$w' scoring $s (total: $total)";
        @hand=removeTiles(@hand,$w.comb);
     }
}
