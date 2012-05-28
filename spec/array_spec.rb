require 'spec_helper'

describe Array do
  it 'has an :note method when returns a copy as notes' do
    [0,1,2].note.should eq([:C,:Db,:D])
  end
  
  it ':note is recursive' do
    [[0,1],[2]].note.should eq([[:C,:Db],[:D]])
  end
  
  it ':note accepts a :sharp argument' do
    [[0,1],[2]].note(:sharp).should eq([[:C,:Cs],[:D]])
  end
  
  it ':note accepts a :flat argument'  do
    [[0,1],[2]].note(:flat).should eq([[:C,:Db],[:D]])
  end
  
  it 'has an :semitones method when returns copy as fixnums' do
    [[:C,:Db],[:D]].semitones.should eq([[0,1],[2]])
    [[0,1],[2]].semitones.should eq([[0,1],[2]])
  end
  
  describe '#chord' do
    it 'returns a new Array with the 1st, 3rd and 5th of self' do
      C.chord.should eq(C.chord([1,3,5]))
      C.chord(:chord).should eq(C.chord([1,3,5]))
    end
    
    it 'adds the 7th when passed the arg :seventh' do
      C.chord(:seventh).should eq(C.chord([1,3,5,7]))
    end
    
    it 'adds the 9th when passed the arg :ninth' do
      C.chord(:ninth).should eq(C.chord([1,3,5,7,9]))
    end
    
    it 'adds the 11th when passed the arg :eleventh' do
      C.chord(:eleventh).should eq(C.chord([1,3,5,7,9,11]))
    end
              
    it 'adds the 13th when passsd the arf :thirteenth' do
      C.chord(:thirteenth).should eq(C.chord([1,3,5,7,9,11,13]))
    end
    
    it 'a Fixnum arg returns every other note in a cycle unto arg size' do
      C.chord(3).should eq(C.chord)
      C.chord(5).should eq(C.chord(:ninth))
    end
    
    it 'an Array of position in the seq to return starting from 1' do
      C.chord([1,3,5,7,9]).should eq(C.chord(:ninth))
    end
  end
  
  it 'has a % operator that raises or lowers the given notes by arg' do
    (C.chord(:seventh) % [0,0,0,-1]).should eq([:C,:E,:G,:Bb])
  end
  
  it 'self % :m7 drops the 7th' do
    (C.chord(:seventh) % :m7).should eq([:C,:E,:G,:Bb])
  end
  
  it 'self % :a5 raises the 5th' do
    (C.chord(:seventh) % :a5).should eq([:C,:E,:Ab,:B])
    (C.chord(:seventh) % :a5 % :m7).should eq([:C,:E,:Ab,:Bb])
  end
  
  it ':with is equivlant to %' do
    C.chord.with(:a5).should eq(C.chord % :a5)
    C.chord.with(:m7).should eq(C.chord % :m7)
  end
  
  it '#m3? is true if there is a note 3 semitones from the root',:pending do
    Cm.chord.m3?.should be_true
    Gm.chord.m3?.should be_true
    Gsm.chord.m3?.should be_true
    Bbm.chord.m3?.should be_true
  end
  
  it '#root returns a scale rotated to the given note' do
    C.root(:G).should eq([:G,:A,:B,:C,:D,:E,:F])
  end
  
  it '#root returns a scale rotated to the given index starting at 1' do
    C.root(1).should eq(C)
    Cm.root(3).should eq([:Eb, :F, :G, :Ab, :Bb, :C, :D])
  end
  
  it '#sharp calls #sharp recursively' do
    [:G,:Ab,[:Bb,:C]].sharp.should eq([:G,:Gs,[:As,:C]])
  end
  
  it '#flat calls #sharp recursively' do
    [:G,:As,[:Cs,:C]].flat.should eq([:G,:Bb,[:Db,:C]])
  end
  
  describe '#chord with multiple array args' do
    it 'takes an array of indexes for each arg' do
      C.chord(:chord,[3,4]).should eq(
        [C.root(3).chord,C.root(4).chord])
      C.chord([1,2],[1,7]).should eq(
        [[:C,:D],C.root(7).chord([1,2])])
    end
    
    it 'works on a minor scale' do
      Cm.chord(:chord,[1,4]).should eq(
        [[:C,:Eb,:G],[:F,:Ab,:C]])
    end
    
    it 'takes nested progression arrays' do
      Cm.chord(:chord,[[1,4],[1,7]]).should eq(
        [Cm.chord(:chord,[1,4]),Cm.chord(:chord,[1,7])])
    end
    
    it 'treats the 3+ args as new progressions' do
      Fs.c(2,[1,4],[5,5]).should eq(
        [[Fs.c(2),Fs.r(4).c(2)],
         [Fs.r(5).c(2),Fs.r(5).c(2)]])
    end
    
    it 'has a chord alias == c' do
      Cm.c(3,[[1,4],[1,7]]).should eq(
        [Cm.chord(:chord,[1,4]),Cm.chord(:chord,[1,7])])
    end
    
    it 'has a root alias == r' do
      Fs.root(8).should eq(Fs.r(8))
      Fs.root(1).should eq(Fs.r(1))
    end
  end
  
  it 'has a n method that return it\s nth member' do
    C.n(1).should eq(C[0])
    C.n(8).should eq(C[0])
  end
  
  it 'r passes additional arguments to c' do
    C.r(3,1).should eq([C[2]])
    C.r(4,:chord,[1,4,5,4]).should eq(
      C.r(4).c(:chord,[1,4,5,4]))        
  end
  
  it 'the n method wraps' do
    Eb.n(8).should eq(:Eb)
  end
  
  it 'the r method wraps' do
    Eb.r(8).should eq(Eb)
  end
  
  it 'the n method is recursive' do
    Fs.c(2,[1,5]).n(1).should eq([:Fs,:Cs])
  end
  
  it 'the n methods takes many args and just maps' do
    G.c(4,[1,2]).n(1,2).should eq([[:G,:B],[:A,:B]])
  end
  
  it 'long example' do
    # create the I,IV,V,VII progression of chords from the G minor
    #   scale and then create the VI,IV,V,V progression. join these
    #   results
    phrase_a, phrase_b = Gm.c(3,[1,4,5,7],[6,4,5,5])
    phrase_a.size.should eq(4)
    phrase_b.size.should eq(4)
    phrase_a.first.size.should eq(3)
    phrase_a.last.size.should eq(3)
    phrase_b.first.size.should eq(3)
    phrase_b.last.size.should eq(3)
    
    section = [phrase_a] * 3
    section << phrase_b
    section.size.should eq(4)
  end
end
