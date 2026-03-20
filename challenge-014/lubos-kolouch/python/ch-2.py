#!/usr/bin/env python3
"""
Challenge 014, Task 2: Spelling with US states

Using only the official postal (2-letter) abbreviations for the 50 U.S. states,
find the longest English word that can be spelled.

Author: Lubos Kolouch
"""

import unittest
from typing import Optional

# US State postal abbreviations
US_STATES: set[str] = {
    "AL",
    "AK",
    "AZ",
    "AR",
    "CA",
    "CO",
    "CT",
    "DE",
    "FL",
    "GA",
    "HI",
    "ID",
    "IL",
    "IN",
    "IA",
    "KS",
    "KY",
    "LA",
    "ME",
    "MD",
    "MA",
    "MI",
    "MN",
    "MS",
    "MO",
    "MT",
    "NE",
    "NV",
    "NH",
    "NJ",
    "NM",
    "NY",
    "NC",
    "ND",
    "OH",
    "OK",
    "OR",
    "PA",
    "RI",
    "SC",
    "SD",
    "TN",
    "TX",
    "UT",
    "VT",
    "VA",
    "WA",
    "WV",
    "WI",
    "WY",
}

# Pre-computed mappings for state abbreviations to letters they contain
STATE_TO_LETTERS: dict[str, set[str]] = {}
for state in US_STATES:
    STATE_TO_LETTERS[state] = set(state.lower())


def can_spell_word(word: str, states: Optional[set[str]] = None) -> bool:
    """
    Check if a word can be spelled using US state abbreviations.

    A word can be spelled if we can partition it into valid state abbreviations.
    Each state abbreviation must be used contiguously.

    Args:
        word: The word to check (uppercase)
        states: Optional set of state abbreviations to use (defaults to all)

    Returns:
        True if the word can be spelled, False otherwise

    Examples:
        >>> can_spell_word("PAC")
        True  # PA (Pennsylvania) + C (invalid)
        >>> can_spell_word("PACT")
        True  # PA (Pennsylvania) + CT (Connecticut)
        >>> can_spell_word("WIND")
        True  # WI (Wisconsin) + ND (North Dakota)
    """
    if states is None:
        states = US_STATES

    word = word.upper()
    n = len(word)

    if n == 0:
        return True

    # DP approach: dp[i] = True if word[0:i] can be spelled
    dp = [False] * (n + 1)
    dp[0] = True

    for i in range(1, n + 1):
        for j in range(i):
            if dp[j] and word[j:i] in states:
                dp[i] = True
                break

    return dp[n]


def find_spelling(word: str, states: Optional[set[str]] = None) -> Optional[list[str]]:
    """
    Find the state abbreviations that spell a given word.

    Args:
        word: The word to spell (uppercase)
        states: Optional set of state abbreviations to use

    Returns:
        List of state abbreviations, or None if not possible

    Examples:
        >>> find_spelling("PACT")
        ['PA', 'CT']
        >>> find_spelling("WIND")
        ['WI', 'ND']
    """
    if states is None:
        states = US_STATES

    word = word.upper()
    n = len(word)

    if n == 0:
        return []

    # Store the path to reconstruct the solution
    dp: list[Optional[list[str]]] = [None] * (n + 1)
    dp[0] = []

    for i in range(1, n + 1):
        for j in range(i):
            if dp[j] is not None and word[j:i] in states:
                dp[i] = dp[j] + [word[j:i]]  # type: ignore[union-attr]
                break

    return dp[n]


def spell_word(word: str, states: Optional[set[str]] = None) -> str:
    """
    Spell a word using state abbreviations and return the result.

    Args:
        word: The word to spell
        states: Optional set of state abbreviations

    Returns:
        Formatted string like "PA + CT = PACT" or "Cannot spell"

    Examples:
        >>> spell_word("PACT")
        'PA + CT = PACT'
        >>> spell_word("POTATO")
        'Cannot spell'
    """
    if states is None:
        states = US_STATES

    result = find_spelling(word.upper(), states)

    if result is None:
        return "Cannot spell"

    return " + ".join(result) + " = " + word.upper()


