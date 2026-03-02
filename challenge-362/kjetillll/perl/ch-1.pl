use strict; use warnings; use v5.10;

sub f1 { join '', map substr( $_[0], $_-1, 1) x $_, 1 .. length( $_[0] ) }

sub f2 { my @c = split'',pop; join '', map $c[$_-1] x $_, 1 .. @c }

sub f3 { my($s, $c) = (@_, 1); $s =~ s/.// ? $& x $c . f3($s, 1+$c) : '' }

sub f4 { $_[0] =~ /./ ? $& x ++$_[1] . f4( $', $_[1] ) : '' }

my @tests = (
  [ "abca"  => "abbcccaaaa"      ],
  [ "xyz"   => "xyyzzz"          ],
  [ "code"  => "coodddeeee"      ],
  [ "hello" => "heelllllllooooo" ],
  [ "a"     => "a"               ],
);
say f1( $$_[0] ) eq $$_[1] ? "ok" : "ERROR" for @tests;
say f2( $$_[0] ) eq $$_[1] ? "ok" : "ERROR" for @tests;
say f3( $$_[0] ) eq $$_[1] ? "ok" : "ERROR" for @tests;
say f4( $$_[0] ) eq $$_[1] ? "ok" : "ERROR" for @tests;

