#https://theweeklychallenge.org/blog/perl-weekly-challenge-378/

sub f { ( sort pop =~ / ( \d ) (?! .* \1 ) /gx )[ -2 ] // -1 }

print f( $$_[0] ) == $$_[1] ? "ok\n" : "ERROR\n" for
[ "aaaaa77777"         => -1 ],
[ "abcde"              => -1 ],
[ "9zero8eight7seven9" => 8  ],
[ "xyz9876543210"      => 8  ],
[ "4abc4def2ghi8jkl2"  => 4  ],
[ "4a5bc4def2ghi8jkl2" => 5  ],
