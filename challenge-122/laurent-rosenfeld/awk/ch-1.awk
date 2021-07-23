{
    avg[0] = $1;
    print $1;
    for (i = 1; i < NF; i++) {
         avg[i] = (avg[i-1] * i + $(i+1)) / (i+1)
         print avg[i]
    }
}
