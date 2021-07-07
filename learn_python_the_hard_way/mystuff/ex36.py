from sys import exit

def dead():
    print 'you are dead. goodbye'
    exit(0)



def math_room():
    print 'what is the first derivative of 5x^2?'
    incorrect_answers = 0

    while incorrect_answers <= 5:
        incorrect_answers += 1
        answers_remaining = 5-incorrect_answers

        answer = raw_input('> ')

        if answer == '10x':
            print 'nice. lets move on'
            math_room2()
        else:
            print 'wrong. you have answered this question wrong %r times' % (incorrect_answers)
            print 'you have %r answers remaining' % (answers_remaining)
            print 'please try again'
    else:
        dead()


def math_room2():
    print 'what is the anti-derivative of 10x?'
    incorrect_answers = 0

    while incorrect_answers < 5:
        incorrect_answers += 1
        answers_remaining = 5-incorrect_answers

        answer = raw_input('> ')

        if answer == '5x^2':
            print 'nice one. lets move on'
            math_room3()
        else:
            print 'wrong. you have answered this question wrong %r times' % (incorrect_answers)
            print 'you have %r answers remaining' % (answers_remaining)
            print 'please try again'
    else:
        dead()

def math_room3():
    print 'how many combinations can be made from a pizza with 3 different toppings, 3 types of cheese, and 2 types of sauce?'
    incorrect_answers = 0

    while incorrect_answers < 5:
        incorrect_answers += 1
        answers_remaining = 5-incorrect_answers

        answer = raw_input('> ')

        if answer == '18':
            print 'nice, you have done it!'
            print 'onto the next one, my friend'
            math_room4()
        else:
            print 'wrong. you have answered this question wrong %r times' % (incorrect_answers)
            print 'you have %r answers remaining' % (answers_remaining)
            print 'please try again'

    else:
        dead()

def math_room4():
    print 'what is the probability of getting 2 heads or less across 10 total coin flips? assume the coin is fair. round to the nearest whole percentage.'
    incorrect_answers = 0

    while incorrect_answers < 5:
        incorrect_answers += 1
        answers_remaining = 5-incorrect_answers

        answer = raw_input('> ')

        if answer == '5':
            print 'nice, you have done it!'
            print 'you have escaped the math dungeon. gg, gg.'
            print 'bye now!'
            exit()
        else:
            print 'wrong. you have answered this question wrong %r times' % (incorrect_answers)
            print 'you have %r answers remaining' % (answers_remaining)
            print 'please try again'

    else:
        dead()

def start():
    print 'escape this prison you have found yourself in!'
    print 'to do so, you will have to answer 3 math problems correctly'
    print 'Are you ready to begin? (yes or no)'

    response = raw_input('> ')

    if response == 'yes':
        math_room()
    elif response == 'no':
        dead()
    else:
        dead()

start()
