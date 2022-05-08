import java.util.ArrayList;

class Summations{
    public static ArrayList skipSummations(int[] numbers){
        ArrayList lines = new ArrayList();
        lines.add(numbers);
        for(int i = 0; i < numbers.length; i++){
            int[] line = (int[]) lines.get(lines.size() - 1);
            int[] skip = new int[line.length - 1];
            int[] skip_summation = new int[skip.length];
	    for(int j = 1; j < line.length; j++){
                skip[j - 1] = line[j]; 
	    }  	     
            for(int j = 0; j < skip.length; j++){
                int sum_previous = 0;
		for(int k = 0; k < j; k++){
                    sum_previous += skip[k];
		}
		skip_summation[j] = skip[j] + sum_previous;
	    }
	    lines.add(skip_summation);
	}
        return lines;
    }

    public static void main(String[] args){
        ArrayList lines;
	lines = Summations.skipSummations(new int[]{1, 2, 3, 4, 5});
        for(int i = 0; i < lines.size(); i++){
            int[] line = (int[]) lines.get(i);
            for(int j = 0; j < line.length; j++){
                System.out.print(line[j]);
		System.out.print(" ");
	    }
	    System.out.print("\n");
	}
	lines = Summations.skipSummations(new int[]{1, 3, 5, 7, 9});
	for(int i = 0; i < lines.size(); i++){
	    int[] line = (int[]) lines.get(i);
	    for(int j = 0; j < line.length; j++){
		System.out.print(line[j]);
		System.out.print(" ");
	    }
	    System.out.print("\n");
	}
    }
}
