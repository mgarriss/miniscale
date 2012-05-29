class Symbol
  def semitones(new_root=nil)
    case self
    when :C      then 0
    when :Cs,:Db then 1
    when :D      then 2
    when :Ds,:Eb then 3
    when :E      then 4
    when :F      then 5
    when :Fs,:Gb then 6
    when :G      then 7
    when :Gs,:Ab then 8
    when :A      then 9
    when :As,:Bb then 10
    when :B      then 11
    else
      raise "#{self.inspect} is not a note"
    end
  end
  
  def flat?
    Scale::Flats.include?(self)
  end
  
  def natural?
    Scale::Naturals.include?(self)
  end
  
  def sharp?
    Scale::Sharps.include?(self)
  end
  
  def flat
    case self
    when :Cs then :Db
    when :Ds then :Eb
    when :Fs then :Gb
    when :Gs then :Ab
    when :As then :Bb
    else self
    end
  end
  
  def sharp
    case self
    when :Db then :Cs
    when :Eb then :Ds
    when :Gb then :Fs
    when :Ab then :Gs
    when :Bb then :As
    else self
    end
  end
  
  def flavor(f=nil)
    if f == :sharp
      sharp
    else
      flat
    end
  end
  
  def +(rhs)
    (semitones + rhs).note
  end
  
  def note(flavor = nil)
    if flavor == :sharp
      sharp
    elsif flavor == :flat
      flat
    else
      self
    end
  end
end
