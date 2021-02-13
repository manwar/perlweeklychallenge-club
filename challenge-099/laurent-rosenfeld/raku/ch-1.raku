use v6;

my $in = "abcde";
my @test-patterns = <a*e a*d ?b*d a*c?e>;
for @test-patterns -> $test {
    say "$test: ", match $test, $in;
}

sub match (Str $pattern, Str $in) {
    my $regex =
        join "", gather {
            take '^';
            for $pattern.comb {
                when '*' { take '.*' }
                when '?' { take '.'  }
                default  { take $_   }
            }
            take '$';
    }
    return  $in ~~ /<$regex>/ ?? 1 !! 0;
}
