# Test: perl6 ch-1.p6 "[2,7], [3,9], [10,12], [15,19], [18,22]"

sub MAIN(Str $lists) {
    my @values =
        $lists.subst(/<[\s\[\]]>/, '', :g).split(',')>>.Int;
    my $i = 0;

    # Loop through the list items
    while ($i < @values.elems - 3) {
        # Compare the last element of the list to the
        # first element of the next list
        if ( @values[$i+1] >= @values[$i+2] &&
             @values[$i]   <= @values[$i+3] ) {
            # Create new list indexes
            my @new_list = (
                min(@values[$i], @values[$i+2]),
                max(@values[$i+1], @values[$i+3])
            );
            @values.splice($i, 4, @new_list);
        } else {
            $i = $i + 2;
        }
    }

    # Print the values
    $i = 0;
    my @v_string;
    while ($i < @values) {
        @v_string.push(
            '[' ~ @values[$i++] ~ ', ' ~
                  @values[$i++] ~ "]"
        );
    }
    say join ', ', @v_string;
}
