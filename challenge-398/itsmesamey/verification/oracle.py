"""Independent exact oracles and finite frozen cases for Weekly Challenge 398.

Source prepared before candidate inspection. Importing defines functions only.
The assigned runtime owner may call iter_cases after release. No network or
candidate code is imported or executed here.
"""

from collections import Counter
from fractions import Fraction
from itertools import product
import re

CONTRACT_SHA256 = "74ea63ccca34996fd6d638dd3c7f529c2a3d942c33e17079507332c31549eefd"
SMALL_VALUES = (1, 2, 3, 6, 12, 18)
EXPECTED_SMALL_ARRAYS = 9330
EXPECTED_TRIPLES_BY_LENGTH = {2: 378, 3: 3384}

OFFICIAL_1 = (
    ((18, 5, 7, 11), "18"),
    ((6, 12, 18, 24, 30, 40), "18"),
    ((3, 9, 15, 21, 27), "0"),
    ((6, 12, 14, 20), "9"),
    ((6, 6, 6, 12, 12), "8"),
)
OFFICIAL_2 = (
    (("ab", "bc", "cd", "zy"), "zy"),
    (("cba", "fed", "azy"), "azy"),
    (("pop", "ada", "beb", "cfc"), "pop"),
    (("aaaa", "zzzz", "mmmm", "aaba"), "aaba"),
    (("aceg", "bdfh", "cegi", "azbz"), "azbz"),
)


def average_oracle(decimal_strings):
    """Exact nearest-integer set and the separately declared ties-up value."""
    values = []
    for text in decimal_strings:
        if not isinstance(text, str) or re.fullmatch(r"[0-9]+", text) is None:
            raise ValueError("Oracle requires decimal strings")
        value = int(text)
        if value <= 0:
            raise ValueError("Oracle requires positive integers")
        values.append(value)
    selected = [value for value in values if value % 2 == 0 and value % 3 == 0]
    if not selected:
        return {"nearest": ["0"], "declared_output": "0"}
    mean = Fraction(sum(selected), len(selected))
    lower = mean.numerator // mean.denominator
    choices = (lower, lower + 1)
    distances = tuple(abs(mean - choice) for choice in choices)
    best_distance = min(distances)
    nearest = [
        choice
        for choice, distance in zip(choices, distances)
        if distance == best_distance
    ]
    return {
        "nearest": [str(value) for value in nearest],
        "declared_output": str(max(nearest)),
    }


def difference_signature(word):
    """Full adjacent-codepoint tuple, independent of reference-word shortcuts."""
    return tuple(ord(right) - ord(left) for left, right in zip(word, word[1:]))


def string_oracle(words):
    """Exact grouped signature oracle for the promised unique-minority domain."""
    if len(words) < 3:
        raise ValueError("At least three words required")
    if any(not isinstance(word, str) or not word.isascii() for word in words):
        raise ValueError("This frozen oracle domain is ASCII")
    if len(words[0]) < 2 or any(len(word) != len(words[0]) for word in words):
        raise ValueError("Equal lengths of at least two required")
    signatures = [difference_signature(word) for word in words]
    groups = Counter(signatures)
    if len(groups) != 2 or sorted(groups.values()) != [1, len(words) - 1]:
        raise ValueError("Unique minority promise does not hold")
    minority = next(signature for signature, count in groups.items() if count == 1)
    return words[signatures.index(minority)]


def task1_case(case_id, values, scope):
    """Build a decimal-string fixture using the exact mean oracle."""
    data = [str(value) for value in values]
    return {
        "id": case_id,
        "task": 1,
        "input": data,
        "scope": scope,
        "expected": average_oracle(data),
    }


def task2_case(case_id, words, scope):
    """Build a word fixture using the independent grouping oracle."""
    data = list(words)
    return {
        "id": case_id,
        "task": 2,
        "input": data,
        "scope": scope,
        "expected": {"output": string_oracle(data)},
    }


