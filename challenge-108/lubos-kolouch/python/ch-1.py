#!/usr/bin/env python
# -*- coding: utf-8 -*-

import ctypes

var = "This is a variable"
print(ctypes.cast(id(var), ctypes.c_void_p))
