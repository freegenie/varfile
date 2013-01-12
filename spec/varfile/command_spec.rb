require 'spec_helper'

describe Varfile::Command do 
  let!(:file_path) { 'MyFile' }

  after do 
    `rm #{file_path}`
  end

  it 'should find correct file position' do 
    a = Varfile::Command.new
    a.list(file: file_path)
    a.file_path.to_s.should == 'MyFile'
  end

  describe 'get and set' do 
    it 'should set key to file' do 
      Varfile::Command.new.set('foo', 'bar', file: file_path)
      Varfile::Command.new.get('foo', file: file_path).should == 'bar'
    end

    it 'should overwrite value if key is present' do
      Varfile::Command.new.set('foo', 'bar', file: file_path)
      Varfile::Command.new.set('foo', 'baz', file: file_path)
      Varfile::Command.new.get('foo', file: file_path).should == 'baz'
    end
  end

  describe 'list' do 
    it 'should list content of file' do
      Varfile::Command.new.set('sport', 'racing',  file: file_path)
      Varfile::Command.new.set('language', 'ruby', file: file_path)
      Varfile::Command.new.set('country', 'italy', file: file_path)
      Varfile::Command.new.set('diet', 'paleo',    file: file_path)

      Varfile::Command.new.list(file: file_path).should ==  \
      %Q{sport=racing
         language=ruby
         country=italy
         diet=paleo
        }.gsub(' ', '')

    end
  end
end
