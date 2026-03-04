### https://theweeklychallenge.org/blog/perl-weekly-challenge-363/
"""

Task 2: Subnet Sheriff

Submitted by: [53]Peter Campbell Smith
     __________________________________________________________________

   You are given an IPv4 address and an IPv4 network (in CIDR format).

   Write a script to determine whether both are valid and the address
   falls within the network. For more information see the [54]Wikipedia
   article.

Example 1

Input: $ip_addr = "192.168.1.45"
       $domain  = "192.168.1.0/24"
Output: true

Example 2

Input: $ip_addr = "10.0.0.256"
       $domain  = "10.0.0.0/24"
Output: false

Example 3

Input: $ip_addr = "172.16.8.9"
       $domain  = "172.16.8.9/32"
Output: true

Example 4

Input: $ip_addr = "172.16.4.5"
       $domain  = "172.16.0.0/14"
Output: true

Example 5

Input: $ip_addr = "192.0.2.0"
       $domain  = "192.0.2.0/25"
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 8th March 2026.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

import ipaddress

def subnetSheriff(ip_addr: str, domain: str) -> bool:
    try:
        return ipaddress.ip_address(ip_addr) in ipaddress.ip_network(domain)
    except:
        return False

import unittest

class TestSubnetSheriff(unittest.TestCase):
    def test(self):
        for (ip_addr, domain), otpt in {
                ("192.168.1.45" ,"192.168.1.0/24"): True,
                ("10.0.0.256" ,"10.0.0.0/24"): False,
                ("172.16.8.9" ,"172.16.8.9/32"): True,
                ("172.16.4.5" ,"172.16.0.0/14"): True,
                ("192.0.2.0" ,"192.0.2.0/25"): True,
                }.items():
            self.assertEqual(subnetSheriff(ip_addr, domain), otpt)

unittest.main()
