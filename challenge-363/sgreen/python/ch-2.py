#!/usr/bin/env python3

import ipaddress
import sys


def subnet_sheriff(ip_addr: str, domain: str) -> bool:
    """
    Determine whether an IP address and net block are valid and the address
    falls within the network.

    Params:
        ip_addr (str): An IPv4 address
        domain(str): An IPv4 net block, in CIDR notation

    Returns:
        bool: If the IP address is within the net block
    """
    try:
        return ipaddress.IPv4Address(ip_addr) in ipaddress.IPv4Network(domain)
    except ipaddress.AddressValueError:
        # If a IP address is not valid, return false
        return False


def main():
    result = subnet_sheriff(sys.argv[1], sys.argv[2])
    print(result)


if __name__ == "__main__":
    main()
