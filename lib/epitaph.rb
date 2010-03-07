#!/usr/bin/env ruby192
require 'ripper'

def Epitaph(world, you)
  Epitaph.new(world).value(you)
end

class Epitaph
  def initialize(world)
    tuples = Ripper.lex(world).map {|i| i[1..2] }
    stack = []
    tuples.each do |k, v|
      case k
      when :on_kw
        case v
        when "class"
          stack.push ';end'
        when "def"
          stack.push ';end'
        when "end"
          abort "not match" unless stack.pop == ';end'
        end
      when :on_lparen
        stack.push ')'
      when :on_rparen
        abort "not match" unless stack.pop == ')'
      when :on_tstring_beg
        stack.push v
      when :on_tstring_end
        stack.pop
      end
    end
    terminator = stack.reverse.join
    @definitive_world = world.chomp + terminator
  end

  def value(you)
    eval @definitive_world + ';' + you
  end

  def locals(linenum)
    $__epitaph_tmp = nil
    a = @definitive_world.each_line.to_a
    tmp = a[0...(linenum-1)].join +
      '$__epitaph_tmp = local_variables' +
      a[(linenum-1)..-1].join
    eval tmp
    A.new.f(10) # FIXME
    $__epitaph_tmp
  end
end

if $0 == __FILE__
  Epitaph(<<-EOC, 'p A.new.f(10)')
  class A # How are you?
    def f(x)
      x ** 2
  EOC

  p Epitaph(<<-EOC, 'A.new.f(10)')
  require 'rubygems'
  require 'active_support'
  class A
    def f(x)
      x.days.ago
  EOC
end
