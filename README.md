# Epitaph

    require 'lib/epitaph'

    p Epitaph(<<-EOC, 'A.new.f(10)')
    require 'rubygems'
    require 'active_support'
    class A
      def f(x)
        x.days.ago
    EOC
    # => 2010-02-01 15:32:47 -0800

## Requirement

* Ripper (Built-in library in Ruby 1.9)

## Author

Tatsuhiro Ujihisa
<http://ujihisa.blogspot.com/>

## Epitaph.vim

This Vim script is experimental.
See the detail here:
<http://ujihisa.blogspot.com/2010/02/what-i-made.html>
