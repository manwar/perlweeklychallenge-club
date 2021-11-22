#!/usr/bin/python3

# Challenge 016
#
# Task #2
# Write a script to validate a given bitcoin address. Most Bitcoin addresses
# are 34 characters. They consist of random digits and uppercase and lowercase
# letters, with the exception that the uppercase letter "O", uppercase letter "I",
# lowercase letter "l", and the number "0" are never used to prevent visual
# ambiguity. A bitcoin address encodes 25 bytes. The last four bytes are a
# checksum check. They are the first four bytes of a double SHA-256 digest
# of the previous 21 bytes. For more information, please refer wiki page.
# Here are some valid bitcoin addresses:
#
#     1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2
#     3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy

import sys
from cryptoaddress import BitcoinAddress

try:
    bitcoin_address = BitcoinAddress(sys.argv[1], network_type='mainnet')
    print(1)
except ValueError:
    print(0)
