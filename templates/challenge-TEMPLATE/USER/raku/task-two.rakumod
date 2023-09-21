unit module {{USER}}::raku::task-two:ver<0.0.1>:auth<{{USER}}@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-{{CHALLENGE}}/{{USER}}/raku/ -- test/challenge-{{CHALLENGE}}/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-{{CHALLENGE}} -- test/benchmark-scalabiity.raku --task=task-two --user={{USER}} --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp {{CHALLENGE}}; cat /tmp/{{CHALLENGE}}_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@input) is export {
    @input».comb.flat».Numeric 
}