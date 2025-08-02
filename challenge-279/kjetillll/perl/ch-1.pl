use strict; use warnings; use Test::More tests=>3;

sub sort_letters_by_weight {
    my @letters = @{ shift() };
    my @weights = @{ shift() };

    my %w; @w{@letters} = @weights;

    #do the Schwartzian:        https://en.wikipedia.org/wiki/Schwartzian_transform
    return join '',
    map $$_[0],
    sort{ $$a[1] <=> $$b[1] || $$a[0] cmp $$b[0] }
    map [$_, $w{$_}],
    @letters


    ##this return instead is a lot simpler but could be slower for large inputs
    ##since there would be more hash lookups:
    #return join '', sort{ $w{$a} <=> $w{$b} || $a cmp $b } @letters
}

is sort_letters_by_weight( $$_{letters}, $$_{weights} ), $$_{output} for
  { letters => ['R', 'E', 'P', 'L'],           weights => [3, 2, 1, 4],       output  => 'PERL' },
  { letters => ['A', 'U', 'R', 'K'],           weights => [2, 4, 1, 3],       output  => 'RAKU' },
  { letters => ['O', 'H', 'Y', 'N', 'P', 'T'], weights => [5, 4, 2, 6, 1, 3], output  => 'PYTHON' }
