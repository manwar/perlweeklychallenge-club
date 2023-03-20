#!/usr/bin/env python
# -*- coding: utf-8 -*-

paths = ["/a/b/c/d", "/a/b/cd", "/a/b/cc", "/a/b/c/d/e"]
separator = "/"

common_path = []
for path in paths:
    parts = path.split(separator)
    if not common_path:
        common_path = parts
    else:
        for i in range(len(common_path)):
            if common_path[i] != parts[i]:
                common_path = common_path[:i]
                break

print(f"The common directory path is: {separator.join(common_path)}")
