--Types and Classes

{-
    The idea is taking values that we work with and figuring out how to group these with categories which have similar properties.
    
    Type is a name for a collection of related values. 
    for example Bool is a collection that has two logical values. Simillar to sets.
        True, False
    
    Type errors:

    When we use a function and the type doesn't match. 

    Notation of type in haskell:
    expression :: type
    
    you can ask the type of an expression by :t
    the :t command can calculate the type of an expression without evaluating.

    remember that every type starts with a capital letter in haskell. not like in java 
    e.g. an expression of an fixed-precision integer: haskell Int, java int
-}

{-
    List:
    List are the generic type/polymorphic type in haskell. A list is a sequence of values with the same types.
    [t] denotes the element of type t
    [t] :: t
    e.g. [True] :: Bool


-}

{-
    Tuple:
    A tuple is a sequence of values of differnet types.
    e.g. (Flase, 'a', True) :: (Bool, Char, Bool)
    The types of values that are contained in a tuple is not restricted like a list.
-}

--Functions

{-
    This is very important in functional programming.

    Function is a mapping from values of one type to values of another type.
    e.g.
    in general the function of t1 -> t2 is the type of functions that map values form type t1 to values of type t2.
    we call the collection of values of t1 'the domain of the function', and the collection of values of t2 'the range of the function'.


    The type of the domain and the range is not restricted.
    for example fn called add has the domain of a Tuple but returns a Int.
    e.g.
    1)
        add :: (Int, Int) -> Int
        add (x,y) = x + y
    2)
        zeroto :: Int -> [Int]
        zeroto n = [0..n]
-}

{-
    Curried functions:
    If the arguments and the values of a function types are arbitrary, both can be function themselves.

    for example the add funciton of the previous.
    It is common to define such function in haskell using currying.

        add' :: Int -> (Int -> Int)
        add' x y = x + y

    add' is a function that takes an Int and returns a function that takes an another Int. Finnaly returns and Int.

    both add and add' returns the same result. However, add' takes the argument one by one not a tuple.
    Functions that take their arguments one by one are called 'curried funcitions'.

    Every function that takes more than two arguments can be turned into a function that takes these arguments one by one.

        mult :: Int -> (Int -> (Int -> Int))
        mult x y z = x*y*z

    Why is currying useful?
    The reason is because we can partialy apply a funciton.


    Currying Conventions:
    We mostly do not use parenthesis to represent the parameters as currying.
    Thus,
        mult :: Int -> (Int -> (Int -> Int)) == mult :: Int -> Int -> Int -> Int
-}

--Type classes and Porymorphic functions

{-

    Polymorphic Functions:
    Polymorphic functions are functions that are not defined on concrete types but that are defined using type variables.
    For example, List function "length" is a polymorphic function.
        length :: [a] -> Int

    If we want to cacluate the length of a list, the type of the elements of the list does't matter.
    Therefore the domain of length accepts a variable type.

    here, [a] is the type variable. 
    Type variable must begin with a lower case and usually named a, b, c, ...

    most of the time, a list of type variables has an exception that an empty list is not included and it cannot be caculated.

    examples of polymorphic functions:
    fst, head, take, zip, id
    check the type signature with :t
-}

{-
    Overloaded Functions:

    In haskell overloading corresponds to the notion of Interfaces in OOP.
    In haskell overloading means that you are restricting the types of the parameters.

    For example a funciton that sums all element in a list.
    sum only work when the element of the list has some numeric type. 
    Therefore,
        sum :: [a] -> a 
        does't work
        if the element of the list is consisted with String, summing up the element doesn't make sense.
    Thus, we want to restrict the type of the elements in the list. And, overloading does the restriction of the type.

        sum :: Num a => [a] -> a
        for any numeric type a, sum takes a list of values of type a and returns a value of type a.
    
    "sum" takes a list and returns it into a value but it can only do that when the values in the list support the Num class or the Num interface.

    Type Classes:
    So, we understood that "sum" has a `constrained type variable`.
    Constrained type variables can be instantiated to `any types that satisfy the constraints`.
    We call such constraints of types in haskell, "type classes".

-}


