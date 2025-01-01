import java.util.*;

public class Code {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Map<Integer, Map<Character, Integer>> transitions = new HashMap<>();
        
        transitions.put(1, Map.of('a', 2, 'b', 3));
        transitions.put(2, Map.of('a', 1, 'b', 4));
        transitions.put(3, Map.of('a', 4, 'b', 1));
        transitions.put(4, Map.of('a', 3, 'b', 2));

        Set<Integer> acceptingStates = Set.of(2);

        System.out.print("Enter the input string: ");
        String input = scanner.nextLine();

        boolean isAccepted = simulateDFA(transitions, acceptingStates, input);

        System.out.println("Input string \"" + input + "\" is " + (isAccepted ? "ACCEPTED" : "REJECTED"));
    }

    public static boolean simulateDFA(Map<Integer, Map<Character, Integer>> transitions, Set<Integer> acceptingStates, String input) {
        int currentState = 1;

        for (char symbol : input.toCharArray()) {
            if (transitions.containsKey(currentState) && transitions.get(currentState).containsKey(symbol)) {
                currentState = transitions.get(currentState).get(symbol);
            } else {
                return false;
            }
        }

        return acceptingStates.contains(currentState);
    }
}