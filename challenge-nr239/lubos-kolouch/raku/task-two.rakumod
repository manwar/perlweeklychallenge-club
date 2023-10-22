unit module lubos-kolouch::raku::task-two:ver<0.0.1>:auth<github:lubos-kolouch>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr239/lubos-kolouch/raku/ -- test/challenge-nr239/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr239 -- test/benchmark-scalability.raku --task=task-two --user=lubos-kolouch --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr239; cat /tmp/nr239_task-two.csv

#|[
Individual task description and interesting solution hints ...
]
our sub solution([$allowed, *@strings]) is export {
    my $count = 0;
    
    # Create a hash to store allowed characters
    my %allowed-chars = $allowed.comb.map: { $_ => True };
    
    for @strings -> $str {
        # Check if all characters in the string are in the allowed characters hash
        if all($str.comb.map: { %allowed-chars{$_}:exists }) {
            $count++;
        }
    }
    
    return $count;
}