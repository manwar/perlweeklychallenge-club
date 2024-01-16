#!/usr/bin/env python

from random import sample
import re

def findRecipient(giver, recipients):
    # exclude the giver from the recipient list
    possible_recipients = [
        name for name in recipients if name != giver
    ]

    # if there are no possible recipients, bail early
    if len(recipients) == 0:
        return None

    # split on whitespace and take the last element
    # to get the "family name"
    family_name = re.compile((giver.split())[-1])

    # now, make a potential recipient list
    # excluding family members
    non_family_members = [
        name for name in possible_recipients \
            if not family_name.search(name)
    ]

    # sample() returns a LIST, so just return the first elem
    if len(non_family_members) > 0:
        return sample(non_family_members, 1)[0]
    else:
        return sample(recipients, 1)[0]

def secretSanta(names):
    # let's use a dictionary to hold the giver/recipient
    # pairings
    results = {}
 
    # copy the names into a new list
    available_recipients = names.copy()

    # now go through each of the names and find a
    # recipient for them
    must_redo = False
    for giver in names:
        recipient = findRecipient(giver, available_recipients)
        if recipient is None:
            must_redo = True
        results[giver] = recipient
        available_recipients.remove(recipient)

    if must_redo:
        return secretSanta(names)
    else:
        return results

def comma_join(arr):
    return "',\n                 '".join(arr)

def solution(names):
    print(f"Input: @names = ('{comma_join(names)}')")
    recipients = secretSanta(names)
    print(f'Output:')
    for giver in names:
        print(f"    {giver} -> {recipients[giver]}")

print('Example 1:')
solution(['Mr. Wall', 'Mrs. Wall', 'Mr. Anwar',
          'Mrs. Anwar', 'Mr. Conway', 'Mr. Cross'])

print('\nExample 2:')
solution(['Mr. Wall', 'Mrs. Wall', 'Mr. Anwar'])
