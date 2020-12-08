# -*- coding: utf-8 -*-
# usage: ruby checkModel.rb [file]
# -------------------
# Author::    Jean-Michel Bruel  (mailto:jbruel@gmail.com) improved by JMI
# Copyright:: Copyright (c) 2014--2020 JMB
# License::   Distributes under the same terms as Ruby
# -------------------

require "minitest/autorun"
MODEL_NAME = ARGV[0] ? ARGV[0] : "TP1.plantuml"

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
MiniTest::Unit.after_tests { p @_assertions }

class TestGeneratedModel < MiniTest::Unit::TestCase
  
  #------------ General tests about plantUML
  
  def test_generated_model_exists
    assert_equal(true, File.exists?(MODEL_NAME))
  end

  def test_generated_model_is_plantuml
    assert_equal(true, File.readlines(MODEL_NAME).grep(/@startuml/).any?)
    assert_equal(true, File.readlines(MODEL_NAME).grep(/@enduml/).any?)
  end

  #------------ Specific tests about expected content
  
  def test_class_Personnage_is_abstract
    assert_equal(true, File.readlines(MODEL_NAME).grep(/abstract class Personnage\s*/).any?)
  end

  def test_class_Personnage_has_ComportementArme
    assert_contains(/Personnage\s+[o|"<>"|-]-+> "[\d|.]" ComportementArme/, File.readlines(MODEL_NAME).join)
  end

  def test_ComportementArme_is_an_Interface
    assert_equal(true, File.readlines(MODEL_NAME).grep(/interface\s+ComportementArme/).any?)
  end

  def test_ComportementArme_Interface_has_concrete_implementation
    assert_equal(true, File.readlines(MODEL_NAME).grep(/ComportementArme\s+<\|\.\./).any?)
  end

end
