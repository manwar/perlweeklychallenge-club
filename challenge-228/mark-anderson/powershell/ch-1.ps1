function Unique-Sum
{
    param($arr)

    $bag = @{ }

    foreach($n in $arr)
    {
        $bag[$n]++
    }

    ($bag.keys | Where { $bag[$_] -eq 1 } | Measure -Sum).Sum    
}

Unique-Sum(2,1,3,2) #  4
Unique-Sum(1,1,1,1) #  0
Unique-Sum(2,1,3,4) # 10
