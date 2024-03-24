#/usr/bin/env bqn

MultiplyByTwo ← { (∨´𝕨⊸=)◶𝕨‿((2×𝕨)𝕊⊢) 𝕩 }

•Show 3 MultiplyByTwo 5‿3‿6‿1‿12
•Show 1 MultiplyByTwo 1‿2‿4‿3
•Show 2 MultiplyByTwo 5‿6‿7
