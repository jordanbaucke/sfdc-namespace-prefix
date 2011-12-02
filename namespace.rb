#
# namespace.rb 
# Namingspacing for SFDC
#	
# invoke this file from the root of an /src 
# directory of a SFDC meta-data project
require 'find'

VERBOS = true	#if you want to step through the processes the program is undertaking	
CUSTOM_OBJECT_NAMES = true	#if naming conventions file contains custom objects that need to be renamed

class NamingConsideration <
  # a Person has a first name, last name, and city
  Struct.new(:unpackaged_name, :packaged_name, :file_type)
end

# parse in the special naming considerations file 
# this file contains naming consideration for one off cases
# that need to be updated between a developing org and a 
# package org (where certain meta-data cannot be removed)
namingConsiderations = Array.new

File.open('namingConsiderations.txt').each_line{ |line|
	puts(line)
	fields = line.split(':')
	ns = NamingConsideration.new
	ns.unpackaged_name = fields[0]
	ns.packaged_name = fields[1]
	ns.file_type = fields[2]
	namingConsiderations.push(ns)
}

#
#	rename_class_definitions 
#
# Search the file for the class definitions (public,private)
# constructors
#
def rename_class_definitions(file,namechanges)
	file = File.open(file)
    	lines = file.readlines
	file.close

    	changes = false
    	lines.each do |line|
		puts(line)
		changes = true if line.gsub!(/#{'class '+namechanges.unpackaged_name}/, 'class '+namechanges.packaged_name)
    		
		changes = true if line.gsub!(/#{}/,'')
	end

    	# Don't write the file if there are no changes
    	if changes
      		file = File.new([namechanges.packaged_name,'.',namechanges.file_type.chomp].join('').squeeze(' '),'w')
      		lines.each do |line|
       		file.write(line)
      	end
      	file.close
    end
end

#
#	check_src_file_name	
#
# If the current code has special naming considerations (classnames,objectnames,etc),
# this method will invoke those changes to the file on a case by case basis
# 
# The file namingConsiderations.txt will be parsed into an array with the structure:
# array: namingConsiderations[developmentOrgName][packagingOrgName][filetype]
#
def check_src_file_name(filename,namingConsiderations)
	#check the naming considerations array to see if we need to do anything to this file
	namingConsiderations.each{ |namechange|
		namedfile = [namechange.unpackaged_name,'.',namechange.file_type.chomp].join('').squeeze(' ')
		if namedfile == filename
			#VERBOS
			if VERBOS
				puts('')
				puts('Found: '+filename+' which your naming conventions recommends you change to: '+
				namechange.packaged_name+'.'+namechange.file_type)
				puts('Rename?');
				input = gets
				rename_class_definitions(filename,namechange)	
			else
				rename_class_definitions(namechange)
			end
		end
	}	
end		
		

puts('');
puts('/****************************************************/');
puts('	Running Namespacing for SFDC Developer Orgs	');
puts('/****************************************************/');
puts('');

#enter current working directory for SFDC Apex SRC
srcFolderPath = Dir.getwd()
puts('Current source path: '+Dir.getwd())
puts('Current SRC Dir Content: ')
srcFolders = Dir.glob("**/");

srcFolders.each{|srcFolder|
	puts(srcFolder)
}


srcFolders.each{|srcFolder|
	Dir.chdir(srcFolderPath)
	puts('Now entering: '+srcFolder)
	Dir.chdir(srcFolder);
	srcFiles = Dir.glob('*.{cls,page,object}') #get all source files in that directory
	srcFiles.each{ |srcFile|
		check_src_file_name(srcFile,namingConsiderations)
	}
}
