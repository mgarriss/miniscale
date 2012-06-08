module MiniScale
  Naturals = [:C,:D,:E,:F,:G,:A,:B]
  Flats = [:Db,:Eb,:Gb,:Ab,:Bb]
  Sharps = [:Cs,:Ds,:Fs,:Gs,:As]
  Notes = Naturals + Flats + Sharps
  NotesAsSharps = [:C,:Cs,:D,:Ds,:E,:F,:Fs,:G,:Gs,:A,:As,:B]
  NotesAsFlats = [:C,:Db,:D,:Eb,:E,:F,:Gb,:G,:Ab,:A,:Bb,:B]
  Major = [1,3,5,6,8,10,12]
  Minor = [1,3,4,6,8,9,11]
end

def MiniScale(root,steps,flavor=nil)
  if root.flat?
    flavor = :flat
  elsif root.sharp?
    flavor = :sharp
  end
  target = (flavor == :sharp ? MiniScale::NotesAsSharps :
                               MiniScale::NotesAsFlats)
  target.rotate(target.index(root)).chord(steps)
end
  
module MiniScale
  Notes.each do |n|
    eval "#{n} = MiniScale(n,Major)"
    eval "#{n}m = MiniScale(n,Minor)"
  end
end
