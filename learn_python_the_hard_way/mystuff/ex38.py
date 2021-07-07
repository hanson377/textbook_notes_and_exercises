ten_things = "Apples Oranges Crows Telephone Light Sugar"

print "wait there's not ten things in that list, lets fix that."

stuff = ten_things.split(' ')
more_stuff = ['Day','Night','Song','Frisbee','Corn','Banana','Girl','Boy']

while len(stuff) != 10: ## while we still have less than 10 items in our list
    next_one = more_stuff.pop() ## rename the last item in more_Stuff to next_one
    print "Adding: ", next_one
    stuff.append(next_one) ## append next_one to stuff
    print 'there is %d items now.' % len(stuff)

print 'there we go: ', stuff

print 'lets do some things with stuff.'

print stuff[1] ## simply look at the 2nd item in the list
print stuff[-1] ## look at the last item in the list
print stuff.pop() ## remove the last item in the list
print ' '.join(stuff)
print '#'.join(stuff[3:5])
