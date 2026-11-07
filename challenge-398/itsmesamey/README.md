# Weekly Challenge 398

Solution by ItsMeSamey. Original Perl code prepared with OpenAI Codex assistance and reviewed by a separate AI agent.

```sh
perl perl/ch-1.pl 18 5 7 11
# 18
perl perl/ch-2.pl ab bc cd zy
# zy
```

Both scripts print one answer and exit 0. Invalid structural input produces a diagnostic on stderr and exit 2. Each supports `--help` and can be loaded with `require` to call the same function used by its CLI.

## Divisible Average

`divisible_average(@decimal_strings)` averages the positive integers divisible by six, using `Math::BigInt` for the divisibility check, sum, count and quotient/remainder. Decimal inputs and the result remain strings, so large integers never pass through floating-point arithmetic. Leading zeros are accepted; signs, zero, fractions and other non-decimal input are rejected.

The verified inputs [9007199254740990,9007199254740996] produce 9007199254740993. That result is 2^53+1, which binary64 cannot represent exactly.

The result is the nearest integer, with exact half ties rounded upward. The task leaves the tie breaker unspecified, so this is a declared convention: [6,6,6,12] returns 8 for its mean of 7.5. No qualifying values returns 0, including an empty input list as a declared extension.

## String Difference

`string_difference(@words)` finds the word whose adjacent-character-difference vector differs from the others. Its domain is at least three equal-length ASCII strings of length at least two, with exactly one exceptional vector. It compares differences directly against reference words instead of constructing full vectors.

Count, ASCII content and every word length are checked before comparison. This validation scans all input characters even if comparison later finds an early outlier. Complete validation of the unique-exception promise is outside the function's contract. Total work is O(NL) in the worst case, and the copied argument list uses O(N) scalar slots. Unicode behavior beyond ASCII is unspecified.

## Reproduce the checks

On Linux with Perl, core `Math::BigInt` and `JSON::PP`, and Python 3.9 or later:

```sh
python3 -I -S -B verification/reproduce.py --output /tmp/weekly398-checks
```

Choose a new output directory. The wrapper runs the frozen 13,146-case exact oracle comparison, then 13 direct CLI checks, retaining raw output and JSON receipts. A complete pass exits 0. See [VERIFICATION.md](VERIFICATION.md) for coverage and runtime requirements.

The tested environment used Perl 5.44.0, Math::BigInt 2.005003, JSON::PP 4.16 and Python 3.14.8. All 13,146 batch cases and 13 CLI checks passed independent retained-result review. The tests establish the stated finite coverage; the algorithms and their input assumptions are described above.

Original code and documentation are MIT licensed. [PROVENANCE.md](PROVENANCE.md) identifies the task and verification sources.
