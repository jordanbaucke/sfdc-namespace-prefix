custom_object_def_files = ['custom_objects_files.txt']

custom_objects_fields = Array.new
target_namespace = ''
src_folder_path = ''


target_namespace = 'NS__'

custom_object_def_files.each{ |file|
  #push all custom object names
  File.open(file).each_line{ |line|
    custom_objects_fields.push(line.chomp)
    puts(line)
  }
}

#read in all the src files
Dir.chdir(src_folder_path)
puts('Current source path: '+Dir.getwd())
puts('Current SRC Dir Content: ')
src_folders = Dir.glob("**/");

#go file by file
src_folders.each{|folder|
  Dir.chdir(src_folder_path)
  puts('Now entering: '+folder)
  Dir.chdir(folder);
  #get all source files in that directory
  src_files = Dir.glob('*.{cls,page,object}')
  src_files.each{ |src_file|
    puts('Now reading: '+src_file)
    # fullpath = Dir.getwd+'/'+src_file
    #search the file and replace
    #file = File.open(fullpath)
    text = File.read(src_file)
    custom_objects_fields.each{ |customObjectFieldName|
        text.gsub!(customObjectFieldName,target_namespace+customObjectFieldName)
    }
    
    quick_fix = ['NS__NS__','NS__']
    text.gsub!(quick_fix[0],quick_fix[1])

    quick_fix = ['NS__ObjectNameNS__Status__c','NS__ObjectName__c']
    text.gsub!(quick_fix[0],quick_fix[1])

    #write the updated text
    File.open(src_file,'w'){ |file|
        file.puts text\
    } if text != nil

  }
}