# Task 2 of the Weekly Challenge 385
# https://theweeklychallenge.org/blog/perl-weekly-challenge-385/#TASK2

my @cases = 
    "()()()",
    "(((())))",
    "(()())(())",
    "()((()))()",
    "(()(()))(()())";
    

grammar t385 {
    rule TOP { <elementary>+  }
    rule elementary { '(' <content> ')' }
    rule content { <elementary>* }
}

for @cases -> $str {
    t385.parse($str)<elementary>.map(*<content>).join.say
}
