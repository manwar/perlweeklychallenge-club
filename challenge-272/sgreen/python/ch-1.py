#!/usr/bin/env python3

import sys


def defang_ip(ip: str) -> str:
    """
    Replaces all occurrences of '.' in the given IP address with '[.]'.

    Args:
        ip (str): The IP address to defang.

    Returns:
        str: The defanged IP address.

    """
    return ip.replace('.', '[.]')


def main():
    result = defang_ip(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
