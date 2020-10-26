use Test;
plan 7;

my @matrix;

@matrix = < 0 1 0 1 >,
          < 0 0 1 0 >,
          < 1 1 0 1 >,
          < 1 0 0 1 >;

ok square-count(@matrix) == 1, "Example 1";

@matrix = < 1 1 0 1 >,
          < 1 1 0 0 >,
          < 0 1 1 1 >,
          < 1 0 1 1 >;

ok square-count(@matrix) == 4, "Example 2";

@matrix = < 0 1 0 1 >,
          < 1 0 1 0 >,
          < 0 1 0 0 >,
          < 1 0 0 1 >;

ok square-count(@matrix) == 0, "Example 3";

@matrix = < 0 1 0 0 0 1 0 >,
          < 0 0 1 0 1 0 0 >,
          < 0 0 0 0 0 0 0 >,
          < 0 0 1 0 1 0 0 >,
          < 0 1 0 0 0 1 0 >;

ok square-count(@matrix) == 2, "Example 4";
          
@matrix = < 0 0 0 0 >,
          < 0 1 1 0 >,
          < 0 1 1 0 >,
          < 0 1 1 0 >,
          < 0 0 0 0 >;

ok square-count(@matrix) == 2, "Example 5";

@matrix = < 1 1 1 1 >,
          < 1 1 1 1 >,
          < 1 1 1 1 >,
          < 1 1 1 1 >,
          < 1 1 1 1 >;

ok square-count(@matrix) == 20, "Example 6";

@matrix = < 1 1 1 1 1 >,
          < 1 1 1 1 1 >,
          < 1 1 1 1 1 >,
          < 1 1 1 1 1 >;

ok square-count(@matrix) == 20, "Example 7";

sub square-count(@matrix) {
    my $count = 0;

    for ^@matrix.end -> $i {
        my @indices = @matrix[$i].grep(1, :k);

        next unless @indices.elems >= 2;

        for @indices.combinations(2) -> [$h, $t] {
            my $skip = $i + $t - $h;
            $count++ if @matrix[$skip][$h] and @matrix[$skip][$t]; 
        } 
    }

    $count;
}
