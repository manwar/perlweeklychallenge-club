#/usr/bin/env bqn

productSign ← { (0<⊢)◶((0>⊢)◶0‿¯1)‿1 ×´ }

•Show ProductSign ⟨-1, -2, -3, -4, 3, 2, 1⟩
•Show ProductSign ⟨1, 2, 0, -2, -1⟩
•Show ProductSign ⟨-1, -1, 1, -1, 2⟩
