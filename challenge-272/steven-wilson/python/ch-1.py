#!/usr/bin/env python3


def defang_ip_address(address):
    ''' Given a valid IPv4 address, return the defanged version of the given IP
    address.

        A defanged IP address replaces every period “.” with “[.]".
    >>> defang_ip_address('1.1.1.1')
    '1[.]1[.]1[.]1'
    >>> defang_ip_address('255.101.1.0')
    '255[.]101[.]1[.]0'
    '''
    return address.replace(".", "[.]")


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
