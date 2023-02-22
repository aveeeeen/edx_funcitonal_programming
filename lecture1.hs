{-
lecture video-1

first steps on haskell

the most important thing is to get used to the very basic things. We need to do such drills until it gets automatic to our body.

GHC:
    This is the compiler of haskell. Haskell prelude includes standard libraries. It also manages as the sdk of haskell.
    In the GHCi prompt, it can manage input as haskell expressions and evaluate them. The interpreter is ready in the commnad line.

    e.g.:
    > 2+3*4
    14

    we will stick to funcitons that is included in the standard library, or the Prelude.
    Most of the function in prelude is functions that manages over list.

    e.g. 
    let list = [1,2,3,4,5]

    -- select the first element from a list
    head list -> 1
    -- select the Nth element of the list
    list !! 2 -> 3

    we can see that haskell indexes list by counting from zero
    list are not arrays. indexing into a list is linear to the num elements. Not constant time operation like manipulating arrays. 
    we don't do indexing to handle lists. 
    
    -- append two list
    list ++ [6,7]

    in rest of the lectures we will define such list operation funcitons. 

Function Application:
    in mathmatics, space means multiplication. Therefore funciton is represented as f(a,b), 
    using parenthesis to distinguish between multiplication and functions.

    In haskell, function application is denoted using space.
    Therefore: f a b 

    function opperation have higher priority than all operators. Funtion bindes stronger than anything.
    f a + b --this means (f a) + b, f a is the first being evaluated because it is a function.
-}

{-
Haskell Scripts:
    New functions are defined within a script. We use the .hs suffix for haskell programs.

Workflow:
    one window has the editor opened, and the other the GCHi opened.
-}
double x = x + x
qudruple x = double (double x)

{-
we need to load the complier by avoking the using .hs files. We cannot interpret and evaluate .hs durring prelude.
-}

factorial n = product[1 .. n]
average ns = sum ns `div` length ns
{-
when we put a function name between ``, it becomes a infix opperator .
e.g.
    x `f` y is same as f x y

if we command ":reload" in prelude it updates the interpreting file
-}

{-
Naming conventions:
    function and arguent names must begin with a lower-case letter.
        myFun
        fun1
        arg_2
    types should start with an uppercase.

    list arguments have and s suffix. xs means it is a list
        xs -> list of values of type x
        ns -> list of values of type n
    when have two s at the end it is a list of a list
        xss

    When we have a sequence of a definition it should start with the same column.
    f x = x*x
    g x = x*3

Get used to GHCi commands!! there are useful commnads and it would help you to program in haskell.
-}