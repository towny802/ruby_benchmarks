# Insertion sort: https://gist.github.com/zallarak/1579541
def insertion_sort(a)

  a.each_with_index do |item, index|
    i = index - 1

    while i>=0
      break if item >= a[i]
      a[i+1] = a[i]
      i -= 1
    end

    a[i+1] = item

  end
end

def mergesort(array)
    if array.count <= 1
        # Array of length 1 or less is always sorted
        return array
    end

    # Apply "Divide & Conquer" strategy

    # 1. Divide
    mid = array.count / 2
    part_a = mergesort array.slice(0, mid)
    part_b = mergesort array.slice(mid, array.count - mid)

    # 2. Conquer
    array = []
    offset_a = 0
    offset_b = 0
    while offset_a < part_a.count && offset_b < part_b.count
        a = part_a[offset_a]
        b = part_b[offset_b]

        # Take the smallest of the two, and push it on our array
        if a <= b
            array << a
            offset_a += 1
        else
            array << b
            offset_b += 1
        end
    end

    # There is at least one element left in either part_a or part_b (not both)
    while offset_a < part_a.count
        array << part_a[offset_a]
        offset_a += 1
    end

    while offset_b < part_b.count
        array << part_b[offset_b]
        offset_b += 1
    end

    return array
end

def quicksort(array, from=0, to=nil)
    if to == nil
        # Sort the whole array, by default
        to = array.count - 1
    end

    if from >= to
        # Done sorting
        return
    end

    # Take a pivot value, at the far left
    pivot = array[from]

    # Min and Max pointers
    min = from
    max = to

    # Current free slot
    free = min

    while min < max
        if free == min # Evaluate array[max]
            if array[max] <= pivot # Smaller than pivot, must move
                array[free] = array[max]
                min += 1
                free = max
            else
                max -= 1
            end
        elsif free == max # Evaluate array[min]
            if array[min] >= pivot # Bigger than pivot, must move
                array[free] = array[min]
                max -= 1
                free = min
            else
                min += 1
            end
        else
            raise "Inconsistent state"
        end
    end

    array[free] = pivot

    quicksort array, from, free - 1
    quicksort array, free + 1, to
end

def num_at(num, d)
    return num if num/10 == 0
    a = num
    #return the dth digit of num
    counter = 0
    until counter == d
        a/=10
        counter += 1
    end

    a % 10
end

def radix_sort(arr)
    w = 2
    #count_arr can have any possible number from 0-99
    aux = Array.new(arr.length) {0}

    d = w-1
    while d >= 0
        count = Array.new(99) {0}
        i = 0

        #create freq arr
        while i < arr.length
            count[num_at(arr[i], d) + 1] += 1 #offset by 1
            i += 1
        end

        #compute cumulates
        i = 0
        while i < count.length - 1
            count[i + 1] += count[i]
            i += 1
        end

        z = 0
        #populate aux arr
        while z < arr.length
            aux[num_at(arr[z], d)] = arr[z]
            count[num_at(arr[z], d)] += 1
            z += 1
        end

        #override original arr
        z = 0
        while z < arr.length
            arr[z] = aux[z]
            z += 1
        end
        d -= 1
    end

    arr
end

def avgs100 fx
  times = Array.new(9)
  10.times do |i|
    xs = Array.new(100) {((rand*10).to_i*10).to_i}
    start = Time.now
    fx.call(xs)
    times[i]=Time.now-start
  end
  return avg times
end

def avgs1k fx
  times = Array.new(9)
  10.times do |i|
    xs = Array.new(1000) {(rand*10).to_i}
    start = Time.now
    fx.call(xs)
    times[i]=Time.now-start
  end
  return avg times
end

def avgs10k fx
  times = Array.new(9)
  10.times do |i|
    xs = Array.new(10000) {(rand*10).to_i}
    start = Time.now
    fx.call(xs)
    times[i]=Time.now-start
  end
  return avg times
end

def avgs100k fx
  times = Array.new(9)
  10.times do |i|
    xs = Array.new(100000) {(rand*10).to_i}
    start = Time.now
    fx.call(xs)
    times[i]=Time.now-start
  end
  return avg times
end

def avgs1m fx
  times = Array.new(9)
  10.times do |i|
    xs = Array.new(1000000) {(rand*10).to_i}
    start = Time.now
    fx.call(xs)
    times[i]=Time.now-start
  end
  return avg times
end

def avgs10m fx
  times = Array.new(9)
  10.times do |i|
    xs = Array.new(10000000) {(rand*10).to_i}
    start = Time.now
    fx.call(xs)
    times[i]=Time.now-start
  end
  return avg times
end

def avgs100m
  times = Array.new(9)
  10.times do |i|
    xs = Array.new(100000000) {(rand*10).to_i}
    start = Time.now
    fx.call(xs)
    times[i]=Time.now-start
  end
  return avg times
end

def quickavg(sample_size=100,list_size=1000,fx=quickproc)
  avg_times = Array.new(list_size)
  list_size.times do |i|
    avg_nt = Array.new(sample_size)
    sample_size.times do |j|
      xs = Array.new(i) {(rand*10).to_i}
      start = Time.now
      fx.call(xs)
      avg_nt[j]=Time.now-start
    end
    avg_times[i]=avg avg_nt
    avg_nt.clear
  end
  avg_times.each {|i| puts i.to_s+"\n"}
end

$quickproc = proc {|xs| quicksort(xs)}
$insertionproc = proc {|xs| insertion_sort(xs)}
$mergeproc = proc {|xs| mergesort(xs)}
$radixproc = proc {|xs| radix_sort(xs)}

def quicktest
  puts avgs100 $mergeproc
  puts avgs1k $mergeproc
  puts avgs10k $mergeproc
  puts avgs100k $mergeproc
  puts avgs1m $mergeproc
  #puts avgs10m
  #puts avgs100m
end

def avg xs
  return ((xs.sum)/(xs.length-1))
end
