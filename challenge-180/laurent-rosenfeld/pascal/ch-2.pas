program TrimList;

const tests : array[0..1,0..1,0..6] of integer =
    (((3,0,0,0,0,0,0), (1,4,2,3,5,0,0)), ((4,0,0,0,0,0,0), (9,0,6,2,3,8,5)));

var
    i, j, k: integer;
    nums: array of integer;

begin
    for j := 0 to length(tests) - 1 do
    begin
        i := tests[j][0][0];
        write('i = ', i, '; nums = ');
        nums := tests[j][1];
        for k := 0 to length(nums) - 1 do
        begin
            write(nums[k], ' ');
        end;
        write(' => ');
        for k := 0 to length(nums) - 1 do
        begin
            if nums[k] > i then
                write(nums[k], ' ');
        end;
        writeln('')
    end;
end.
