use warnings; use strict;

#use Algorithm::Combinatorics 'combinations'; #...or just use this one:

sub comb{my($l,$k,$s)=(@_,0);$k?map{my$i=$_;map[$$l[$i],@$_],comb($l,$k-1,$i+1)}$s..@$l-$k:[]}

sub triplets { comb(\@_,3) }

sub number_of_arithmetic_triplets {
    my($diff,@array) = @_;
    scalar
    grep {
        my($ni, $nj, $nk) = @$_;
        $nj-$ni == $diff and $nk-$nj == $diff
    }
    triplets(@array)
}
        
for my $test (
    {
        input_nums      => [0, 1, 4, 6, 7, 10],
        input_diff      => 3,
        output_expected => 2
    },
    {
        input_nums      => [4, 5, 6, 7, 8, 9],
        input_diff      => 2,
        output_expected => 2
    }
){
    my $output_got = number_of_arithmetic_triplets(
                         $$test{input_diff},
                         @{ $$test{input_nums} }
                     );
    my $result = $output_got == $$test{output_expected}
                             ? 'ok'
                             : 'NOT OK';
    print "$result   expected: $$test{output_expected}   got: $output_got\n";
}
