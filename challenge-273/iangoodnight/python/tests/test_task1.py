"""Tests for task1.py"""
from python.task1 import percentage_of_character


def test_examples() -> None:
    """Test if function returns correct percentage of character"""
    assert percentage_of_character("perl", "e") == 25
    assert percentage_of_character("java", "a") == 50
    assert percentage_of_character("python", "m") == 0
    assert percentage_of_character("ada", "a") == 67
    assert percentage_of_character("ballerina", "l") == 22
    assert percentage_of_character("analitik", "k") == 13


def test_empty_string() -> None:
    """Test if function returns 0 for empty string"""
    assert percentage_of_character("", "a") == 0


def test_empty_character() -> None:
    """Test if function returns 0 for empty character"""
    assert percentage_of_character("python", "") == 0
