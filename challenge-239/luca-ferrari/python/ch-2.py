#!python

#
# Perl Weekly Challenge 239
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-239/>
#

import sys

# task implementation
def main( argv ):
    allowed = argv[ 0 ]

    for current_word in argv[ 1: ] :
        found = True
        for current_char in list( current_word ):
            found_this_char = False

            for allowed_char in list( allowed ):
                if current_char == allowed_char:
                    found_this_char = True
                    break

            if not found_this_char:
                found = False
                break

        if found:
            print( current_word )



# invoke the main without the command itself
if __name__ == '__main__':
    main( sys.argv[ 1: ] )


