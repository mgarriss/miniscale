require 'spec_helper'

describe Scale do
  it 'has a factory to produce Arrays given a root, steps and inversion' do
    Scale(:C,Major).should eq([:C,:D,:E,:F,:G,:A,:B]) 
    Scale(:A,Minor).should eq([:A,:B,:C,:D,:E,:F,:G]) 
    Scale(:G,[1,5,8]).should eq(G.chord)
  end
  
  it 'has a constant for the natural notes' do
    defined?(Naturals).should be_true
  end
  
  it 'has a constant for the flat notes' do
    defined?(Flats).should be_true
  end
  
  it 'has a constant for the sharp notes' do
    defined?(Sharps).should be_true
  end
  
  describe NotesAsSharps do
    it 'has a constant for the natural + flats notes' do
      defined?(NotesAsFlats).should be_true
    end
    
    it 'is the union of Naturals and Flats', :pending do
      (Naturals | Flats).should eq(NotesAsSharps)
    end
  end
  
  describe NotesAsFlats do
    it 'has a constant for the natural + flats notes' do
      defined?(NotesAsFlats).should be_true
    end
    
    it 'is the union of Naturals and Flats', :pending do
      (Naturals | Flats).should eq(NotesAsFlats)
    end
  end
  
  describe Notes do
    it 'has a constant for the natural + flats + sharp notes' do
      defined?(Notes).should be_true
    end
    
    it 'is the union of Naturals, Flats and Sharps' do
      (Naturals | Flats | Sharps).should eq(Notes)
    end
  end
  
  it 'has a constant for the major interval pattern' do
    defined?(Major).should be_true
  end
  
  it 'has a constant for the minor interval pattern' do
    defined?(Minor).should be_true
  end
  
  describe 'scale constants' do
    Notes.each do |note|
      describe Major do
        it "defines Scale::#{note}" do
          eval "defined?(Scale::#{note}).should be_true"
        end
      end
      
      describe Minor do
        it "defines Scale::#{note}m" do
          eval "defined?(Scale::#{note}m).should be_true"
        end
      end
    end
  end
end
