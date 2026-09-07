# https://theweeklychallenge.org/blog/perl-weekly-challenge-385/

sub f { join(' ', sort "@_" =~ /\w+/g) =~ s/(\b\w+)( \1)+ ?//gr =~ /\w+/g }

print "@{[ f( splice(@$_, 0, 2) ) ]}" eq "@$_" ? "ok\n" : "ERROR\n" for
["apple banana apple",  "banana orange"          => "orange"                     ],
["cat dog",             "bird fish"              => "bird", "cat", "dog", "fish" ],
["the quick brown fox", "the quick"              => "brown", "fox"               ],
["hello",               "hello"                  => ()                           ],
["blue blue red",       "red green green yellow" => "yellow"                     ];
