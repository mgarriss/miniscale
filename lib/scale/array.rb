class Array
  def note(flavor=nil)
    map do |n|
      n.note(flavor)
    end
  end
  
  def semitones
    map do |n|
      n.semitones
    end
  end
  
  def chord(arg=nil)
    if arg.class == Symbol
      arg = case arg
            when :seventh then [1,3,5,7] 
            when :ninth then [1,3,5,7,9] 
            when :eleventh then [1,3,5,7,9,11] 
            when :thirteenth then [1,3,5,7,9,11,13] 
            end
    elsif arg.kind_of? Fixnum
      count = [arg,size*2].min
      arg = []
      count.times do |i|
        arg << ((i * 2) + 1)
      end
    end
    arg ||= [1,3,5]
    arg.map do |i|
      self[i-1]
    end
  end
  
  def with(arg)
    if arg.class == Symbol
      arg = case arg
            when :m7 then [0,0,0,-1] 
            when :a5 then [0,0,1] 
            end
    end
    if arg.size > size
      arg = arg[0..size]
    else
      arg += Array.new(size - arg.size){0}
    end
    to_return = []
    each_with_index.map do |n,i|
      to_return << (n.semitones + arg[i]).note
    end
    to_return
  end
  
  def %(rhs)
    with(rhs)
  end
  
  def root(n)
    if n.class == Symbol
      rotate(index(n))
    else
      map do |e|
        (e.semitones + n).note
      end
    end
  end
  
  def sharp
    map do |e|
      e.sharp
    end
  end
  
  def flat
    map do |e|
      e.flat
    end
  end
end
