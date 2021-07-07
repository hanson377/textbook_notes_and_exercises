
def thing(max_i,increment):
    i = 0
    numbers = []

    while i < max_i:
        print "at the top i is %d" % i
        numbers.append(i)

        i = i + increment
        print "numbers now: ", numbers
        print 'at the bottom i is %d' % i

    print 'the numbers: '

    for num in numbers:
        print num

thing(10,2)
thing(12,2)
thing(100,4)
