--Defining functions

{-
    We will compare function definitions in haskell and other programming language.
    This will make us our concrete understandings of funcitons in haskell

    Conditional Expressions:

    In haskell we don't have statements.
    It is a conditional expression. Thus it is similar to ternary expression of an imparative language.

    We use the 
        if, then, else
    for conditional expression.

    since it is a expression, this can be nested. also, because it is an expression, it should always have a return value.

    e.g.
        abs :: Int -> Int
        abs n = 
            if n >= 0 
            then n
            else -n

    Guarded Equations:

    In haskell, it is common to use guarded equation rather than conditional expressions
    function definition on the left hand side, and the condition on the following

    e.g.
        abs n 
            | n >= 0 = n
            | otherwise = -n
        
    e.g.
        signum n
            | n < 0 = -1
            | n == 0 = 0
            | otherwise = 1

    guarded expression lets us enumerate conditions, which makes conditional expression more convenient
    The otherwise is the base condition. The condition of otherwise should always be true.

    Pattern Matching:

    e.g.
        not :: Bool -> Bool
        not False = True
        not True = False

    It is simmilar to making a table of possible output from an input.

    e.g.
        (&&) :: Bool -> Bool -> Bool
        True && True = True
        True && False = False
        False && True = False
        False && False = False
    
    However we can make this list of expressions more consicely. 
    since, any argument except True && True = True returns False, we can generallize as bellow.

        (&&) :: Bool -> Bool -> Bool
        True && True = True
        _    && _    = False

        underscore means the varialbe that can be anything, it is a wildcard.

    Patterns are matched in order. For example, the following definition always return False
        
        (&&) :: Bool -> Bool -> Bool
        _    && _    = False
        True && True = True
        `this always return false`
-}

{-
    List Patterns
    
    Precisely, every non-empty list is contructed by repeated use of an operator `:` called "cons".
    The `:` is used to add an element to the head of the list. Thus, [x,x,x,x] is a syntactic sugar of this opperation.

    e.g.
        [1,2,3,4] == 1:(2:(3:(4:[])))

    when we want to use pattern matching for a list, we need to use the expression using "cons".
    Functions on lists can be defined using `x:xs` patterns.

    e.g.
        head :: [a] -> a
        head (x:_) = x
        this divides the head and the rest of the list and returns the head

        tail :: [a] -> [a]
        tail (_:xs) = xs
        this divides the head and the rest of the list and returns the rest

        however, this pattern matching won't function if the list is an empty list.
-}

--Part 2: How to define functions
{-
    The key is lambda expressions.
    Lambda expressions:

    functions can be constructed without naming the functions by using lambda expressions.
    \x -> x + x
    the nameless function takes number x and returns the result x+x.
    it is an expression that denotes a function.

    In mathmatics, nameless functions are usually denoted using |->.
    Therefore, x |-> x+x

    Why are Labmda useful?
    It is useful because they allow your intentions better when working with curried funtions.

    e.g.
        add x y = x + y

        however it is better to express as the following

        add = \x -> (\y -> x+y)

    Lambda expressions are also useful when expressing that a function is returning a function as a result.

    e.g.
        const :: a -> b -> a
        const x _ = x

        it is unclear that it is returning a function
        
        const :: a -> (b -> a)
        const x = \x -> x

        this makes it explicit that the const of x will return a function

    Lambda expression is also useful because you can avoid naming functions that are only referenced once.

    e.g.
        odds n = 
            map f [0..n-1]
            where
                f x = x*2 + 1

        this can be more consice by the following

        odds n = map (\x -> x*2 + 1) [0..n-1]

    Sections:
    An operator written between its two arguments can be converted into a curried funciton written before its two arguments by using parenthesis.
    It is also called prefix notation for contrasiting with infix notation. 

    e.g.
        prelude> 1 + 2
        3

        is same as

        prelude> (+) 1 2
        3

    This convention allows one of the arguments of the operator to be included in the parenthesis.

    e.g.
        prelude> (1+) 2
        3
        (1+) becomes a function that expects an argument latter 1 to be calculated

        prelude> (+2) 1
        3
        (+2) becomes a function that expects an argument former 2 to be calculated
        we can partially apply plus by using sections

-}

--Exercises

{-
    Consider a funciton `safetail` that behaves in the same way as tail, except that safetail maps the empty list to the empty list
    whereas tail gives an error is this case.
    Define safetail using:

    (a) a conditional expression;
    (b) guarded equations;
    (c) pattern matching.

    Hint: the library function null :: [a] -> Bool can be used to test if a list is empty.
-}

safetail'a :: [a] -> [a]
safetail'a xs =
    if null xs 
        then []
        else tail xs

safetail'b :: [a] -> [a]
safetail'b xs
    | null xs = []
    | otherwise = tail xs

safetail'c :: [a] -> [a]
safetail'c [] = []
safetail'c (x:xs) = xs

--遊び

sum' :: Num a => [a] -> a
sum' xs 
    | xs == [] = 0
    | otherwise = head xs + sum'(tail xs)

length' :: [a] -> Int
length' xs = (count xs) - 1
    where 
        count [] = 0
        count (x:xs) = 1 + count(xs)

{-
    思いつくのに１時間ほど掛かった。
    リストの再帰は3つの要素を持つリストをもとに考えるとわかりやすい。
    考え方的には、最後のケース（再帰が行われるケース）で再帰的に呼び出される関数が、ベースケースにたどりつくまで、入れ子状に関数が入力される感じ。
    let list = [1,2,3]
    length' list 
    1.length' xs = (count xs) - 1　より　countの値を算出
    2.countの再帰
        count (x:xs) = 1 + count(xs)
        count [1,2,3] = 1 + count`[2,3]`(1 + count`[3]`(1 + count`[]`("base case!!")))  
    3.count [1,2,3] = 3 より　length' [1,2,3] = 3 - 1
-}

mod_xs :: a -> ([b] -> [a]) 
mod_xs a = \ls -> map(\x -> a) $ ls

mkLs :: Int -> [Int]
mkLs 0 = []
mkLs 1 = [1]
mkLs x = [1 .. x]
