# -*- coding: utf-8 -*-
# usage: ruby checkModel.rb [file]
# -------------------
# Author::    Jean-Michel Bruel  (mailto:jbruel@gmail.com) improved by JMI
# Copyright:: Copyright (c) 2014--2020 JMB
# License::   Distributes under the same terms as Ruby
# -------------------

require "minitest/autorun"

MODEL_NAME = ARGV[0] ? ARGV[0] : "TP3.plantuml"

module MiniTest
  class Unit
    class TestCase
      #Define new assertion
      def assert_contains(string_to_test, substring_to_verify)
        assert_match( string_to_test, substring_to_verify)
      end
      def assert_not_contains(string_to_test, substring_to_verify)
        assert_not_match( string_to_test, substring_to_verify)
      end
    end
  end
end
Minitest.after_run { p @_assertions }

class TestGeneratedModel < Minitest::Test
  
  #------------ General tests about plantUML
  
  def test_generated_model_exists
    assert_equal(true, File.exists?(MODEL_NAME))
  end

  def test_generated_model_is_plantuml
    assert_equal(true, File.readlines(MODEL_NAME).grep(/@startuml/).any?)
    assert_equal(true, File.readlines(MODEL_NAME).grep(/@enduml/).any?)
  end

  #------------ Specific tests about expected content
  
  def test_class_Pizza_is_abstract
    assert_equal(true, File.readlines(MODEL_NAME).grep(/abstract class Pizza\s*/).any?)
  end

  def test_class_Pizzeria_is_abstract
    assert_equal(true, File.readlines(MODEL_NAME).grep(/abstract class Pizzeria\s*/).any?)
  end

  def test_class_Pizzeria_has_Factory
    assert_equal(true, File.readlines(MODEL_NAME).grep(/Pizzeria\s+[o|"<>"|-]-+> .*Factory.*/).any?)
  end

  def test_Pizzeria_has_concrete_implementation
    assert_equal(true, File.readlines(MODEL_NAME).grep(/Pizzeria\s+<\|\-\-/).any?)
  end

  def test_Pizza_has_concrete_implementation
    assert_equal(true, File.readlines(MODEL_NAME).grep(/Pizza\s+<\|\-\-/).any?)
  end

end
