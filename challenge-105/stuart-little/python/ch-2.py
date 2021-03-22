#!/usr/bin/env python

# run <script> <name>

import sys

def ellis(c,name):
    return f"{c}o-" + (name[1:] if (c == name[0].lower()) else (c + name[1:]))

def verse(name):
    capName=name.capitalize()
    return f"""
    {capName}, {capName}, {ellis('b',capName)}
    Bonana-fanna {ellis('f',capName)}
    Fee fi {ellis('m',capName)}
    {capName}!
    """

print(verse(sys.argv[1]))
