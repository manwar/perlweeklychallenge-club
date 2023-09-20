unit module massa::raku::task-one:ver<0.0.1>:auth<massa@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr235/massa/raku/ -- test/challenge-nr235/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr235 -- test/benchmark-scalabiity.raku --task=task-one --user=massa --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr235; cat /tmp/nr235_task-one.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@_) is export {
  (^+@_).map({[<] @_[|(^$_), |($_+1 ..^ +@_)]}).any.so
}