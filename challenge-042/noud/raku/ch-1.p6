# Octal Number System
#
# Write a script to print decimal number 0 to 50 in Octal Number System.
#
# For example:
# Decimal 0 = Octal 0
# Decimal 1 = Octal 1
# Decimal 2 = Octal 2
# Decimal 3 = Octal 3
# Decimal 4 = Octal 4
# Decimal 5 = Octal 5
# Decimal 6 = Octal 6
# Decimal 7 = Octal 7
# Decimal 8 = Octal 10
#
# and so on.

say $_.fmt("Decimal $_ = Octal %o") for ^51;
