+++
title = "Kata"
date = 2023-05-27
+++

_Kata in programming is a term derived from the martial arts and it denotes a form of practice designed for consistent improvement._

1. __Reinforce__: In the context of programming, a kata is a technique that reinforces concepts and skills. By working on the same problem repeatedly, you strengthen your understanding of the particular coding technique, data structure, or algorithm involved.
2. __Sharpen__: A kata serves to sharpen your coding skills. Similar to how a martial artist refines their moves through repetition, a developer sharpens their coding techniques by repeatedly solving the same or similar problems.
3. __Exercise__: A kata is an exercise that works your 'coding muscles'. The more you engage in it, the better your proficiency in a particular area of programming.
4. __Repeating__: In a kata, the repetition of problem-solving is essential. It's not about solving new problems every time but perfecting your approach to a specific problem by repeatedly working on it.
5. __Practice__: Kata is all about practice. It's the belief that consistent, deliberate, and focused practice of programming concepts can lead to mastery.

# Tool

In functional programming language like Kotlin you have ready-to-use functions for applying on coding problems.

A list of some useful functions.
```kt
forEachIndexed()
split()
drop()
first()
toUpperCase()
toLowerCase()
joinToString()
reversed()
filter()
count()
plus()
map()
mapIndexed()
```

Here an example how the function can be applied to solve a problem.
```kt
fun main() {
    generateSequence(0) { it + 1 }.windowed(size=3, step=10)
    .take(3).toList()
    .apply(::println)
    // [[0, 1, 2], [10, 11, 12], [20, 21, 22]]
}
```

The Java way.
```java
import java.util.*;
import java.util.stream.*;

public class Kata {
    private static List<Integer> windowed(int start) {
        return IntStream.range(start, start + 3).boxed().collect(Collectors.toList());
    }
    public static void main(String[] args) {
        List<List<Integer>> sequences = IntStream.range(0, 3)
                .map(i -> i * 10)
                .mapToObj(Kata::windowed)
                .collect(Collectors.toList());
        System.out.println(sequences);  
        // [[0, 1, 2], [10, 11, 12], [20, 21, 22]]
    }
}
```

The imperative way.
```java
private static void imperative() {
    List<List<Integer>> sequences = new ArrayList<>();
    for (int i = 0; i < 3; i++) {
        int start = i * 10;
        List<Integer> windowedSequence = new ArrayList<>();
        for (int j = start; j < start + 3; j++) {
            windowedSequence.add(j);
        }
        sequences.add(windowedSequence);
    }
    System.out.println(sequences);
    // [[0, 1, 2], [10, 11, 12], [20, 21, 22]]
}
```