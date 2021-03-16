#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py
#

tokens   = 12
max_take =  3


while tokens > 0:
    prompt = "How many tokens do you take? ({:2d} token{:s} are left) " . \
              format (tokens, "" if tokens == 1 else "s")
    take = input (prompt)
    if take . isnumeric ():
        take = int (take)
        if 1 <= take <= max_take:
            takes = max_take + 1 - take
            print ("Computer takes {:d} token{:s}" . \
                    format (takes, "" if takes == 1 else "s"))
            tokens = tokens - (max_take + 1)


print ("Computer wins")
