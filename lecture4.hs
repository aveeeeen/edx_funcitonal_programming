--List comprehensions

{-
    list comprehensions are a mechanism to write code that manipulate collectoins
    List is one of a collection type.

    Set comprehensions:
    In mathematics, the comprehension notation can be used to construct new sets from old sets.
    e.g. A set comprehension in math

        {x^2 | x <- {1...5}}
        this constructs a set of x^2 deriving from set of {1 ... 5}
        which result to a new set of {1,4,9,16,25}

    List Comprehentions:
    In haskell, instead of constructing new sets, a similar comprehension notation can be used to construct new list from old lists.

    e.g.
        [x^2 | x <- [1..5]] == [1,4,9,16,25]
        this list comprehension constructs a list same as the above set comprehension
    
        the expression x <- [1..5] is called the generator. This is because it defines how to generate the values for x.

    Comprehensions can have multiple generators, separated by commas.
    e.g.
        [(x,y) | x <- [1,2,3], y <- [4,5]] == [(1,4),(1,5),(2,4),(2,5),(3,4),(3,5)]
        this creates a pair of possible combination of list x and y.
        we can see that the y varies faster than x.

    by changing the order of the generator, it will change the order of the element of the generated list.

    e.g.
        [(x,y) | y <- [4,5], x <- [1,2,3]] == [(1,4),(2,4),(3,4),(1,5),(2,5),(3,5)]
        we can see that, this time the list of x comes former than the list of y.

        this is simmilar to a nested loop. The variables of later generators has a frequent changes than the former, resembles the inner loop of the neseted loop.

    Dependant Generators:
    The later generator can depend on the variables that are introduced by earlier generators.

    e.g.
        [(x,y) | x <- [1..3], y <- [x..3]] == [(1,1),(1,2),(1,3),(2,2),(2,3),(3,3)]
        x is drawn from 1 ... 3
        y is drawn from x ... 3
        Therefore,
            when x = 1, y can range from 1 .. 3 resulting to (x,y) = (1,1),(1,2),(1,3)
            when x = 2, y can range from 2 .. 3 resulting to (x,y) = (2,2),(2,3)
            when x = 3, y can range from 3 .. 3 resulting to (x,y) = (3,3)

        this is also similar to a nested loop, although in haskell it is written more concisely.
        e.g.
        list = List<Tuple<Int>>
        for(i = 1 ; i <= 3; i++)
            for(j = i; j <= 3; j++)
                list.push(new Tuple(i,j))
    
    Using dependant generator, we can define the library function that concatenates a list of lists.
    e.g.
        concat :: [[a]] -> [a]
        concat xss = [x | xs <- xss, x <- xs]
        list xs passes each element of listOflist xss
        list x passes each element of list xs

        therefore, when xss = [[1,2][2,3][3,4]]
        first element of xss [1,2] -> xs
        second element of xss [2,3] -> xs
        third element of xss [3,4] -> xs
        xs -> x retruns a list of x

    Filtering list using multiple generators(Guards):

    We can filter a list by using a generator that restrict the values produced by earlier generators.
    [x | x <- [1..10], even x] = [2,4,6,8,10]
    generates the list of nums 1..10, and x is even
    this way of filtering values using list comprehension is called guards.

    e.g.
        factors :: Int -> [Int]
        factors n =
            [x | x <- [1..n], n `mod` == 0]
        
        by using guards, factors of number can be calculated by mapping all positive int to 1 .. n, then filter out the factor of the list of num.

    e.g.
        prime :: Int -> Bool
        prime n = factors n == [1,n]
        by using the function factors defined above, we can figure out wether it is a prime num or not.
    
    e.g.
        primes :: Int -> [Int]
        primes n = [x | x <- [2..n], prime x ]
        This list comprehension say that,
            Give me all the numbers 2 ... n
            and the x should be a prime
-}

{-
    Zip function:
    zip will combine two lists into a single list.

    zip :: [a] -> [b] -> [(a,b)]
    e.g.
        zip ['a','b'] [1,2,3,4]
        will return [('a',1),('b',2)]
        the zip stops when one of the list gets exhausted. Therefore, 3,4 is exhausted.

    by using a zip, we can define a function that returns a list of all pairs of adjacent elements from a list.
    e.g.
        pairs :: [a] -> [(a,a)]
        pairs xs = zip xs (tail xs)
        
        when xs = [2,3,4,5]
        tail xs = [3,4,5]
        zips the two list

    Using pairs we can define a funciton that decides if the elements in a list are sorted.
    e.g.
        sorted :: Ord a => [a] -> Bool
        sorted xs =
            and [x <= y | (x,y) <- pairs xs]
        
        by the `and` function, if all the elements in list is True by comparing whether the later(x) is larger former(y)
        the list xs is concluded as True

    Using zip we can define a function that returns the list of all positions of a value in a list.
    e.g.
        positions :: Eq a => a -> [a] -> [Int]
        positions x xs =
            [i | (x', i) <- zip xs [0..n], x == x']
            where n = length xs - 1
        the first generator zips the list of xs with the list of each index(i) by [0 .. length - 1(n)]
        the comprehended list will be all i of element of (x' i) when matches x == x'.
-}

{-
    String Comprehensions:
    
    In haskell strings are nothing more than syntactic sugar for list of characters.
    Which means that you can use comprehensions over lists as well.

-}

pairs :: [a] -> [(a,a)]
pairs xs = zip xs (tail xs)


sorted_string xs = 
    and [x <= y | (x,y) <- pairOfChar xs]
    
pairOfChar xs = pairs (map (\x -> head x) xs)

--map' :: [a] -> f -> [b]
map' xs = \f -> [f(x) | x <- xs]


{-
xs = ["amd","hell","cow"]
x:xs = x
head x = []
-}