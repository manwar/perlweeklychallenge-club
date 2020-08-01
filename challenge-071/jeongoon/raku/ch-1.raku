#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

class RandomList {
    has @.list-all        is rw = 1..42;
    has Int $.num-of-list is rw = 9;

    submethod BUILD ( :out-of(:@!list-all),
                      Int :selects(:$!num-of-list) ) {
    }

    method get-random-list () {
        my $size = @!list-all.elems;

        for ^$size {
            my ( $lf, $ri ) = ( 0 ..^ $size ).rand.Int xx 2;
            @!list-all[$lf, $ri] = @!list-all[$ri, $lf];
        }
        return @!list-all[0..^ $!num-of-list];
    }
}

class PeakNum {
    has ( $.left, $.mine ,$.right );
    method lowest () { 0 }
    method take () {
        # XXX list-all itself contains Any type but check numerical only here.
        take $!mine if $!mine > ( ($!left || self.lowest),
                                 ($!right || self.lowest) ).all;
    }
}

# $N == 1 isn't very harmful
sub MAIN ( $N where { $N >= 1 } = 8,  #= size of random numbers
          Bool :$relax,                 #= loose strict rule in the challenge
          :$max-number? where { $max-number >= $N } = 50,
       ) {

    #
    if $relax.not {
        die "\$N must be greater than 1" unless $N > 1;
        if $max-number != 50 {
            warn "max number is redeclared as 50";
            $max-number = 50;
        }
    }

    my $random-numbers = RandomList.new: :selects($N) :out-of(1 .. 50);
    my $list = $random-numbers.get-random-list;
    say "Array: " ~ $list.Array.raku;

    my @peak-array = Array.new;
    #if $N == 1 {
    #    @peak-array.
    #    append( PeakNum.new( :mine($list[0]) ) );
    #}
    #else {
        for ^$N {
            @peak-array.
            append( PeakNum.new( :left( try $list[$_-1] )
                                 :mine( $list[$_] ),
                                 :right( try $list[$_+1] ) ) );
        }
    #}
    say "Peak: " ~ gather { .take for @peak-array }.Array.raku;
}
