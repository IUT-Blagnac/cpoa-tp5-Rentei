# -*- coding: utf-8 -*-
# usage: ruby checkfix#.rb [file]
# -------------------
# Author::    Jean-Michel Bruel  (mailto:jbruel@gmail.com) 
# Copyright:: Copyright (c) 2020 JMB
# License::   Distributes under the same terms as Ruby
# -------------------

README = ARGV[0] ? ARGV[0] : "../README.adoc"

fixNb = __FILE__.scan(/\d+/)
File.open(README, :encoding => 'utf-8') { |f|
  result = true

  content = f.read
  lastName = content.scan(/\{lastName\}:: (\w+)/) 
  firstName = content.scan(/\{firstName\}:: ([\w|\-]+)/)
  groupNb = content.scan(/\- \[[x|X]\] ([\w|\{|\}]+)/)

  print "----------------------------------\n"
  print "Looking for fix #" + fixNb[0] + " rules...\n"

  # Checking Name
  if (lastName[0][0] == "BRUEL") && (firstName[0][0] == "Jean-Michel")
    result = false
  else
    print "SUCCESS: Last Name = " + lastName[0][0] + "\n"
    print "SUCCESS: First Name = " + firstName[0][0] + "\n"
  end

  # Checking Group
  if groupNb[0][0] != "{Enseignants}"
    print "SUCCESS: Group = " + groupNb[0][0] + "\n"
  else
    result = false
  end

  if !result 
    print "/!\\FAILURE: Your info need to be updated in " +  README  + "\n"
    exit 1
  end
  exit 0
}
