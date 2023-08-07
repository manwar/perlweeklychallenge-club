function Empty-Array
{
    param([System.Collections.ArrayList]$a)

    $total

    while($a)
    {
        [int]$min = ($a | Measure -Minimum).Minimum

        $i = [array]::indexof($a,$min)

        if($i -eq 0 -Or $i -eq $a.Count-1) { $a.RemoveAt($i) }

        else { $a = $a[($i+1)..($a.Count-1) + 0..($i-1)] }

        $total += $i+1
    }

    $total
}

Empty-Array(3,4,2)                                              #   5
Empty-Array(1,2,3)                                              #   3
Empty-Array(16,17,8,15,13,11,19,5,12,6,20,2,4,10,3,14,1,7,9,18) # 127
