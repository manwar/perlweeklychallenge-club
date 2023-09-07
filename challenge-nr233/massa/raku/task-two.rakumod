unit module challenge-nr233::massa::raku::task-two:ver<0.0.1>:auth<massa@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/massa/raku/ test/challenge-nr233/raku/task-two.rakutest

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@input) is export {
    my $frequencies = @input.Bag;
    @input.sort: { $frequencies{$^a} <=> $frequencies{$^b} || $^b <=> $^a }
}