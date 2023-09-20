unit module massa::raku::task-two:ver<0.0.1>:auth<massa@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr235/massa/raku/ -- test/challenge-nr235/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr235 -- test/benchmark-scalabiity.raku --task=task-two --user=massa --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr235; cat /tmp/nr235_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@_) is export {
  @_.map(* || |(0, 0)).head: +@_
}