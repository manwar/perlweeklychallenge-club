use warnings;
use feature 'say';
use Data::Dumper;

sub count_common {
    my (%in1, %in2);
    for my $word (@{$_[0]}) {
        $in1{$word}++;
    }
    for my $word (@{$_[1]}) {
        $in2{$word}++;
    }
    my %unique1 = map { $_ => 1 } grep {$in1{$_} == 1} keys %in1;
    my %unique2 = map { $_ => 1 } grep {$in2{$_} == 1} keys %in2;
    my @intersect;
    for my $word (keys %unique1) {
        push @intersect, $word if exists $unique2{$word};
    }
    return scalar @intersect;
}
my @tests = ( [ [<Perl is my friend>],
               [<Perl and Raku are friend>] ],
             [ [<Perl is my friend>],
               [<Raku is friend of my friend Perl>] ],
             [ [<Perl and Python are very similar>],
               [<Python is top in guest languages>] ],
             [ [<Perl is imperative Lisp is functional>],
               [<Crystal is similar to Ruby>] ]
           );
for my $test (@tests) {
    say  "@{$test->[0]}";
    say  "@{$test->[1]}";
    say count_common $test->[0], $test->[1];
    say "";
}
