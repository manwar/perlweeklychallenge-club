#!/usr/bin/env -S rdmd -unittest

import std.conv, std.math;

bool three_power(int n)
{
    foreach (x; 0 .. to!int(sqrt(to!float(n))) + 1)
    {
        int tripple = x ^^ 3;
        if (tripple > n)
        {
            break;
        }
        if (n == tripple)
        {
            return true;
        }
    }

    return false;
}

unittest
{
    assert(three_power(27));
    assert(three_power(0));
    assert(three_power(6) == false);
}

void main()
{
}
