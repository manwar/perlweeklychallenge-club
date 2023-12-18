#!/usr/bin/env python3

import sys


def get_person(family_members, exclude=None):
    # Sort the family dict by frequency, largest first
    sorted_surname = sorted(
        family_members,
        key=lambda i: len(family_members[i]),
        reverse=True
    )

    # If we want to exclude a surname, chose the second option if the exclude
    #  name is first, and there is a second option
    if exclude and sorted_surname[0] == exclude and len(sorted_surname) > 1 \
            and len(family_members[sorted_surname[1]]) > 0:
        return sorted_surname[1]

    return sorted_surname[0]


def get_surname(name):
    i = name.rfind(' ')
    if i is not None:
        return name[i+1:]
    else:
        return name


def main(people):
    # Calculate the frequency of each family
    family_members = {}
    for p in people:
        surname = get_surname(p)
        if surname not in family_members:
            family_members[surname] = []
        family_members[surname].append(p)

    # Get the first person, and seed the chain
    current_surname = get_person(family_members)
    first_person = family_members[current_surname].pop()
    chain = [first_person]

    for _ in range(len(people)-1):
        next_surname = get_person(family_members, current_surname)
        chain.append(family_members[next_surname].pop())
        # Repeat for the next person
        current_surname = next_surname

    # The last person gives to the first person
    chain.append(chain[0])

    # Print the results
    for i in range(len(people)):
        print(f'{chain[i]} -> {chain[i+1]}')


if __name__ == '__main__':
    main(sys.argv[1:])
