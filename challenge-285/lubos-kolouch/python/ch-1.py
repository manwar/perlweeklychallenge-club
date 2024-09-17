from typing import List
import unittest


def find_destination(routes: List[List[str]]) -> str:
    """
    Finds the destination with no further outgoing connection from a given list of routes.

    Each route is represented as a list containing a source and a destination city.

    Args:
        routes (List[List[str]]): A list of routes.

    Returns:
        str: The destination city with no outgoing connections.

    """
    sources = set()
    destinations = set()

    for route in routes:
        source, destination = route
        sources.add(source)
        destinations.add(destination)

    no_outgoing = destinations - sources

    if no_outgoing:
        # Assuming there is only one such city
        return no_outgoing.pop()
    else:
        return None  # In case there is no such city


# Unit Tests
class TestNoConnection(unittest.TestCase):

    def test_example1(self):
        routes = [["B", "C"], ["D", "B"], ["C", "A"]]
        self.assertEqual(find_destination(routes), "A", 'Example 1')

    def test_example2(self):
        routes = [["A", "Z"]]
        self.assertEqual(find_destination(routes), "Z", 'Example 2')

    def test_no_destination(self):
        routes = [["A", "B"], ["B", "A"]]
        self.assertIsNone(find_destination(routes), 'No unique destination')


if __name__ == "__main__":
    unittest.main()
