def nth_root(n: int, k: float) -> float:
    return round(k ** (1/n), 2)

print(nth_root(5, 248832))  # Output: 12.0
print(nth_root(5, 34))  # Output: 2.02

