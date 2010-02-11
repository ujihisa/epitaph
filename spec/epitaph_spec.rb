#!/usr/bin/env spec192
$: << File.expand_path(__FILE__) + '/../lib'
require 'epitaph'

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
  end
end
