#!/usr/bin/env -S rdmd -unittest
import std.algorithm : map, maxElement;
import std.conv : to;
import std.string : isNumeric;

auto alphanumeric_string_value(string[] alphanumstr)
{
    return alphanumstr.map!(a => isNumeric(a) ? a.to!int : a.length).maxElement;
}

unittest
{
    assert(alphanumeric_string_value(["perl", "2", "000", "python", "r4ku"]) == 6);
    assert(alphanumeric_string_value(["001", "1", "000", "0001"]) == 1);
}

void main()
{
}
