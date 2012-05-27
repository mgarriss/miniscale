require 'spec_helper'

describe Symbol do
  Notes.each do |note|
    describe note do
      it 'converts to a fixnum' do
        note.semitones.class.should eq(Fixnum)
      end
      
      it 'converts to Symbol by returning self' do 
        note.note.should eq(note)
      end
      
      it 'is a Symbol' do
        note.class.should eq(Symbol)
      end
    end
  end
  
  it 'converts to sharp if asked to' do
    :Db.note(:sharp).should eq(:Cs)
  end
  
  it 'converts to flat if asked to' do
    :Cs.note(:flat).should eq(:Db)
  end
  
  it '#semitones(arg) sets a root other then :C',:pending do
    :C.semitones(:Cs).should eq(11)
    :Bb.semitones(:As).should eq(0)
  end
  
  it '#flat converts the note to flat unless it\'s natural' do
    :Cs.flat.should eq(:Db)
    :C.flat.should eq(:C)
    :Bb.flat.should eq(:Bb)
  end
  
  it '#sharp converts the note to flat unless it\'s natural' do
  end
  
  it '#flavor(:flat) == #flat' do
    :Cs.flavor(:flat).should eq(:Db)
    :C.flavor(:flat).should eq(:C)
    :Bb.flavor(:flat).should eq(:Bb)
  end
  
  it '#flavor == #flat' do
    :Cs.flavor.should eq(:Db)
    :C.flavor.should eq(:C)
    :Bb.flavor.should eq(:Bb)
  end
  
  it '#flavor(:sharp) == #sharp' do
    :Cs.flavor(:sharp).should eq(:Cs)
    :C.flavor(:sharp).should eq(:C)
    :Bb.flavor(:sharp).should eq(:As)
  end
end
