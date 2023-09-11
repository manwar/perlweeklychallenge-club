unit module bruce-gray::raku::task-two:ver<0.0.1>:auth<bruce-gray@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/bruce-gray/raku/ -- test/challenge-nr233/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr233 -- test/benchmark-scalabiity.raku --task=task-two --user=bruce-gray --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr233; cat /tmp/nr233_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@ns) is export {
    return @ns.Bag.sort({ .value, -.key }).map({ .key xx .value }).flat;
}