#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pyoeis import OEISClient

c = OEISClient()
seq = c.get_by_id('A104170')

print(seq.unsigned(10))
