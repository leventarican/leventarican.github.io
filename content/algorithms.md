+++
title = "Algorithms"
date = 2021-03-07
+++

# Selection Sort

Implementation in Java.
```java
char[] input = {'c', 'a', 'd', 'b'};
System.out.println(new String(input));

// sort algorithm
{
    for (int i = 0; i < input.length; i++) {
        char tmp;
        for (int j = 0; j < input.length-1; j++) {
            if (input[j] > input[j+1]) {
                // TODO: is there any operation like kotlin for swap?!
                tmp = input[j];
                input[j] = input[j+1];
                input[j+1] = tmp;
            }
        }
    }
}

System.out.println(input);
```