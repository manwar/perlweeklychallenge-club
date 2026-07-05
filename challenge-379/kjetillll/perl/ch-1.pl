# https://theweeklychallenge.org/blog/perl-weekly-challenge-379/

sub f { $_[0] =~ s/.// ? f($_[0], $& . $_[1]) : $_[1] }
print f( $$_[0] ) eq $$_[1] ? "ok\n" : "ERROR\n" for
[ ""                         => ""                         ],
[ "reverse the given string" => "gnirts nevig eht esrever" ],
[ "Perl is Awesome"          => "emosewA si lreP"          ],
[ "v1.0.0-Beta!"             => "!ateB-0.0.1v"             ],
[ "racecar"                  => "racecar"                  ],
