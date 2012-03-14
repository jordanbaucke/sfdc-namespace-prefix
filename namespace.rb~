#
# namespace.rb 
# Namingspacing for SFDC
#	
# invoke this file from the root of an /src 
# directory of a SFDC meta-data project

# parse in the special naming considerations file 
# this file contains naming consideration for one off cases
# that need to be updated between a developing org and a 
# package org (where certain meta-data cannot be removed)
File.open('namingConsiderations.txt').each{ |line|
	puts(line)
}

puts('/****************************************************/');
puts('	Running Namespacing for SFDC Developer Orgs	');
puts('/****************************************************/');

#enter current working directory for SFDC Apex SRC
srcFolderPath = Dir.getwd()
puts('Current source path: '+Dir.getwd())
puts('Current SRC Dir Content: ')
srcFolders = Dir.glob("**/");

srcFolders.each do |srcFolder|
	puts(srcFolder)
end


srcFolders.each do |srcFolder|
	Dir.chdir(srcFolderPath)
	puts('Now entering: '+srcFolder)
	Dir.chdir(srcFolder);
	srcFiles = Dir.glob('*.{cls,page,object}') #get all source files in that directory
	srcFiles.each do |srcFile|
		puts(srcFile);
		
	end
end

#
# If the current code has special naming considerations (classnames,objectnames,etc),
# this method will invoke those changes to the file on a case by case basis
# 
# The file namingConsiderations.txt will be parsed into an array with the structure:
# array: namingConsiderations[developmentOrgName][packagingOrgName]
#
def checkSrcFileName(filename)
	#todo	
end
	
