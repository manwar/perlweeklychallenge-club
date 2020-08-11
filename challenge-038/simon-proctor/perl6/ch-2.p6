#!/usr/bin/env perl6

use v6;

constant %SCORES = (
    :1A, :4B, :5C, :3D, :2E, :3F, :1G,
    :5H, :1I, :2J, :10K, :2L, :5M, :4N,
    :5O, :3P, :10Q, :2R, :1S, :5T, :1U,
    :2V, :3W, :1X, :2Y, :1Z
);

subset ValidTile of Str where { %SCORES{$_}:exists };

class Tile {
    has Str $.letter;
    has Int $.score;

    multi method new( ValidTile $letter ) {
        self.new( :$letter, :score(%SCORES{$letter}) );
    }

    multi method new( Str $letter ) {
        self.new( :$letter, :score(-1) );
    }
    
    method Str { $.letter }
    method Numeric { $.score }
    method Int { $.score }
    method gist { "{$.letter} ($.score)" }
    method ACCEPTS ( Tile $t ) { $.letter ~~ $t.letter }
    method WHICH () { $.letter }
}

constant $BAG = Bag.new(
    |( Tile.new( "A" ) xx 8), |( Tile.new( "B" ) xx 5), |( Tile.new( "C" ) xx 4),
    |( Tile.new( "D" ) xx 3), |( Tile.new( "E" ) xx 9), |( Tile.new( "F" ) xx 3),
    |( Tile.new( "G" ) xx 3), |( Tile.new( "H" ) xx 3), |( Tile.new( "I" ) xx 3),
    |( Tile.new( "J" ) xx 3), |( Tile.new( "K" ) xx 2), |( Tile.new( "L" ) xx 3),
    |( Tile.new( "M" ) xx 4), |( Tile.new( "N" ) xx 4), |( Tile.new( "O" ) xx 3),
    |( Tile.new( "P" ) xx 5), |( Tile.new( "Q" ) xx 2), |( Tile.new( "R" ) xx 3),
    |( Tile.new( "S" ) xx 7), |( Tile.new( "T" ) xx 5), |( Tile.new( "U" ) xx 5),
    |( Tile.new( "V" ) xx 3), |( Tile.new( "W" ) xx 5), |( Tile.new( "X" ) xx 2),
    |( Tile.new( "Y" ) xx 5), |( Tile.new( "Z" ) xx 5)
);

#| The Amazing Not Scrabble Game (honest)
sub MAIN(
    Int() $tile-count = 7 #= Number of tiles to draw from the bag (Default 7)
) {
     my @tiles = $BAG.pick( $tile-count );
     say "Tiles drawn {join(",", @tiles)} max possible score {[+] @tiles}";
     my $match-bag = Bag.new( @tiles );
     my $data-channel = Channel.new;
     my @p;
     @p.push( start check-words( $data-channel, $match-bag ) ) for ^3;
     $data-channel.send($_) for "/etc/dictionaries-common/words".IO.lines.grep(*.codes <= $tile-count);
     $data-channel.close;
     await @p;
     my $result = @p.sort( { $^b.result.value cmp $^a.result.value } ).head.result;
     $result.value ?? say "{$result.key} scores {$result.value}" !! say "I couldn't find a word";
}

sub check-words( Channel $input, Bag $match-bag ) {
    my $result = ( "" => 0 );
    react {
        whenever $input -> $word {
            my $checked = valid-word( $word, $match-bag );
            my $score = [+] $checked.kxxv;
            if $score > $result.value {
                $result = ( $word => $score );
            }
        }
    }
    return $result;
}

sub valid-word( Str $word, Bag $match-bag ) is pure {
    my $word-bag =  $word.uc.comb.map( { Tile.new( $_ ) } ).Bag;
    $word-bag (<=) $match-bag ?? $word-bag !! Bag.new(); 
}

