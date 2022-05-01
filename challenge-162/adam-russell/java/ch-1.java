class ISBNCheckSum{
    public static int isbnCheckSum(String isbn){
        int checkDigit;
        char[] digits = isbn.toCharArray();
        int weight = 0;
        int[] weights = {1, 3};
        int checkSum = 0;
        for(int i = 0; i < digits.length; i++){
            checkSum += Character.digit(digits[i], 10) * weights[weight];
            weight = weight == 0 ? 1 : 0;
        }
        checkDigit = checkSum % 10;
        return 10 - checkDigit;
    }

    public static void main(String[] args){
        int checkDigit = isbnCheckSum("978030640615");
        System.out.println(checkDigit);
    }
}