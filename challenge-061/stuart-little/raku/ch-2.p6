#!/usr/bin/env perl6
use v6;

sub splc($s) {
    (0..255).map({ $s ~~ /^($^a)(.*)/; $/ && ($0,$1)}).grep(* !~~ Nil).map(*.map(*.Str))
}

sub itr1($s) {
    $s.map({ ($_[0..*-2], $_[*-1].&splc) }).map( -> $x {|$x[1].map( -> $y { |$x[0], |$y})})
}

sub iter($s,$n,&itr1) {
    given $n {
	when 0 {$s}
	default { iter($s.&itr1, $n-1,&itr1)}
    }
}

say iter(@*ARGS[0],4,&itr1).grep(! *.[*-1])

# run as <script> <string>
