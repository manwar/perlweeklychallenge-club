#!/usr/bin/env python3

import re

def test_format_date():
    examples = [
        ["1st Jan 2025",  "2025-01-01"],
        ["22nd Feb 2025", "2025-02-22"],
        ["15th Apr 2025", "2025-04-15"],
        ["23rd Oct 2025", "2025-10-23"],
        ["31st Dec 2025", "2025-12-31"],
    ]

    for input_str, expected in examples:
        result = format_date(input_str)
        assert result == expected, f"Expected {expected}, got {result} for input {input_str}"
    print("All tests passed!")

def format_date(date_str):
    match = re.search(r'(\d+)\w{2} (\w{3}) (\d+)', date_str)
    if match:
        day, month, year = match.groups()
        month_num = 1 + "JanFebMarAprMayJunJulAugSepOctNovDec".index(month) // 3
        return f"{year}-{month_num:02d}-{int(day):02d}"
    return ""

if __name__ == "__main__":
    test_format_date()
