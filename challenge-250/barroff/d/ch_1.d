#!/usr/bin/env -S rdmd -unittest

auto smallest_integer(int[] ints)
{
    foreach (i, x; ints)
    {
        if (x == i % 10)
        {
            return i;
        }
    }

    return -1;
}

unittest
{
    assert(smallest_integer([0, 1, 2]) == 0);
    assert(smallest_integer([4, 3, 2, 1]) == 2);
    assert(smallest_integer([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]) == -1);
}

void main()
{
}
