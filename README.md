# Cool Stack Machine Interpreter

## Project Information
- **Course**: CSCI 4160
- **Project**: Program 1
- **Author**: Steven Gobran
- **Instructor**: Dr. Zhijiang Dong
- **Due Date**: Wednesday, February 11, 2026

## Description

This project implements a simple stack machine interpreter using the **Cool (Classroom Object-Oriented Language)**. The interpreter processes commands to manipulate a stack that can hold integers and the multiplication operator.

## Features

The stack machine supports the following commands:

| Command | Description |
|---------|-------------|
| `int` | Push an integer onto the stack |
| `*` | Push the multiplication operator onto the stack |
| `e` | Evaluate the top of the stack (multiply if `*` is on top) |
| `d` | Display the contents of the stack from top to bottom |
| `x` | Exit the program |

## How It Works

### Evaluation Logic (`e` command)
- If `*` is on top of the stack:
  1. Pop the `*` operator
  2. Pop the next two integers
  3. Multiply them together
  4. Push the result back onto the stack
- If the top is an integer or the stack is empty, nothing happens

### Example Session

```
>15
>2
>*
>d
*
2
15
>e
>d
30
>x
```

**Explanation:**
1. Push `15` onto stack
2. Push `2` onto stack
3. Push `*` onto stack
4. Display shows: `*`, `2`, `15` (top to bottom)
5. Evaluate: `*` is on top, so multiply `2 * 15 = 30`
6. Display shows: `30`
7. Exit program

## Implementation Details

### Classes

- **A2I**: Utility class for converting between strings and integers
- **List**: Empty list implementation (base class)
- **Cons**: Non-empty list node (linked list structure)
- **StackCommand**: Main interpreter class containing:
  - `push()`: Adds elements to the stack
  - `pop()`: Removes and returns top element
  - `display()`: Prints stack contents
  - `evaluate()`: Performs multiplication when applicable
  - `run()`: Main program loop
- **Main**: Entry point of the program

### Data Structure

The stack is implemented as a **linked list** using the List/Cons classes, where:
- The head of the list represents the top of the stack
- Elements are stored as strings
- Numbers are converted using the A2I utility class

## Running the Program

### On Windows
```bash
cool_windows solution.cl
```

### On Linux/JupyterHub
First, make the interpreter executable:
```bash
chmod a+x cool_Linux64
```

Then run the program:
```bash
./cool_Linux64 solution.cl
```

## Files

- `solution.cl` - Main source code file containing all classes and implementation

## Requirements

- Cool compiler/interpreter
- No external dependencies (A2I and List classes are included in the source file)

## Notes

- The program assumes all input is valid (no error checking required per assignment specs)
- Integers are assumed to be unsigned
- The program exits gracefully with the `x` command (does not call `abort()`)

## Learning Objectives

This project helped develop understanding of:
- Cool programming language syntax and semantics
- Object-oriented design in Cool
- Stack data structure implementation
- String/integer conversion techniques
- Basic interpreter design patterns

## License

This is an academic project for CSCI 4160.
