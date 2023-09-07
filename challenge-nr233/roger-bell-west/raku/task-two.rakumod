unit module challenge-nr233::roger-bell-west::raku::task-two:ver<0.0.1>:auth<roger-bell-west@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr233/roger-bell-west/raku/ test/challenge-nr233/raku/task-two.rakutest

#|[
Individual task description and interesting solution hints ...
]
our sub solution(@al) is export {
    my %ct;
    for @al -> $x {
        %ct{$x}++;
    }
    my %rct;
    for %ct.kv -> $k, $v {
        %rct{$v} ||= [];
        %rct{$v}.push($k);
    }
    my @out;
    for %rct.keys.sort({$^a <=> $^b}) -> $k {
        for %rct{$k}.sort({$^b <=> $^a}) -> $v {
            @out.append($v+0 xx $k);
        }
    }
    return @out.List;
}