def iter_cases():
    """Yield the sealed finite batch in deterministic order; never run Perl."""
    for number, (values, expected) in enumerate(OFFICIAL_1, 1):
        case = task1_case(f"official-1-{number}", values, "official_example")
        if case["expected"]["declared_output"] != expected:
            raise AssertionError("Official task1 transcription/oracle mismatch")
        yield case
    for number, (words, expected) in enumerate(OFFICIAL_2, 1):
        case = task2_case(f"official-2-{number}", words, "official_example")
        if case["expected"]["output"] != expected:
            raise AssertionError("Official task2 transcription/oracle mismatch")
        yield case

    small_count = 0
    for size in range(1, 6):
        for number, values in enumerate(product(SMALL_VALUES, repeat=size)):
            yield task1_case(
                f"small-1-n{size}-{number:04d}", values, "official_core_exhaustive"
            )
            small_count += 1
    if small_count != EXPECTED_SMALL_ARRAYS:
        raise AssertionError("Small-array enumeration changed")

    for size in (2, 3):
        words = tuple("".join(chars) for chars in product("abc", repeat=size))
        count = 0
        for indices in product(range(len(words)), repeat=3):
            triple = tuple(words[index] for index in indices)
            signatures = [difference_signature(word) for word in triple]
            groups = Counter(signatures)
            if len(groups) != 2 or sorted(groups.values()) != [1, 2]:
                continue
            suffix = "-".join(f"{index:02d}" for index in indices)
            yield task2_case(
                f"triple-2-l{size}-{suffix}", triple, "official_core_exhaustive"
            )
            count += 1
        if count != EXPECTED_TRIPLES_BY_LENGTH[size]:
            raise AssertionError("Valid-triple enumeration changed")

    average_edges = (
        ("tie", (6, 6, 6, 12)),
        ("below-half", (6, 6, 6, 6, 12)),
        ("above-half", (6, 12, 12, 12, 12)),
        ("exact-integer", (6, 12)),
        ("no-qualifier", (1, 2, 3, 5)),
    )
    for name, values in average_edges:
        yield task1_case("edge-1-" + name, values, "official_core_fixed")

    # Fixed definitions, chosen before candidate inspection or any runtime.
    # All input transport is decimal text, including values above native limits.
    base100 = 6 * 10**99
    huge_cases = (
        ("binary64-midpoint", (2**53 - 2, 2**53 + 4)),
        ("signed64-sum", (2**63 - 2, 2**63 - 2)),
        ("signed64-straddle", (2**63 - 2, 2**63 + 4)),
        ("unsigned64-straddle", (2**64 - 4, 2**64 + 2)),
        ("100digit-midpoint", (base100, base100 + 6)),
        ("100digit-no-qualifier", (base100 + 1, base100 + 5)),
        ("100digit-tie", (base100, base100, base100, base100 + 6)),
        ("100digit-below-half", (base100, base100, base100, base100, base100 + 6)),
        (
            "100digit-above-half",
            (base100, base100 + 6, base100 + 6, base100 + 6, base100 + 6),
        ),
        ("100digit-duplicate", (base100 + 6, base100 + 6, base100 + 6)),
    )
    for name, values in huge_cases:
        yield task1_case("huge-1-" + name, values, "official_core_precision")

    fixed_words = (
        ("outlier-first", ("ace", "abc", "bcd")),
        ("outlier-middle", ("abc", "ace", "bcd")),
        ("outlier-last", ("abc", "bcd", "ace")),
        ("five-words", ("ace", "bdf", "ceg", "dfh", "zyx")),
        ("negative-differences", ("cba", "fed", "zyx", "abc")),
        ("duplicate-common", ("abc", "abc", "ace")),
    )
    for name, words in fixed_words:
        yield task2_case("edge-2-" + name, words, "official_core_fixed")
    for position in range(3):
        words = ["a" * 128, "z" * 128]
        words.insert(position, "a" * 127 + "b")
        yield task2_case(f"long-2-pos{position}", words, "official_core_fixed")
    for position in (0, 50, 100):
        words = ["a" * 64] * 100
        words.insert(position, "a" * 63 + "b")
        yield task2_case(f"group101-2-pos{position}", words, "official_core_fixed")

    # Declared extensions are reported separately, never as official rules.
    yield task1_case("extension-1-empty", (), "declared_extension")
    yield task1_case(
        "extension-1-leading-zero", ("0006", "0012", "0001"), "declared_extension"
    )
    yield task2_case(
        "extension-2-ascii-punctuation", ('!"#', '"#$', "ace"), "declared_extension"
    )
    yield task2_case(
        "extension-2-ascii-space", (" !", "AB", "zy"), "declared_extension"
    )

    invalids = (
        ("invalid-1-zero", 1, ["0"]),
        ("invalid-1-negative", 1, ["-6"]),
        ("invalid-1-fraction", 1, ["6.0"]),
        ("invalid-1-nonnumeric", 1, ["six"]),
        ("invalid-1-undefined", 1, [None]),
        ("invalid-1-reference", 1, [["6"]]),
        ("invalid-1-nonascii-decimal", 1, ["\u0666"]),
        ("invalid-2-short-count", 2, ["ab", "bc"]),
        ("invalid-2-unequal-length", 2, ["ab", "bcd", "zy"]),
        ("invalid-2-short-word", 2, ["a", "b", "c"]),
        ("invalid-2-undefined", 2, ["ab", "bc", None]),
        ("invalid-2-reference", 2, ["ab", "bc", ["zy"]]),
        ("invalid-2-nonascii", 2, ["ab", "bc", "\u00e9z"]),
    )
    for case_id, task, data in invalids:
        yield {
            "id": case_id,
            "task": task,
            "input": data,
            "scope": "declared_structural_rejection",
            "expected": {"error": True},
        }
