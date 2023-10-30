#!/usr/bin/env BQN

RemoveOne←{∨´(∧´·<´˘2↕𝕩/˜⊢)˘≠⌜˜↕≠𝕩}

•Show RemoveOne 0‿2‿9‿4‿6
•Show RemoveOne 5‿1‿3‿2
•Show RemoveOne 2‿2‿3
