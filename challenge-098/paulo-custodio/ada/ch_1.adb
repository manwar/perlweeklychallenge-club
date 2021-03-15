-- Challenge 098
--
-- TASK #1 › Read N-characters
-- Submitted by: Mohammad S Anwar
-- You are given file $FILE.
--
-- Create subroutine readN($FILE, $number) returns the first n-characters and
-- moves the pointer to the (n+1)th character.
--
-- Example:
-- Input: Suppose the file (input.txt) contains "1234567890"
-- Output:
--     print readN("input.txt", 4); # returns "1234"
--     print readN("input.txt", 4); # returns "5678"
--     print readN("input.txt", 4); # returns "90"


with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line;
with Ada.Strings.Bounded;

procedure ch_1 is
    -- command line arguments
    package CL renames Ada.Command_Line;

    -- strings for filenames
    package SB is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
    use SB;

    -- maximum number of different files
    Max_Files : constant := 100;

    -- arrays of already seen files and their File_Type's
    Filenames : array (1 .. Max_Files) of SB.Bounded_String;
    File_IDs  : array (1 .. Max_Files) of File_Type;
    Last_ID   : Integer := 0;

    -- either open file and append to array, or return index if already open
    function open_file(Filename : SB.Bounded_String)
    return Integer is
    begin
        -- search already open file
        for I in 1 .. Last_ID loop
            if Filename = Filenames(I) then
                return I;
            end if;
        end loop;

        -- open new file
        Last_ID := Last_ID + 1;
        Filenames(Last_ID) := Filename;
        Open(File_IDs(Last_ID), In_File, To_String(Filename));
        return Last_ID;
    end open_file;

    -- read the next N chars from the given file
    function readN(Filename : SB.Bounded_String; Number_Chars : Integer)
    return SB.Bounded_String is
        ID : Integer;
        C  : Character;
        Text : SB.Bounded_String;
    begin
        ID := open_file(Filename);
        for I in 1 .. Number_Chars loop
            if not End_Of_File(File_IDs(ID)) then
                Get(File_IDs(ID), C);
                SB.Append(Text, C);
            end if;
        end loop;
        return Text;
    end readN;

    -- local variables
    Filename : SB.Bounded_String;
    Number_Chars : Integer := 0;
    I : Integer := 1;
    Text : SB.Bounded_String;
begin
    while I+1 <= CL.Argument_Count loop
        Filename := SB.To_Bounded_String(CL.Argument(I));
        Number_Chars := Integer'Value(CL.Argument(I+1));
        Text := readN(Filename, Number_Chars);
        Put_Line(To_String(Text));
        I := I + 2;
    end loop;
end ch_1;
