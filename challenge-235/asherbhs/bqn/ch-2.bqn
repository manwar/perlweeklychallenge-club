#!/usr/bin/env BQN

DuplicateZeros←≠↑⊢/˜1+0=⊢

•Show DuplicateZeros 1‿0‿2‿3‿0‿4‿5‿0
•Show DuplicateZeros 1‿2‿3
•Show DuplicateZeros 0‿3‿0‿4‿5
