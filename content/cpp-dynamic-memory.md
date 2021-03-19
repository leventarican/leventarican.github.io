+++
title = "C++: Dynamic Memory Allocation"
date = 2020-02-09
+++

* new and delete operators
* Dynamic Memory Allocation
* segmentation fault demo
* malloc() or calloc(), free()
* Memory Management

```cpp
#include <iostream>

using namespace std;

int main() {
    float* p;
    p = new float(3.14);
    cout << "\nnew example: " << *p;

    int size = 8;
    int* a = new int[size];
    cout << "\narray: " << *a;
    *a = 100;
    *a++;
    *a = 200;
    *a--;
    cout << "\narray: " << *a;
    cout << "\narray: " << a[1] << endl;

    delete [] a;
    cout << "\nprocessing finished: " << a[0] << endl;

    cout << "\nprocessing finished: " << endl;
    cout << "\nsegmentation fault: " << a[100] << endl;
}
```
