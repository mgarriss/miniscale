require 'spec_helper'

describe Fixnum do
  it 'converts values larger than 11 to a valid note number' do
    12.note.should eq(:C)
    13.note.should eq(:Db)
    23.note.should eq(:B)
    24.note.should eq(:C)
  end
  
  it 'converts values less than 0 to a valid note number' do
    -1.note.should eq(:B)
    -2.note.should eq(:Bb)
    -2.note(:sharp).should eq(:As)
    -3.note.should eq(:A)
    -4.note.should eq(:Ab)
    -4.note(:sharp).should eq(:Gs)
    -5.note.should eq(:G)
    -6.note(:sharp).should eq(:Fs)
    -7.note.should eq(:F)
    -8.note.should eq(:E)
    -9.note.should eq(:Eb)
    -10.note.should eq(:D)
    -11.note.should eq(:Db)
    -12.note.should eq(:C)
    -13.note.should eq(:B)
  end
  
  it 'to_note accepts a argument to request sharps back' do
    12.note(:sharp).should eq(:C)
    13.note(:sharp).should eq(:Cs)
  end
end
