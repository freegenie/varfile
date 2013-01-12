require 'spec_helper'

describe Varfile::Command do 
  let!(:file_path) { 'MyFile' }

  after do 
    `rm -f #{file_path}`
    `rm -f Varfile`
  end

  it 'should find correct file position' do 
    a = Varfile::Command.new
    a.options = { file: file_path }
    a.list
    a.file_path.to_s.should == 'MyFile'
  end

  describe 'get and set' do 
    it 'should set key to file' do 
      Varfile::Command.new.set('foo', 'bar')
      Varfile::Command.new.get('foo').should == 'bar'
    end

    it 'should overwrite value if key is present' do
      Varfile::Command.new.set('foo', 'bar')
      Varfile::Command.new.set('foo', 'baz')
      Varfile::Command.new.get('foo').should == 'baz'
    end
  end

  describe 'list' do 
    it 'should list content of file' do
      Varfile::Command.new.set('sport', 'racing')
      Varfile::Command.new.set('language', 'ruby')
      Varfile::Command.new.set('country', 'italy')
      Varfile::Command.new.set('diet', 'paleo')

      Varfile::Command.new.list.should ==  \
      %Q{sport=racing
         language=ruby
         country=italy
         diet=paleo
        }.gsub(' ', '')

    end
  end
end
