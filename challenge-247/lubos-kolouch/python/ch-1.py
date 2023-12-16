#!/usr/bin/env python

import random
from typing import Dict, List


def secret_santa(names: list[str]) -> dict[str, str]:
    def extract_family_name(name: str) -> str:
        return name.split()[-1]

    while True:
        shuffled = random.sample(names, len(names))
        assignments = {giver: receiver for giver, receiver in zip(names, shuffled)}
        if all(
            extract_family_name(giver) != extract_family_name(receiver)
            for giver, receiver in assignments.items()
        ):
            return assignments


# Output
names = ["Mr. Wall", "Mrs. Wall", "Mr. Anwar", "Mrs. Anwar", "Mr. Conway", "Mr. Cross"]
assigned = secret_santa(names)

for giver, receiver in assigned.items():
    print(f"{giver} -> {receiver}")
