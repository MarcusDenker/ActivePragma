This Pharo projects allows one to have pragmas that influenced the compilation of a method.
By subclassing Active Pragma, one can have pragmas that trigger action :
- The first time it is added in a class
- Each time it is added in a class
- Each time it is removed from a class
- Each time the last instance of this pragma is removed from a class.

This runs on Pharo 12.
