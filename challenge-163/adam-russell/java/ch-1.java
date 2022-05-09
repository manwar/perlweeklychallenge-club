class SumAnd{
    public static int sumAnd(int[] numbers){
        int sum = 0;
	for(int i = 0; i < numbers.length; i++){
            for(int j = i + 1; j < numbers.length; j++){
                sum += numbers[i] & numbers[j];
	    }
	}
	return sum;
    }

    public static void main(String[] args){
        System.out.println(SumAnd.sumAnd(new int[]{1, 2, 3}));
        System.out.println(SumAnd.sumAnd(new int[]{2, 3, 4}));
    }
}
