"""Tests for task2.py"""
from python.task2 import b_after_a


def test_examples() -> None:
    """Test if function returns correct percentage of character"""
    assert b_after_a("aabb") is True
    assert b_after_a("abab") is False
    assert b_after_a("aaa") is False
    assert b_after_a("bbb") is True
