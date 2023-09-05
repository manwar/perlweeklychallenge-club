unit module challenge-nr233::ash::raku::task-two:ver<0.0.1>:auth<ash@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/ash/raku/ test/challenge-nr233/raku/task-two.rakutest

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@arr) is export {
    my %freq;
    %freq{$_}++ for @arr;

    my @sorted = @arr.sort: {
        %freq{$^a} <=> %freq{$^b} ||
        $^b <=> $^a
    };
    return @sorted;
}