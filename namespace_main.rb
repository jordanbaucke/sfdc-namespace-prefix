class NamingConsideration <
  Struct.new(:unpackaged_name, :packaged_name)
end

class IgnoreConsiderations <
  Struct.new(:file_name)
end

src_folder_path = ARGV[0]

#lines that need to be changed
naming_considerations = Array.new
File.open(ARGV[1]).each_line{ |line|
	puts(line)
	fields = line.split(':')
	ns = NamingConsideration.new
	ns.unpackaged_name = fields[0]
	ns.packaged_name = fields[1].chomp #end of line
	naming_considerations.push(ns)
}

#files that need to be renamed
file_naming_considerations = Array.new
File.open(ARGV[2]).each_line{ |line|
	puts(line)
	fields = line.split(':')
	ns = NamingConsideration.new
	ns.unpackaged_name = fields[0]
	ns.packaged_name = fields[1].chomp #end of line
	file_naming_considerations.push(ns)
}

#files that should be IGNORED (running find replace on .resource zip files 
# running the operation on compressed zip, .resource binary (blob?) files seems to
# corrupt them, so ignore all .resource files that are compressed zips
ignore_considerations = Array.new
File.open(ARGV[3]).each_line{ |line|
	puts(line)
	ic = IgnoreConsideration.new
	ic.file_name = line
	ignore_considerations.push(ic)
}

#read in all the src files
Dir.chdir(src_folder_path)
puts('Current source path: '+Dir.getwd())
puts('Current SRC Dir Content: ')
src_folders = Dir.glob("**/");

#go file by file
src_folders.each{|folder|
  changed = false
  Dir.chdir(src_folder_path)
  puts('Now entering: '+folder)
  Dir.chdir(folder);
  #get all source files in that directory
  src_files = Dir.glob('*.{cls,page,object,tab,app,layout,resource}')
  src_files.each{ |src_file|
    puts('Now reading: '+src_file)
	ignored = false
	
	#check if file should be ignored
	ignore_considerations.each{|ignored_file|
		ignored = true if src_file == ignored_file.file_name
	}
	
	if ignored
		puts 'Ignored! '+src_file
	end
	
	if !ignored
		text = File.read(src_file)

		#loop over the naming considerations and apply it to each text file
		naming_considerations.each{|namechange|
		  changed = true if text.gsub!(namechange.unpackaged_name,namechange.packaged_name)
		}

		#write the updated text
		File.open(src_file,'w'){ |file|
			  file.puts text\
		} if text != nil if changed


		#loop over the file naming considerations attempt to rename
		file_naming_considerations.each{|namechange|
		  File.rename(namechange.unpackaged_name,namechange.packaged_name) if src_file == namechange.unpackaged_name
		}
	end
  }
}