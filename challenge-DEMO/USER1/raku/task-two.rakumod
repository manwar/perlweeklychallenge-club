unit module challenge-DEMO::USER1::raku::task-two:ver<0.0.1>:auth<USER1@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-DEMO/USER1/raku/ test/challenge-DEMO/raku/task-two.rakutest

#|[
Task Description goes here ...
]
our sub solution is export {
    @^ns».comb.flat».Numeric 
}