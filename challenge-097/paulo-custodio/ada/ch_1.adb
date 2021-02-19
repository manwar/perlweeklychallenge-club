-- Challenge 097
--
-- TASK #1 › Caesar Cipher
-- Submitted by: Mohammad S Anwar
-- You are given string $S containing alphabets A..Z only and a number $N.
--
-- Write a script to encrypt the given string $S using Caesar Cipher with left
-- shift of size $N.
--
-- Example
-- Input: $S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG", $N = 3
-- Output: "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD"
--
-- Plain:    ABCDEFGHIJKLMNOPQRSTUVWXYZ
-- Cipher:   XYZABCDEFGHIJKLMNOPQRSTUVW
--
-- Plaintext:  THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
-- Ciphertext: QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD

with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Command_Line;
with Ada.Text_IO; use Ada.Text_IO;

procedure ch_1 is
    -- command line arguments
    package CL renames Ada.Command_Line;

    -- caeser cipher
    function caeser(key : Integer; text : String) return String is
        cipher : String := To_Upper(text);
        cc : Integer;
    begin
        for i in cipher'First .. cipher'Last loop
            cc := (Character'Pos(cipher(i)) - Character'Pos('A') + 26 - key) Mod 26;
            cipher(i) := Character'Val(Character'Pos('A') + cc);
        end loop;
        return cipher;
    end caeser;

    -- cipher key
    key : Integer := 0;
begin
    key := Integer'Value(CL.Argument(1));
    for i in 2 .. CL.Argument_Count loop
        Put(caeser(key, CL.Argument(i)));
        Put(" ");
    end loop;
    Put_Line("");
end ch_1;
