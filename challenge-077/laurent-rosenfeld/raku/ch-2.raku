use v6;

my @matrix = [ <O O X O> ],
             [ <X O O O> ],
             [ <X O O X> ],
             [ <O X O O> ];

# @matrix = [ 0, 0, 'X'], [ 'X', 0, 0], [ 'X', 0, 0 ];

# @matrix = [<X X X>], [0, 0, 0];

sub check (Int $m, Int $k) {
    for -1, 0, 1 -> $i {
        for -1, 0, 1 ->$j {
            next if $i == 0 and $j == 0;  # the item being verified, bound to be an 'X'
            next if $m+$i < 0 or $k+$j < 0; # out of the matrix
            next unless defined @matrix[$m+$i] and defined @matrix[$m+$i][$k+$j];
            return False if @matrix[$m+$i][$k+$j] eq 'X';
        }
    }
    return True;
}

my @result;
for 0..@matrix[0].end -> $j {
    for 0..@matrix.end -> $i {
        next unless @matrix[$i][$j] eq 'X';
        push @result, [$i, $j] if check $i, $j;
    }
}
say @result.elems > 0 ?? @result !! 0;
