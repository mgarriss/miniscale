require 'spec_helper'

describe 'intervals' do
  it 'note + semitones returns a note that many semitones away' do
    (:C + 1).should eq(:Db)
  end
end
