# Supports any unicode digits, so ႐႐၄၂ will be trimmed to ၄၂.
# Zero and negative numbers are not trimmed because the task
# specifically asks for positive numbers. However, it is not specified
# what a “number” is, and same goes for formatting requirements (e.g.
# “.5“ vs “0.5”), therefore I decided to keep it simple and just do
# the integers. So it's just a neat example on how to do unicode-aware
# number matching.

put S:r/^[ <:Nd> & <:Numeric_Value(0)> ]* <before <:Nd>+$>// for @*ARGS
