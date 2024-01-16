#! /usr/bin/python3

def secretsanta(name):
  family = []
  for n in name:
    surname = n.split(" ")[-1]
    family.append(surname)
  receivers = set(range(len(name)))
  gifting = []
  for giver in range(len(name)):
    done = False
    r = 0
    for recipient in receivers:
      if family[giver] != family[recipient]:
        r = recipient
        done = True
        break
    if not done:
      for recipient in receivers:
        if recipient != giver:
          r = recipient
          break
    receivers.discard(r)
    gifting.append([name[giver], name[r]])
  for p in gifting:
    print(p[0] + " -> " + p[1])
  print("")
  return True

import unittest

class TestSecretsanta(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(secretsanta(["Mr. Wall", "Mrs. Wall", "Mr. Anwar", "Mrs. Anwar", "Mr. Conway", "Mr. Cross"]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(secretsanta(["Mr. Wall", "Mrs. Wall", "Mr. Anwar"]), True, 'example 2')

unittest.main()
