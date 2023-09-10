unit module {{USER}}::raku::task-two:ver<0.0.1>:auth<{{USER}}@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-{{TEMPLATE}}/{{USER}}/raku/ -- test/challenge-{{TEMPLATE}}/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-{{TEMPLATE}} -- test/benchmark-scalabiity.raku --task=task-two --user={{USER}} --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp {{TEMPLATE}}; cat /tmp/{{TEMPLATE}}_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution is export {
    @^ns».comb.flat».Numeric 
}