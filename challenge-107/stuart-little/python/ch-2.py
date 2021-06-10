#!/usr/bin/env python

# run <script> <path-to-module>
# defaults to the os module

import importlib.machinery
import os
import sys

pth = os.__file__ if (len(sys.argv) < 2) else sys.argv[1]

module_name=""
file_loader = importlib.machinery.SourceFileLoader(module_name, pth)
mod = file_loader.load_module()
print(list(filter(lambda x: eval(f"callable(mod.{x})"), dir(mod))))
