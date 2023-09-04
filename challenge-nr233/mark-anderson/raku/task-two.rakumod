unit module challenge-nr233::mark-anderson::raku::task-two:ver<0.0.1>:auth<mark-anderson@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/mark-anderson/raku/ test/challenge-nr233/raku/task-two.rakutest

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@input) is export {
    flat @input.Bag.sort({ $^a.value cmp $^b.value or $^b.key cmp $^a.key })>>.Bag>>.kxxv
}