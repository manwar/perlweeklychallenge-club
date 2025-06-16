#!/usr/bin/env raku
use Test;

is '2025-02-02'.Date.my-day-of-year, '2025-02-02'.Date.day-of-year; # 33
is '2025-04-10'.Date.my-day-of-year, '2025-04-10'.Date.day-of-year; # 100
is '2025-09-07'.Date.my-day-of-year, '2025-09-07'.Date.day-of-year; # 250

class Date::my-day-of-year
{
    use MONKEY-TYPING;

    augment class Date
    {
        method my-day-of-year
        {
            given self
            {
                $_ - "{.year}-01-01".Date + 1
            }
        }
    }
}
