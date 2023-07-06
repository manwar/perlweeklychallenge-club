#!/usr/bin/env python
# -*- coding: utf-8 -*-

def can_form_target(source, target):
    for char in target:
        if char in source:
            source = source.replace(char, '', 1)
        else:
            return False
    return True


print(can_form_target("abc", "xyz"))  # Output: False
print(can_form_target("scriptinglanguage", "perl"))  # Output: True
print(can_form_target("aabbcc", "abc"))  # Output: True
