# Elixir

## Installation & basics
  * `brew update && brew install elixir`
  * `iex` for REPL
    * Use `h(...)` to get help, you can pass it a function to get help about
      that function
  * Applications have `.ex` extension, wheres tests have `.exs` extension
    * Use `.ex` to compile to bytecode
    * Use `.exs` to interpret on code level
  * Compilation/execution:
    * `elixir file.exs`
    * `iex`, then `c "file.exs"`


## Philosophy
  *  Object orientation:
    * Class is king, abstract hierarchies of classes
    * Classes encapsulate state
    * A lot of what you do revolves around data-hiding
  * vs. functional programming:
    * Data transformation (not hiding)
    * Data is pushed through pipelines with multiple transformation steps
    * Functions do the data transformation (-> no side-effects)
  * Threads and processes are very lightweight, use them deliberately
  * Metaprogramming is fundamental part of the language
  * All datastructures are immutable

## Syntax

### Types
  * Keywords (seem to work like ruby)
  * String
    * Literal: `"Hello"`
  * Integer
    * Literal: `1`
  * List
    * Literal: `[ 1, 2, 3 ]`

### Basic concepts

#### Assignment (form of pattern matching)

  * Works in both directions, will fail if it can't be solved (`MatchError`)
  * Similar to algebraic `=`
  * Variable to be declared needs to be on left side (`[1,2] = list` won't work)
  * Can ignore a value with `_`
```
  list = [1,2,3]
  [a, 2, b] = list  # works
  [a, _, b] = list  # works
  [a, 1, b] = list  # won't work
```
  * Variable only binds once per match,
  * Use `^` to prevent reassignment: `[^a,2] = [1,2]` does not work if `a = 2`

#### Immutability

  * Immutable datastructures make it easier to get parallelism right
  * Can still rebind variables
  * Create a copy with the changes if you need to create a new value
  * Problems:
    * Copying: don't copy everything into a new datastructure, instead link the
      elements in a shallow manner
    * Garbage collection: Is faster because the heap is spread out across
      multiple processes and hence smaller which also means faster

### Operators
  * `+`: `1 + 2 # => 3`
  * `|`: `[1 | [2, 3]] # => [1,2,3]`

### Functions
  * Parentheses around function arguments are optional
  * `cd/1` means that the function `cd` takes one argument

### Modules
  * Modules and functions are separated by a `.` (`IO.puts`)
