<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Installation & basics](#installation-&-basics)
- [Philosophy](#philosophy)
- [Types](#types)
- [Functions](#functions)
  - [Anonymous functions](#anonymous-functions)
- [Modules](#modules)
- [Basic concepts](#basic-concepts)
  - [Assignment (form of pattern matching)](#assignment-form-of-pattern-matching)
  - [Operators](#operators)
  - [Conventions/Naming](#conventionsnaming)
  - [Truthiness](#truthiness)
  - [Equality](#equality)
  - [Boolean operators](#boolean-operators)
  - [Immutability](#immutability)
  - [Protocols](#protocols)
- [Collections](#collections)
  - [Enum](#enum)
  - [Stream](#stream)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

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

## Types
  * Atoms (Symbols in ruby)
    * Name = value
    * Literal: `:fred`, `:"something else"`, `:is_good?`
  * String
    * Literal: `"Hello"`
    * Are really UTF8 binaries (see below)
    * Interplation: "1 + 1 = #{1+1}"
  * Integer
    * Literal: `1`, `0xcafe`, `0o765`, `0b10110`, `1_000_000`
  * Floating point
    * Literal `1.23`
  * Range:
    * Literal `1..3`
  * Regular expression
    * Perl compatible (same as ruby / should be able to use rubular.com)
    * Literal: `~r{[aeiou]}`
  * Tuple
    * Use them for return values, then use pattern matching for control flow
    * Literal: `{ 1, 2 }`
  * List
    * Not arrays, linked datastructure instead
    * Random order access is expensive
    * Literal: `[ 1, 2, 3 ]`
    * Keyword lists: `[a: 1, b: 2]` is shorthand for `[{a: 1}, {b: 2}]`
    * Concatenation: `[1,2] ++ [3,4] #=> [1,2,3,4]`
    * Intersection: `[1,2] -- [2,3] #=> [1]`
    * Inclusion: `1 in [1,2,3] #=> true`
  * Map
    * Only one key per entry (keyword lists allow duplication)
    * Literal: `m = %{ :a => 1 }` (same as `%{ a: 1 }`)
    * Access with `m[:a]` or `m.a` (latter one only works with atom keys)
    * Update with `m1 = %{ m | a: "one" }`
      * Will blow up if key `a` does not exist
      * Use `Dict.put_new/3` instead
  * HashDict
    * Use Dict behavior -> Let's you swap Map for HashDict
    * No literal, use `HashDict.new` and `Enum.into`
  * Struct
    * Module that wraps a (limited) Map
    * Typesafe maps
    * Literal is similar to a `Map`
    * May define methods in the User module, these are class level methods however
    * Modify with `put_in`, `update_in`, `get_in`, `get_and_update_in`
    ```
    defmodule User do
      defstruct name: "", admin: false
    end
    u = %User{name: "Sebastian"}
    u1 = %User{ u | admin: false}
    ```
  * Set
    * Only implementation: `HashSet`
  * Binaries
    * Sequence of bits
    * Literal: `<< 1,2 >>`

## Functions
  * Parentheses around function arguments are optional
  * `cd/1` means that the function `cd` takes one argument
  * If keyword list is last argument, you can leave off the `[]`

### Anonymous functions

```elixir
sum = fn (a,b) -> a + b end # Anonymous function
sum.(1,2) # . needed for anonymous function
swap = fn { a, b } -> { b, a } end
swap.({6,8}) # arguments are pattern matched
```

## Modules
  * Modules and functions are separated by a `.` (`IO.puts`)
  * = collection of functions grouped by a purpose
    * Example: `Enum` has functions that deal with collections

## Basic concepts

### Assignment (form of pattern matching)

  * Works in both directions, will fail if it can't be solved (`MatchError`)
  * Similar to algebraic `=`
  * Variable to be declared needs to be on left side (`[1,2] = list` won't work)
  * Can ignore a value with `_`
```elixir
list = [1,2,3]
[a, 2, b] = list  # works
[a, _, b] = list  # works
[a, 1, b] = list  # won't work
```
  * Variable only binds once per match,
  * Use `^` to prevent reassignment: `[^a,2] = [1,2]` does not work if `a = 2`

### Operators
  * `+`: `1 + 2 # => 3`
  * `|`: `[1 | [2, 3]] # => [1,2,3]`
  * `div`: `div(2,3) #=> 0`
  * `rem`: `rem(2,3) #=> 2`

### Conventions/Naming
  * Identifiers: `/[a-z|A-Z|0-9|_|\?|!]+/`
  * Module, record, protocol and behavior: BumpyCase
  * Everything else: snake_case
  * Comments start with `#`

### Truthiness
  * `true`, `false`, `nil`
  * `false` and `nil` are treated as falsy in boolean contexts, everything else is true

### Equality
  * Strict `===` and value `==`
```elixir
1 === 1.0 # => false
1 !== 1.0 # => true
1 == 1.0 # => true
1 != 1.0 # => false
```

### Boolean operators
  * `and`, `or` and `not` expect `true` or `false` as first argument
  * `&&`, `||`, `!` use truthiness

### Immutability

  * Immutable datastructures make it easier to get parallelism right
  * Can still rebind variables
  * Create a copy with the changes if you need to create a new value
  * Problems:
    * Copying: don't copy everything into a new datastructure, instead link the
      elements in a shallow manner
    * Garbage collection: Is faster because the heap is spread out across
      multiple processes and hence smaller which also means faster

### Protocols

  * = interfaces in other languages
  * `Access` is one

## Collections
  * `Enumerable` is a protocol
  * `Enum` and `Stream` contain functions that handle collections
    * `Enum` contains more standard functions
    * `Stream` is for lazy collections

### Enum

  * `Enum.to_list`
  * `Enum.concat`
  * `Enum.map`/`Enum.filter`/`Enum.sort`/`Enum.reject`
  * `Enum.max`/`Enum.max_by`
  * ...

### Stream

  * `Streams` are composable Enumerators
  * Can be inifinite
  * They don't create multiple intermediary collections,
    instead the elements are pushed through one-by-one
  * Libraries support/emit Streams:
    * IO.stream
    * File.stream!
    * ...
  * Implementing Streams:
    * `Stream.cycle`: Infinite Stream from an Enumerable
    * `Stream.repeatedly`: Execute fn everytime you're asked for an element
    * `Stream.iterate`:
      Takes start_value and fn to produce next_value, next_value is start_value
      of next iteration
    * `Stream.unfold`:
      Similar to `iterate` but start_value doesn't have to be next_value
      --> Allows you to implement fibonnaci
    * `Stream.resource`: Builds on `unfold` to work with Files/Network
      * Takes `fn` that delivers `start_value`
      * Takes another `fn` to close the resource
