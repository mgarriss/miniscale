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
  
  def chord(*args)
    arg = args.first
    if args[1]
      to_return = args[1..-1].map do |a|
        a.map do |i|
          if i.respond_to?(:chord)
            chord(arg,i)
          else
            root(i).chord(arg)
          end
        end
      end
      to_return.size == 1 ? to_return.first : to_return
    else
      if arg.class == Symbol
        arg = case arg
              when :chord then [1,3,5] 
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
  end
  
  def with(arg)
    if first.respond_to?(:with)
      map do |e|
        e.with(arg)
      end
    else
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
  end
  
  def %(rhs)
    with(rhs)
  end
  
  def root(*args)
    n = args.shift
    to_return = if n.class == Symbol
      rotate(index(n))
    else
      rotate(n-1)
    end
    unless args.empty?
      to_return.c(*args)
    else
      to_return
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
  
  def n(*args)
    i = args.first
    if args.size == 1 
      e = (self[(i-1) % size])
      to_return = if e.respond_to?(:n)
                    to_return = map do |x|
                      x.n(i)
                    end
                    if to_return.kind_of? Symbol
                      to_return
                    elsif to_return.size == 1
                      to_return.first
                    else
                      to_return
                    end
                  else
                    e
                  end
    else
      if first.kind_of? Symbol
        c(args)
      else
        map do |a|
          a.n(*args)
        end
      end
    end
  end

  def pretty_print(q)
    q.text to_s
  end
  
  alias c chord
  alias r root
end
