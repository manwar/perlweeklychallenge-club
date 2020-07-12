#!/usr/bin/env perl6
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

our $SeparatorStr = '';
sub find-seprator-from-str ( Str $line ) {
    # finding separator
    my @words = $line.split( /<space>/ );
    my %words-score;

    my $max-checking = 20;
    for @words -> $w {
        if $w (elem) qw"-> => →" {
            %words-score{$w} += 5;
        }
        else {
            ++%words-score{$w};
        }
    }
    return $SeparatorStr = reduce { %words-score{$^a} > %words-score{$^b}
                               ?? $^a !! $^b }, %words-score.keys;
}

class LinkedList { ... }
class Iter {
    trusts LinkedList;
    has $.value;
    has Iter $!next;

    method clone () {
        my $cloned = Iter.new( :$.value );
        $cloned!set-next( $!next );
        return $cloned;
    }

    submethod BUILD ( Any:D :$value ) {
        $!value = $value;
    }

    method next () { $!next }

    method is-last () {  $!next.defined.not }
    method set-value  ( Any:D $value ) {
        $.value = $value;
    }

    method !set-next     ( Iter $another ) { $!next = $another }
    method !reset-next   () {  $!next = Nil }
    method !replace-next ( Iter:D $another ) {
        my $prev-one = $!next;
        $!next = $another;
        return $prev-one;
    }
}

class LinkedList {
    has Iter $!first;

    method front () { return $!first }
    method count () {
        my $count = 0;
        loop ( my $itr = $!first; defined $itr; $itr = $itr.next ) {
            ++$count
        }
        return $count;
    }

    # push back after an iterator and return another iterator moved forward
    multi method push-back (
        Iter:D :$after,
        Iter:D :$node
    ) returns Iter {
        $node!Iter::set-next( $after!Iter::replace-next( $node ) );
        return $node;
    }
    multi method push-back (
        Iter:D :$after where { $after.next.defined.not },
        Any:D :$value
    ) returns Iter {
        my $new = Iter.new( :$value );
        $new!Iter::set-next( $after!Iter::replace-next( $new ) );
        return $new;
    }

    multi method push-back ( Iter:U :$after, Any:D :$value
                      ) returns Iter {  return $!first = Iter.new( :$value ) }
    multi method pop-back (
        Iter:U :$after ) returns Iter { return Nil }
    multi method pop-back (
        Iter:D :$after ) returns Iter {
        my $go = $after.next;
        if $go.defined {
            $after!Iter::set-next( $go.next );
            $go!Iter::reset-next();
        }
        return $go;
    }

    method print-values ( Str :$prompt ) {
        if $prompt.defined {
            $*ERR.print( $prompt );
        }
        my $itr = $!first;
        $itr.value.print;
        loop ( $itr = $itr.next ; ; $itr = $itr.next ) {
            print( " {$SeparatorStr} " ~ $itr.value );
            last if $itr.is-last;
        }
        say "";
    }

    method move-as-mentioned ( Int :$count-if-known ) {
        my $left-pos = 0;
        my Iter $li = self.front; # left iterator

        my $count = $count-if-known // self.count;
        loop ( my $round = ( $count * 0.5 ).floor; $round > 0; --$round ) {
            my $ri2 = $li; # ri2: 2nd last iterator from right
            my $n-repeat = $count -1 - $left-pos;
            while ( --$n-repeat > 0 ) { $ri2 = $ri2.next; }
            my Iter $ri = self.pop-back( :after( $ri2 ) );
            self.push-back( :after($li), :node($ri) );
            $li = $li.next.next;

            $left-pos += 2;
        }
    }
};


sub MAIN (
    Bool :$stdin = False              #= read linked list from stdin
) {
    my $example-str = "1  →  2 →  3 →  4 →  5 →  6 →  7";
    my $input = "";

    if $stdin {
        $*ERR.print:
        "Default: $example-str\n"
            ~ "please input a linked list like above"
            ~ " or press <enter> to use default values..\n"
            ~ "Input: ";
        $input = prompt();
    }
    $input //= $example-str;

    my $sep = find-seprator-from-str( $input );

    my @given-list = $input.split( / <space>* $sep <space>* / );
    my $List = LinkedList.new;

    my $itr = $List.front;
    for @given-list -> $value {
        $itr = $List.push-back( :after($itr), :$value );
    }

    $List.print-values( :prompt("Input:\n") );
    $List.move-as-mentioned();
    $List.print-values( :prompt("Output:\n" ) );
}
