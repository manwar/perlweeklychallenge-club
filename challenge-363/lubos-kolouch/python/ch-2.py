#!/usr/bin/env python3
"""Perl Weekly Challenge 363 Task 2: Subnet Sheriff."""

from __future__ import annotations

import unittest
from collections.abc import Sequence


def _parse_ipv4(text: str) -> int | None:
    parts = text.split(".")
    if len(parts) != 4:
        return None

    octets: list[int] = []
    for part in parts:
        if not part.isdigit():
            return None
        value = int(part)
        if value < 0 or value > 255:
            return None
        octets.append(value)

    ip = 0
    for octet in octets:
        ip = (ip << 8) | octet
    return ip


def _parse_cidr(network: str) -> tuple[int, int] | None:
    if "/" not in network:
        return None
    ip_text, prefix_text = network.split("/", 1)
    if not prefix_text.isdigit():
        return None

    prefix = int(prefix_text)
    if prefix < 0 or prefix > 32:
        return None

    ip = _parse_ipv4(ip_text)
    if ip is None:
        return None

    return ip, prefix


def subnet_sheriff(ip_addr: str, network: str) -> bool:
    """Return True if inputs are valid IPv4/CIDR and the address is in network."""
    ip = _parse_ipv4(ip_addr)
    parsed = _parse_cidr(network)
    if ip is None or parsed is None:
        return False

    network_ip, prefix = parsed
    mask = 0 if prefix == 0 else ((0xFFFFFFFF << (32 - prefix)) & 0xFFFFFFFF)
    return (ip & mask) == (network_ip & mask)


class Task2Examples(unittest.TestCase):
    """Official example tests from the challenge statement."""

    def test_example_1(self) -> None:
        self.assertTrue(subnet_sheriff("192.168.1.45", "192.168.1.0/24"))

    def test_example_2(self) -> None:
        self.assertFalse(subnet_sheriff("10.0.0.256", "10.0.0.0/24"))

    def test_example_3(self) -> None:
        self.assertTrue(subnet_sheriff("172.16.8.9", "172.16.8.9/32"))

    def test_example_4(self) -> None:
        self.assertTrue(subnet_sheriff("172.16.4.5", "172.16.0.0/14"))

    def test_example_5(self) -> None:
        self.assertTrue(subnet_sheriff("192.0.2.0", "192.0.2.0/25"))


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        unittest.main(argv=[__file__])
        return
    if len(argv) != 2:
        raise SystemExit(f"Usage: {__file__} <ip_addr> <network/cidr>")
    print("true" if subnet_sheriff(argv[0], argv[1]) else "false")


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
