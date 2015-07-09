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

## Syntax

### Types
  * Keywords (seem to work like ruby)
  * String
    * Literal: `"Hello"`
  * Integers
    * Literal: `1`

### Functions
  * Parentheses around function arguments are optional
  * `cd/1` means that the function `cd` takes one argument

### Modules
  * Modules and functions are separated by a `.` (`IO.puts`)
