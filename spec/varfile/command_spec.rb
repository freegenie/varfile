require 'spec_helper'

class TestOutput
  def puts(string)
    @output ||= []
    @output << string
  end

  def inspect
    @output.join "\n"
  end
end

describe Varfile::Command do 

  subject {
    a = Varfile::Command.new
    a.output = TestOutput.new
    a
  }

  let!(:file_path) { 'MyFile' }

  after do 
    `rm -f #{file_path}`
    `rm -f Varfile`
  end

  it 'should find correct file position' do 
    a = subject
    a.options = { file: file_path }
    a.list
    a.file_path.to_s.should == 'MyFile'
  end

  describe 'get and set' do 
    it 'should set key to file' do
      subject.set('foo', 'bar')
      test = subject

      test.get('foo')
      test.output.inspect.should == 'bar'
    end

    it 'should overwrite value if key is present' do
      subject.set('foo', 'bar')
      subject.set('foo', 'baz')
      test = subject

      test.get('foo')
      test.output.inspect.should == 'baz'
    end
  end

  describe 'list' do 
    it 'should list content of file' do
      subject.set('sport', 'racing')
      subject.set('language', 'ruby')
      subject.set('country', 'italy')
      subject.set('diet', 'paleo')

      test = subject
      test.list
      test.output.inspect.should == \
      %Q{sport=racing
         language=ruby
         country=italy
         diet=paleo
        }.gsub(' ', '')

    end
  end
end
