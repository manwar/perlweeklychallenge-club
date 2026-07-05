# https://theweeklychallenge.org/blog/perl-weekly-challenge-380/

sub f {
    my %count; $count{$_}++ for pop =~ /./g;
    eval join '+', map {
        my $re = $_;
        ( sort {$b<=>$a} map $count{$_}, grep /$re/, keys %count )[0]
    } '[aeiou]', '[^aeiou]';
}

print f( $$_[0] ) == $$_[1] ? "ok\n" : "ERROR\n" for
[ "banana"   => 5 ],
[ "teestett" => 7 ],
[ "aeiouuaa" => 3 ],
[ "rhythm"   => 2 ],
[ "x"        => 1 ],
