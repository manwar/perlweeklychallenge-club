#!/usr/bin/env python
# -*- coding: utf-8 -*-


def common_path(paths):
    paths = [path.split("/") for path in paths]
    common = []
    for items in zip(*paths):
        if all(item == items[0] for item in items):
            common.append(items[0])
        else:
            break
    return "/".join(common)


paths = [
    "/a/b/c/1/x.pl",
    "/a/b/c/d/e/2/x.pl",
    "/a/b/c/d/3/x.pl",
    "/a/b/c/4/x.pl",
    "/a/b/c/d/5/x.pl",
]
print(common_path(paths))  # Output: /a/b/c
