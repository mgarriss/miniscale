class Fixnum
  def note(flavor=nil)
    n = self % 12
    case n
    when 0 then :C
    when 2 then :D
    when 4 then :E
    when 5 then :F
    when 7 then :G
    when 9 then :A
    when 11 then :B
    else
      if flavor == :sharp
        case n
        when 1 then :Cs
        when 3 then :Ds
        when 6 then :Fs
        when 8 then :Gs
        when 10 then :As
        end
      else
        case n
        when 1 then :Db
        when 3 then :Eb
        when 6 then :Gb
        when 8 then :Ab
        when 10 then :Bb
        end
      end
    end
  end
  
  def semitones
    self
  end
end
