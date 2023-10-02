#!/usr/bin/env python
# -*- coding: utf-8 -*-


def canonical_path(path):
    path_parts = path.split("/")
    canonical_parts = []
    for part in path_parts:
        if part == "..":
            if canonical_parts:
                canonical_parts.pop()
        elif part and part != ".":
            canonical_parts.append(part)
    return "/" + "/".join(canonical_parts)


# Testing
print(canonical_path("/a/./b/../../c/"))  # Outputs: "/c"
