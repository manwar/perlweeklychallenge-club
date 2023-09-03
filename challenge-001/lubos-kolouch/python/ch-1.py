#!/usr/bin/env python
# -*- coding: utf-8 -*-


def replace_e(what: str):
    count = what.count("e")
    modified_what = what.replace("e", "E")
    return count, modified_what


# Simple test to verify the functionality
assert replace_e("Perl Weekly Challenge") == (5, "PErl WEEkly ChallEngE")