def get_longest_words(words: list[str], states: Optional[set[str]] = None) -> list[str]:
    """
    Find all longest words that can be spelled.

    Args:
        words: List of words to check
        states: Optional set of state abbreviations

    Returns:
        List of longest spellable words

    Examples:
        >>> get_longest_words(["CAT", "DOG", "PACT", "WIND", "MEAL"])
        ['PACT', 'WIND', 'MEAL']
    """
    if states is None:
        states = US_STATES

    spellable = [w.upper() for w in words if can_spell_word(w, states)]

    if not spellable:
        return []

    max_len = max(len(w) for w in spellable)
    return [w for w in spellable if len(w) == max_len]


def main() -> None:
    """Main function to demonstrate the solution."""
    test_words = ["PACT", "WIND", "MEAL", "CALAMARI", "CAT", "DOG"]

    print("Examples from the challenge:")
    print("  Pennsylvania + Connecticut = PACT")
    print("  Wisconsin + North Dakota = WIND")
    print("  Maine + Alabama = MEAL")

    print("\nTesting these words:")
    for word in test_words:
        print(f"  {spell_word(word)}")

    # Example longest word search
    sample_words = [
        "CAT",
        "DOG",
        "PACT",
        "WIND",
        "MEAL",
        "CALAMARI",
        "Alabama",
        "Alaska",
        "Arizona",
        "Arkansas",
        "California",
    ]
    print(f"\nLongest word(s): {get_longest_words(sample_words)}")


if __name__ == "__main__":
    main()


class TestUSStateSpelling(unittest.TestCase):
    """Unit tests for US state spelling."""

    def test_can_spell_pact(self):
        """Test spelling PACT."""
        self.assertTrue(can_spell_word("PACT"))

    def test_can_spell_wind(self):
        """Test spelling WIND."""
        self.assertTrue(can_spell_word("WIND"))

    def test_can_spell_meal(self):
        """Test spelling MEAL."""
        self.assertTrue(can_spell_word("MEAL"))

    def test_can_spell_calamari(self):
        """Test spelling CALAMARI."""
        self.assertTrue(can_spell_word("CALAMARI"))

    def test_cannot_spell_invalid(self):
        """Test cannot spell invalid word."""
        self.assertFalse(can_spell_word("XYZ"))

    def test_find_spelling_pact(self):
        """Test finding spelling for PACT."""
        result = find_spelling("PACT")
        self.assertIsNotNone(result)
        self.assertEqual(result, ["PA", "CT"])

    def test_find_spelling_wind(self):
        """Test finding spelling for WIND."""
        result = find_spelling("WIND")
        self.assertIsNotNone(result)
        self.assertEqual(result, ["WI", "ND"])

    def test_find_spelling_meal(self):
        """Test finding spelling for MEAL."""
        result = find_spelling("MEAL")
        self.assertIsNotNone(result)
        self.assertEqual(result, ["ME", "AL"])

    def test_find_spelling_calamari(self):
        """Test finding spelling for CALAMARI."""
        result = find_spelling("CALAMARI")
        self.assertIsNotNone(result)
        # CA + LA + MA + RI = CALAMARI
        self.assertEqual(result, ["CA", "LA", "MA", "RI"])

    def test_spell_word_pact(self):
        """Test spell_word function for PACT."""
        self.assertEqual(spell_word("PACT"), "PA + CT = PACT")

    def test_spell_word_invalid(self):
        """Test spell_word for invalid word."""
        self.assertEqual(spell_word("XYZ"), "Cannot spell")

    def test_empty_word(self):
        """Test empty word."""
        self.assertTrue(can_spell_word(""))
        self.assertEqual(find_spelling(""), [])

    def test_single_letter(self):
        """Test single letter words."""
        # Single letters are not valid state codes
        self.assertFalse(can_spell_word("A"))
        self.assertFalse(can_spell_word("B"))

    def test_get_longest_words(self):
        """Test getting longest words."""
        words = ["CAT", "DOG", "PACT", "WIND", "MEAL", "CALAMARI"]
        result = get_longest_words(words)
        self.assertIn("CALAMARI", result)

    def test_us_states_all_valid(self):
        """Test that all 50 states are recognized."""
        self.assertEqual(len(US_STATES), 50)
        # Check some key states
        self.assertIn("PA", US_STATES)  # Pennsylvania
        self.assertIn("CT", US_STATES)  # Connecticut
        self.assertIn("WI", US_STATES)  # Wisconsin
        self.assertIn("ND", US_STATES)  # North Dakota


if __name__ == "__main__":
    unittest.main()
