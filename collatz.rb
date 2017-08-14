def prol(n,i=0)
  if(n==1) then return i
  elsif(n%2 == 0) then return prol(n/2,i+1)
  else return prol(n*3+1,i+1)
  end
end

def prol_print(n,i=0)
  if(n==1)
    print "#{i}: #{n}\n"
    return i
  elsif(n%2 == 0)
    print "#{i}: #{n}\n"
    return prol_print(n/2,i+1)
  else
    print "#{i}: #{n}\n"
    return prol_print(n*3+1,i+1)
  end
end

def prol_list(n,i=0, ls=[])
  if(n==1)
    ls<<n
    return ls
  elsif(n%2 == 0)
    ls<<n
    return prol_list(n/2,i+1, ls)
  else
    ls<<n
    return prol_list(n*3+1,i+1, ls)
  end
end

def collatz(n)
  prol(n,0)
end

def collatz_table(n)
  (1..n).each do |i|
    print "#{i}: #{collatz(i)}\n"
  end
end
