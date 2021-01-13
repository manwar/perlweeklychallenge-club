#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

our $D = False;
class LinkedList { ... }
class Iter {
    trusts LinkedList;
    has $.value is rw;
    has Iter $.next;

    method is-last () {  $!next.defined.not }

    method !set-next     ( Iter $another ) { $!next = $another }
    method !reset-next   () {  $!next = Nil }
    method !replace-next ( Iter:D $another ) {
        my $prev-one = $!next;
        $!next = $another;
        return $prev-one;
    }
}

class LinkedList {
    has Iter $!core;
    has Str  $.sep = '→';

    method begin () returns Iter { $!core.next }

    submethod BUILD {
        $!core = Iter.new( :value( 'DO NOT REMOVE' ) );
    }

    method count () {
        my $count = 0;
        loop ( my $itr = self.begin; defined $itr; $itr = $itr.next ) {
            ++$count
        }
        return $count;
    }

    # push back after an iterator and
    # return another iterator which has moved forward
    multi method push ( Any:D $that, Iter:D :$after ) {
        my $itr = $that.isa( Iter ) ?? $that !! Iter.new( :value($that) );
        say "push the node has (value: {$itr.value}) after node (value: {$after.value})" if $D;

        $itr!Iter::set-next( $after!Iter::replace-next( $itr ) );
        return $itr;
    }

    # push in the end of the list
    multi method push ( Any:D  $that ) returns Iter {
        say "push in the end" if $D;
        my $itr = $!core;
        while $itr.next.defined { $itr = $itr.next }

        my $node = $that.isa( Iter ) ?? $that !! Iter.new( :value( $that ) );
        print "  -> " if $D;
        return self.push( $node, :after($itr) );
    }

    multi method push( # or unshift
        Any:D $that, Int:D :$at is copy where * < self.count ) returns Iter {
        #             `-> Int:D needed not to be confused with
        #                                  'multi method push ( Any:D $that )'
        my $itr = $!core;
        while ( $at-- ) { $itr = $itr.next }
        return self.push( $that, :after($itr) );
    }

    multi method pop ( Iter:D :$after ) returns Iter {
        my $go = $after.next;
        if $go.defined {
            $after!Iter::set-next( $go.next );
            $go!Iter::reset-next();
        }
        return $go;
    }
    multi method pop ( Int:D :$at where * < self.count ) returns Iter {
        my $itr = $!core;
        for ^$at { $itr = $itr.next }
        say "pop after node (value:  {$itr.value})" if $D;
        return self.pop( :after($itr) );
    }

    method say-values ( Str :$prompt? ) {
        if $prompt.defined {
            print( $prompt );
        }
        my $itr = self.begin;
        $itr.value.print if $itr.defined;
        loop ( $itr = $itr.next ; $itr.defined ; $itr = $itr.next ) {
            print( " $!sep " ~ $itr.value );
        }
        say "";
    }

};

sub MAIN ( Bool :debug($d) ) {
    $D = $d;
    my $List = LinkedList.new;

    for 1 .. 5 -> $num { $List.push( $num ) }
    for 1 .. 6 -> $N {
        $List.say-values( :prompt( "Given List : " ) );

        my $I = $List.count - $N;
        $I = 0 if $I < 0; # given constraints

        my $itr = $List.pop( :at($I) );
        $List.say-values( :prompt("When \$N = $N\nOutput: " ) );
        $List.push( $itr, :at($I) );
    }
}
