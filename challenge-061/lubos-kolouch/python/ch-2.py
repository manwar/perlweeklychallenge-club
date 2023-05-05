#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def is_valid_octet(s: str) -> bool:
    return 0 <= int(s) <= 255 and str(int(s)) == s


def restore_ip_addresses(s: str) -> List[str]:
    result = []
    n = len(s)

    for i in range(1, 4):
        for j in range(i + 1, i + 4):
            for k in range(j + 1, j + 4):
                if k < n:
                    s1, s2, s3, s4 = s[:i], s[i:j], s[j:k], s[k:]
                    if is_valid_octet(s1) and is_valid_octet(
                            s2) and is_valid_octet(s3) and is_valid_octet(s4):
                        result.append(f"{s1}.{s2}.{s3}.{s4}")

    return result


input_str = "25525511135"
ipv4_addresses = restore_ip_addresses(input_str)
for address in ipv4_addresses:
    print(address)
