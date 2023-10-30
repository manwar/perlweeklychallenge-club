#!/usr/bin/env python3

import sys


def main(notes):
    # Store what is in the wallet, key is the dollar value, value is the
    #  number of notes we have
    wallet = {}

    for customer_note in notes:
        # Add the amount the person has given us
        wallet[customer_note] = wallet.get(customer_note, 0) + 1

        if customer_note == 5:
            # No change required :)
            continue

        change = customer_note - 5

        # We try the bigger notes first
        for wallet_note in sorted(wallet, reverse=True):
            note_count = min(wallet[wallet_note], change // wallet_note)
            if note_count > 0:
                # Take the note from the wallet, and reduce the change still
                #  to give
                wallet[wallet_note] -= note_count
                change -= wallet_note * note_count

                if change == 0:
                    break
        else:
            print('false')
            return

    print('true')


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
