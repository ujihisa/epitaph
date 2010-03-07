#!/usr/bin/env spec192
$: << File.dirname(File.expand_path(__FILE__)) + '/../lib'
require 'epitaph'
require 'tempfile'

describe 'Epitaph()' do
  it 'runs a definitive code' do
    Epitaph(<<-EOC, 'A.new.f(10)').should == 100
    class A # How are you?
      def f(x)
        x ** 2
      end
    end
    EOC
  end

  it 'runs an uncompleted code' do
    Epitaph(<<-EOC, 'A.new.f(10)').should == 100
    class A # How are you?
      def f(x)
        x ** 2
    EOC

    Epitaph(<<-EOC, 'A.new.f(10)').should == 'uj'
    class A # How are you?
      def f(x)
        'uj
    EOC
  end
end

describe 'Epitaph#locals' do
  it 'lists the names of local variables on the given line' do
    Epitaph.new(<<-EOC).locals(4).sort.should == [:a, :x]
    class A # How are you?
      def f(x)
        a = 3

    EOC
  end
end

describe 'command `epitaph`' do
  it '' do
    a = Tempfile.new('a').path
    pwd = File.dirname(File.expand_path(__FILE__)) + '/../'
    system "#{pwd}bin/epitaph #{pwd}spec/sample.txt > #{a}"
    File.read(a).should == "12\n"
  end
end
