#!/usr/bin/env python

def valid(val):
  octets = val.split('.')
  if '/' in octets[3]:
    octet, mask = octets[3].split('/')
    if int(mask) > 32: return False
    octets[3] = octet
  return all([ int(o) <= 255 for o in octets ])

def octets2int(ip_addr):
  octets = ip_addr.split('.')
  return sum(
    [ int(o) * 2**(8*i) for i,o in zip([3, 2, 1, 0], octets) ]
  )

def in_range(ip_addr, domain):
  prefix, mask = domain.split('/')
  ip_int     = octets2int(ip_addr)
  prefix_int = octets2int(prefix)
  mask_int   = (2 ** 32 - 1) ^ (2 ** (32-int(mask)) - 1)
  return (ip_int & mask_int) == prefix_int

def subnet_sheriff(ip_addr, domain):
  return (
    valid(ip_addr) and valid(domain) and
    in_range(ip_addr, domain)
  )

def solution(ip_addr, domain):
  print(f'Input: $ip_addr = "{ip_addr}"')
  print(f'       $domain  = "{domain}"')
  print(f'Output: {subnet_sheriff(ip_addr, domain)}')

print('Example 1:')
solution("192.168.1.45", "192.168.1.0/24")

print('\nExample 2:')
solution("10.0.0.256", "10.0.0.0/24")

print('\nExample 3:')
solution("172.16.8.9", "172.16.8.9/32")

print('\nExample 4:')
solution("172.16.4.5", "172.16.0.0/14")

print('\nExample 5:')
solution("192.0.2.0", "192.0.2.0/25")
