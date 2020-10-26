use Test;
plan 5;

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

sub square-count(@matrix) {
    my $count = 0;

    for ^@matrix.end -> $i {
        my @indices = @matrix[$i].grep(1, :k);

        next unless @indices.elems >= 2;

        for @indices.combinations(2) -> @c {
            my $skip = @c.tail - @c.head;

            if @matrix[$i+$skip][@c.head] and  
               @matrix[$i+$skip][@c.tail] { 
                   $count++;
            }
        } 
    }

    $count;
}
