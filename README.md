# Active Pragma

This Pharo project allows one to have pragmas that influence the compilation of a method.
By subclassing Active Pragma, one can have pragmas that trigger action :
- The first time it is added in a class
- Each time it is added in a class
- Each time it is removed from a class
- Each time the last instance of this pragma is removed from a class.

This runs on Pharo 12.

It was used to implement a protected modifier for Pharo : https://doi.org/10.22152/programming-journal.org/2024/8/2
