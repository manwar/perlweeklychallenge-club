multi sub MAIN (Numeric $number where $number >= 0)
{
     say +$number;
}

multi sub MAIN ($value)
{
     say $value;
}
