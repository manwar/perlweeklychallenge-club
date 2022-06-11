use v6.d;

Test((1, 2, 3, 4, 5));
Test((1, 3, 5, 7, 9));

# Make a copy of @n so we dont write over values in the original @n.
sub Test(@n is copy)
{
    say "Input: @n = ({@n.join(', ')})";

    # Use the variable $row to be consistent with the problem description.
    # We don't need a two-dimensional array---all operations ore done on
    # on a one-dimensional array.
    for (1..^@n.elems) -> $row
    {
    	for ($row+1..^@n.elems) -> $col
    	{
    		@n[$col] = @n[$col-1] + @n[$col];
    	}
    }
    say "Output: ", @n.tail;
}
