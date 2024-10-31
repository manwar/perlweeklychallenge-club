def is_boomerang(points):
    # Extract coordinates
    (x1, y1), (x2, y2), (x3, y3) = points

    # Check if all points are distinct
    point_set = set()
    point_set.add((x1, y1))
    point_set.add((x2, y2))
    point_set.add((x3, y3))

    if len(point_set) < 3:
        return "false"

    # Calculate the determinant
    determinant = (x2 - x1) * (y3 - y1) - (y2 - y1) * (x3 - x1)

    # If determinant is zero, points are colinear
    if determinant == 0:
        return "false"
    else:
        return "true"


# Test cases
test_cases = [
    {"points": [[1, 1], [2, 3], [3, 2]], "expected": "true"},
    {"points": [[1, 1], [2, 2], [3, 3]], "expected": "false"},
    {"points": [[1, 1], [1, 2], [2, 3]], "expected": "true"},
    {"points": [[1, 1], [1, 2], [1, 3]], "expected": "false"},
    {"points": [[1, 1], [2, 1], [3, 1]], "expected": "false"},
    {"points": [[0, 0], [2, 3], [4, 5]], "expected": "true"},
]

for test in test_cases:
    result = is_boomerang(test["points"])
    print(f"Input: points = {test['points']}")
    print(f"Output: {result}")
    print(f"Expected: {test['expected']}")
    print("-" * 40)
