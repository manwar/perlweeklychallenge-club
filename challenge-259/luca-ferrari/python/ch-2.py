#!python

#
# Perl Weekly Challenge 259
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-259>
#

import sys

# task implementation
# the return value will be printed
def task_2( args ):
    line = args[ 0 ]

    parsed = {}
    id = ''
    key = ''
    value = ''
    is_value = False
    is_key  = False

    for c in line:
        if c == '{' :
            continue
        elif c == '%':
            continue
        elif c == '}':
            return parsed
        elif c == ' ':
            if not 'id' in parsed and len( id ) > 0 :
                parsed[ 'id' ] = id
                parsed[ 'fields' ] = []
                is_key = True
                continue
            elif 'fields' in parsed:
                parsed[ 'fields' ].append( { key : value } )
                is_key = True
                key = ''
                value = ''
                is_value = False

        elif c != '=' :
            if not 'id' in parsed:
                id += c
                is_value = False
                is_key = False
                continue
            else:
                if is_key:
                    key += c
                else:
                    value += c

        elif c == '=':
            if is_key:
                is_value = True
                is_key   = False




    return parsed


# invoke the main without the command itself
if __name__ == '__main__':
    print( task_2( sys.argv[ 1: ] ) )
