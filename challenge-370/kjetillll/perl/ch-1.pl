use List::Util;

sub f {
    my( $paragraph, $dummy, %banned ) = map { lc() => 1 } @_;
    my %freq;
    $freq{ $_ } += !$banned{ $_ } for $paragraph =~ /\w+/g;
    List::Util::reduce { $freq{ $b } > $freq{ $a } ? $b : $a } keys %freq;
}

print pop(@$_) eq f(@$_) ? "ok\n" : "ERROR\n" for
[ "Bob hit a ball, the hit BALL flew far after it was hit.",      "hit"           => "ball"   ],
[ "Apple? apple! Apple, pear, orange, pear, apple, orange.",      "apple", "pear" => "orange" ],
[ "A. a, a! A. B. b. b.",                                         "b"             => "a"      ],
[ "Ball.ball,ball:apple!apple.banana",                            "ball"          => "apple"  ],
[ "The dog chased the cat, but the dog was faster than the cat.", "the", "dog"    => "cat"    ],

# https://theweeklychallenge.org/blog/perl-weekly-challenge-370/
