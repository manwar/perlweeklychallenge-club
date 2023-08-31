unit module challenge-{{TEMPLATE}}::{{USER}}::raku::task-two:ver<0.0.1>:auth<{{USER}}@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-{{TEMPLATE}}/{{USER}}/raku/ test/challenge-{{TEMPLATE}}/raku/task-two.rakutest

#|[
Individual task description and interesting solution hints ...
]
our sub solution is export {
    @^ns».comb.flat».Numeric 
}