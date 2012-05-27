require 'spec_helper'

require 'note-seq'

include NoteSeq

describe NoteSeq do
  it 'has a constant for the natural notes' do
    definded?(Naturals).should be_true
  end
  
  it 'has a constant for the flat notes' do
    definded?(Flats).should be_true
  end
  
  it 'has a constant for the sharp notes' do
    definded?(Sharps).should be_true
  end
  
  describe NoteAsSharps do
    it 'has a constant for the natural + flats notes' do
      definded?(NotesAsFlats).should be_true
    end
    
    it 'is the union of Naturals and Flats' do
      (Naturals | Flats).should eq(NotesAsSharps)
    end
  end
  
  describe NotesAsFlats do
    it 'has a constant for the natural + flats notes' do
      definded?(NotesAsFlats).should be_true
    end
    
    it 'is the union of Naturals and Flats' do
      (Naturals | Flats).should eq(NotesAsFlats)
    end
  end
  
  describe Notes do
    it 'has a constant for the natural + flats + sharp notes' do
      definded?(Notes).should be_true
    end
    
    it 'is the union of Naturals, Flats and Sharps' do
      (Naturals | Flats | Sharps).should eq(Notes)
    end
  end
  
  it 'has a constant for the major interval pattern' do
    definded?(Major).should be_true
  end
  
  it 'has a constant for the minor interval pattern' do
    definded?(Minor).should be_true
  end
end
