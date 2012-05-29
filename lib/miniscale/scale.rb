module Scale
  Naturals = [:C,:D,:E,:F,:G,:A,:B]
  Flats = [:Db,:Eb,:Gb,:Ab,:Bb]
  Sharps = [:Cs,:Ds,:Fs,:Gs,:As]
  Notes = Naturals + Flats + Sharps
  NotesAsSharps = [:C,:Cs,:D,:Ds,:E,:F,:Fs,:G,:Gs,:A,:As,:B]
  NotesAsFlats = [:C,:Db,:D,:Eb,:E,:F,:Gb,:G,:Ab,:A,:Bb,:B]
  Major = [1,3,5,6,8,10,12]
  Minor = [1,3,4,6,8,9,11]
end

def Scale(root,steps,flavor=nil)
  if root.flat?
    flavor = :flat
  elsif root.sharp?
    flavor = :sharp
  end
  target = (flavor == :sharp ? Scale::NotesAsSharps : Scale::NotesAsFlats)
  target.rotate(target.index(root)).chord(steps)
end
  
module Scale
  Notes.each do |n|
    eval "#{n} = Scale(n,Major)"
    eval "#{n}m =Scale(n,Minor)"
  end
end
