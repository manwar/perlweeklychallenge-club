# Task 2 of the Weekly Challenge 340
# https://theweeklychallenge.org/blog/perl-weekly-challenge-340/#TASK2

say is-increasing('The cat has 3 kittens 7 toys 10 beds'); # True
say is-increasing('Alice bought 5 apples 2 oranges 9 bananas'); # False
say is-increasing('I ran 1 mile 2 days 3 weeks 4 months'); # True
say is-increasing('Bob has 10 cars 10 bikes'); # False
say is-increasing('Zero is 0 one is 1 two is 2'); # True

sub is-increasing($str) {
    [<] $str.comb(/\d+/)
}
