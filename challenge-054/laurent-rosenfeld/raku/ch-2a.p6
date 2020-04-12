use v6;

my %cache = 2 => [2, 1];

sub collatz_seq (UInt $in) {
    my @result;
    my $n = $in;
    while $n != 1 {
        if %cache{$n} :exists {
            push @result, |@(%cache{$n});
            last;
        } else {
            my $new_n = $n % 2 ?? 3 * $n + 1 !! $n / 2;
            push @result, $new_n;
            %cache{$n} = [$new_n, |%cache{$new_n}]
                if defined (%cache{$new_n}) and $new_n <= 200000;
            $n = $new_n.Int;
        }
    }
    %cache{$in} = @result if $in <= 200000;
    return @result;
}

my @long_seqs;
for 1..1000000 -> $num {
    my $seq = collatz_seq $num;
    push @long_seqs, [ $num, $seq.elems] if $seq.elems > 400;
}
@long_seqs = sort { $^b[1] <=> $^a[1]}, @long_seqs;
say  "$_[0]: $_[1]" for @long_seqs[0..19];
