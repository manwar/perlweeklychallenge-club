-- Challenge 011
--
-- Challenge #1
-- Write a script that computes the equal point in the Fahrenheit and Celsius
-- scales, knowing that the freezing point of water is 32oF and 0oC, and that
-- the boiling point of water is 212oF and 100oC. This challenge was proposed
-- by Laurent Rosenfeld.
--
-- F = (C * 9/5) + 32
-- F = C = x
-- =>   x = (x * 9/5) + 32
-- <=>  x * (1 - 9/5) = 32
-- <=>  x = 32 / (1 - 9/5)

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

procedure ch_1 is
    x : Float := 32.0 / (1.0 - 9.0/5.0);
begin
    Put(x, 1, 1, 0);
end ch_1;
