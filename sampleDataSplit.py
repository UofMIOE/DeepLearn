data1 = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1]
data = [1, 0, 1, 0, 0, 0, 1]

def find_factors(number):
    i = 2
    factor_list = []
    while i < int(number**.5) + 1:
        if number % i == 0:
            factor_list.append(i)
            factor_list.append(int(number/i))
        i += 1
    factor_list.sort()
    return factor_list

#step is the number of steps to the next number that remains. Ex: removing every other element would have step = 1
def remove_elements(data, step):
    i = step
    new = []
    for ele in data:
        if i == step:
            new.append(ele)
            i -= 1
        elif i == 0:
            i = step
            continue
        else:
            i -= 1
            continue
    return new
#print(remove_elements(data1,10))

def split_data(data):
    length = len(data)
    count = sum(data)
    print("Length of data is ",length)
    print("Number of ones in data: ", count)

    factors = find_factors(length-1)
    print("Factors that data can split on :", factors)

    new = []
    for num in factors:
        new = remove_elements(data, num-1)
        if sum(new) != count:
            continue
        else:
            print("Split with ",num-1," as the step")
            print("Removed ",length-len(new), " zeros")
            return new



print(split_data(data1))
