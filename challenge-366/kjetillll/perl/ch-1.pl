sub f {
    my $str = pop;
    0 + grep $str =~ /^$_/, @_
}

print pop(@$_) == f(@$_) ? "ok\n" : "ERROR\n" for
[ "a", "ap", "app", "apple", "banana"                    , "apple"   => 4 ],
[ "cat", "dog", "fish"                                   , "bird"    => 0 ],
[ "hello", "he", "hell", "heaven", "he"                  , "hello"   => 4 ],
[ "", "code", "coding", "cod"                            , "coding"  => 3 ],
[ "p", "pr", "pro", "prog", "progr", "progra", "program" , "program" => 7 ],

# https://theweeklychallenge.org/blog/perl-weekly-challenge-366/
