# https://theweeklychallenge.org/blog/perl-weekly-challenge-375/

sub f {
    my %tally;
    $tally{ $_ } .= 1 for @{ $_[0] };
    $tally{ $_ } .= 2 for @{ $_[1] };
    0 + grep /^12$/, values %tally
}

print pop( @$_ ) == f( @$_ ) ? "ok\n" : "ERROR\n" for
[ ["apple", "banana", "cherry"],
  ["banana", "cherry", "date"]    => 2 ],

[ ["a", "ab", "abc"],
  ["a", "a", "ab", "abc"]         => 2 ],

[ ["orange", "lemon"],
  ["grape", "melon"]              => 0 ],

[ ["test", "test", "demo"],
  ["test", "demo", "demo"]        => 0 ],

[ ["Hello", "world"],
  ["hello", "world"]              => 1 ],
