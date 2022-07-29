import java.util.Scanner;
public class IN300_Unit_A1 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner sc = new Scanner(System.in);
		System.out.println("What is your name? ");
		String employee = sc.nextLine();
		System.out.println("First Number? ");
		int firstNumber = sc.nextInt();
		System.out.println("Second Number? ");
		int secondNumber = sc.nextInt();
		System.out.println("Third Number? ");
		int thirdNumber = sc.nextInt();
		
		int numberSum = firstNumber+secondNumber+thirdNumber;
		int numberAvg = numberSum / 3;
		
		System.out.println("The sum is "+numberSum);
		System.out.println("The average is "+numberAvg);
		
		
		
	}

}
