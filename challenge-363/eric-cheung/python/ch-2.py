
from ipaddress import IPv4Network, IPv4Address

## Example 1
## strIP_Addr = "192.168.1.45"
## strIP_Domain = "192.168.1.0/24"

## Example 2
## strIP_Addr = "10.0.0.255"
## strIP_Domain = "10.0.0.0/24"

## Example 3
## strIP_Addr = "172.16.8.9"
## strIP_Domain = "172.16.8.9/32"

## Example 4
## strIP_Addr = "172.16.4.5"
## strIP_Domain = "172.16.0.0/14"

## Example 5
strIP_Addr = "192.0.2.0"
strIP_Domain = "192.0.2.0/25"

try:
    objIPNet = IPv4Network(strIP_Domain, strict = False)
    objAddr = IPv4Address(strIP_Addr)

    print (objAddr in objIPNet)

except ValueError as objError:
    print (f"Validation Error: {objError}")
    ## print (False)
