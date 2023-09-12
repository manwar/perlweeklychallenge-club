unit module massa::raku::task-two:ver<0.0.1>:auth<massa@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr234/massa/raku/ -- test/challenge-nr234/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr234 -- test/benchmark-scalabiity.raku --task=task-two --user=massa --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr234; cat /tmp/nr234_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@input) is export {
     @input.combinations(3).grep(!*.repeated).elems
}