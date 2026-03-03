import ipaddress


def subnet_sheriff(ip_addr: str, domain: str) -> bool:
    try:
        ip = ipaddress.ip_address(ip_addr)
        network = ipaddress.ip_network(domain, strict=False)
        return ip in network
    except ValueError:
        return False


if __name__ == "__main__":
    assert subnet_sheriff("192.168.1.45", "192.168.1.0/24") is True
    assert subnet_sheriff("10.0.0.256", "10.0.0.0/24") is False
    assert subnet_sheriff("172.16.8.9", "172.16.8.9/32") is True
    assert subnet_sheriff("172.16.4.5", "172.16.0.0/14") is True
    assert subnet_sheriff("192.0.2.0", "192.0.2.0/25") is True
