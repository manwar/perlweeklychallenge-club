#!/usr/bin/env perl6

use v6;

class Historic {
    has @!values = [];

    method val($main:) is rw {
        Proxy.new(
            FETCH => method () { $main.get() },
            STORE => method ( $new ) { $main.set($new) }
        );
    }    
    
    method set( $value ) {
        @!values.push( $value );
        $value;
    }

    method get() {
        @!values ?? @!values[*-1] !! Nil;
    }

    method history() {
        return @!values.list;
    }

    method from( *@values ) {
        my $h = Historic.new();
        $h.set($_) for @values;
        $h;
    }
    
    method perl() {
        "Historic.from({self.history.join(",")})";
    }
    
    method gist() {
        self.get().gist();
    }

    method Str() {
        self.val.Str();
    }

    method Numeric() {
        self.val.Numeric();
    }
    
}

multi sub infix:<Δ=> ( Any:U $h is rw, Any $v ) is equiv(&infix:<=>) {
     $h = Historic.new();
     $h.set( $v );
     $h;
}

multi sub infix:<Δ=> (Historic:D $h, Any $a) is equiv(&infix:<=>) {
    $h.set($a);
    return $h;
}

say "Examples";
my $a = Historic.new();
$a.set(5);
$a Δ= 6;

say $a;
say $a.perl;
say $a.history;

my $b Δ= 9;
say $b + 9;
$b Δ= $b + 9;
say $b;
say $b.perl;

my $c = Historic.from(1,2,3,4);
say $c;
say $c.history;

my $d = Historic.new();
$d.val = 5;
say $d;
$d.val = 7;
$d.val += 6;
say $d;
say $d.history;
