#!/usr/bin/env python3
"""Perl Weekly Challenge 031 - Task 2: Dynamic Variable Name.

Create a script to demonstrate creating dynamic variable name,
assign a value to the variable and finally print the variable.
"""

from typing import Any
import unittest


def assign_dynamic_var(
    name: str, value: Any, scope: dict[str, Any] | None = None
) -> Any:
    """Assign a value to a dynamically named variable in the given scope or globals().

    Args:
        name: The name of the variable to set.
        value: The value to assign.
        scope: The dictionary representing namespace/scope (defaults to globals()).

    Returns:
        The assigned value.
    """
    target_scope = globals() if scope is None else scope
    target_scope[name] = value
    return target_scope[name]


class TestDynamicVar(unittest.TestCase):
    """Test suite for dynamic variable assignment."""

    def test_assign_in_custom_scope(self) -> None:
        """Test assigning into a specific dictionary scope."""
        scope: dict[str, Any] = {}
        val = assign_dynamic_var("dyn_var", 42, scope=scope)
        self.assertEqual(val, 42)
        self.assertEqual(scope["dyn_var"], 42)

    def test_assign_in_globals(self) -> None:
        """Test assigning into global namespace."""
        var_name = "test_dynamic_global_var"
        val = assign_dynamic_var(var_name, "hello_world")
        self.assertEqual(val, "hello_world")
        self.assertIn(var_name, globals())
        self.assertEqual(globals()[var_name], "hello_world")
        # Cleanup
        del globals()[var_name]


if __name__ == "__main__":
    unittest.main()
