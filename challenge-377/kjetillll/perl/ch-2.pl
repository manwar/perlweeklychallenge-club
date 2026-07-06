use Algorithm::Combinatorics 'combinations';
    
sub f {
    0 + grep {
        my($a, $b) = @$_;
        $a =~ /^$b/ and $a =~ /$b$/ or
        $b =~ /^$a/ and $b =~ /$a$/
    }
    combinations \@_, 2
}

print pop(@$_) == f( @$_ ) ? "ok\n" : "ERROR\n" for
[ "a", "aba", "ababa", "aa"  => 4 ],
[ "pa", "papa", "ma", "mama" => 2 ],
[ "abao", "ab"               => 0 ],
[ "abab", "abab"             => 1 ],
[ "ab", "abab", "ababab"     => 3 ],
[ "abc", "def", "ghij"       => 0 ],
