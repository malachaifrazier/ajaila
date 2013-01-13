# generating miners,selectors,tables and presenters 
command :g do |c|
  c.action do |global_options,options,args|

    check_inputs(args)
    content = ""
    if args[0] == "table"
      columns = additional_params(args)
      collection = args[1].capitalize
      key_pairs = parse_columns(columns)
      content = render("table", :collection => collection, :keys => key_pairs)
    end

    if args[0] == "selector"
      content = render("selector")
      io = additional_params(args)
      file = get_file(io)
      file_name = get_file(io).split(".").first.upcase
      table = get_table(io)
      all_columns = get_columns(table)
      clast = all_columns.pop
      cleft = all_columns
      content += "\n" + render( "_parser", :columns => cleft, :last => clast, :collection => table.capitalize, :file => file, :file_name => file_name )
    end

    if args[0] == "miner"
      begin
         using = false
         k, tables  = 0, []
         args.each do |arg|
           k += 1
           using = true if arg == "using" and k == 3
           next if k <= 3
           additions = arg.split(':')
           addition_type = additions[0].downcase
           addition_core = additions[1].downcase
           tables << addition_core if addition_type == "table"
         end
         content = ""
         lines = []
         table_data = {}
         if tables != []
           lines << "require \"mongo_mapper\"\n"
           tables.each do |table|
             lines << "require \"./sandbox/tables/#{table}.table\"\n"
             File.open("sandbox/tables/#{table}.table.rb", "r") do |infile|
               while (line = infile.gets)
                 clas = line[/class\s(\S+)/,1] if clas == nil
                 key = line[/key\s:(\S+),/,1]
                 table_data[clas] = [] if clas != nil and table_data[clas] == nil
                 table_data[clas] << key if key != nil
               end
             end
           end

           table_data.each_key do |table|
             lines << "  #{table}.create("
             table_data[table].each do |key|
               lines << "#{key}: #{key}, " if key != table_data[table].last
               lines << "#{key}: #{key}" if key == table_data[table].last
             end
             lines << ")\n"
           end
         end

        if using == true
         puts "Ajaila: No selector title or table was selected \n( add: using file:SomeFile.csv table:SomeTable )".color(Colors::YELLOW) if files == [] or tables == [] 
         raise TypeError if tables == [] 
        end
         content = lines.join
       rescue
        raise TypeError, 'Ajaila: wrong command...'.color(Colors::RED)
      end
    end
    
    if args[0] == "presenter"
      begin
         ext = "erb"
         using = false
         k, tables  = 0, []
         args.each do |arg|
           k += 1
           using = true if arg == "using" and k == 3
           next if k <= 3
           additions = arg.split(':')
           addition_type = additions[0].downcase
           addition_core = additions[1].downcase
           tables << addition_core if addition_type == "table"
         end
         content = ""
         lines = []
         table_data = {}
         if tables != []
           tables.each do |table|
             File.open("sandbox/tables/#{table}.table.rb", "r") do |infile|
               while (line = infile.gets)
                 clas = line[/class\s(\S+)/,1] if clas == nil
                 key = line[/key\s:(\S+),/,1]
                 table_data[clas] = [] if clas != nil and table_data[clas] == nil
                 table_data[clas] << key if key != nil
               end
             end
           end

           table_data.each_key do |table|
             lines << "<% #{table}.all.each do |d| %>\n"
             table_data[table].each do |key|
               lines << "  <div><b>#{key}</b>: <%= d.#{key} %></div>\n"
             end
             lines << "  <br>\n"
             lines << "<% end %>"
           end
         end

         route = []
         route << "\n"
         route << "get \"/#{args[1].downcase}\" do\n"
         route << "  erb \"#{args[1].downcase}.presenter\".to_sym\n"
         route << "end\n"
         File.open("service.rb", "a") do |file|
           file.puts route
         end

        if using == true
         puts "Ajaila: No presenter title or table was selected \n( add: using file:SomeFile.csv table:SomeTable )".color(Colors::YELLOW) if files == [] or tables == [] 
         raise TypeError if tables == [] 
        end
         content = lines.join
       rescue
        raise TypeError, 'Ajaila: wrong command...'.color(Colors::RED)
      end
    end

    if args[0] == "api"
      begin
         using = false
         k, tables  = 0, []
         route = []
         args.each do |arg|
           k += 1
           using = true if arg == "using" and k == 3
           next if k <= 3
           additions = arg.split(':')
           addition_type = additions[0].downcase
           addition_core = additions[1].downcase
           tables << addition_core if addition_type == "table"
         end
         content = ""
         lines = []
         table_data = {}
         if tables != []
           tables.each do |table|
             File.open("sandbox/tables/#{table}.table.rb", "r") do |infile|
               while (line = infile.gets)
                 clas = line[/class\s(\S+)/,1] if clas == nil
                 key = line[/key\s:(\S+),/,1]
                 table_data[clas] = [] if clas != nil and table_data[clas] == nil
                 table_data[clas] << key if key != nil
               end
             end
           end
           table_data.each_key do |table|
             table_data[table].each do |key|
               route << "\nget '/api/#{args[1].downcase}/#{key}/:key' do\n"
               route << "  data = #{table}.where(:#{key} => params[:key] )\n"
               route << "  if data\n"
               route << "    data.to_json\n"
               route << "   else\n"
               route << "     error 404, {:error => \"item not found\"}.to_json\n"
               route << "  end\n"
               route << "end\n"
             end
           end
         end
         route.join
         File.open("service.rb", "a") do |file|
           file.puts route
         end

        if using == true
         puts "Ajaila: No api title or table was selected \n".color(Colors::YELLOW) if tables == [] 
         raise TypeError if tables == [] 
        end
         content = lines.join
       rescue
        raise TypeError, 'Ajaila: wrong command...'.color(Colors::RED)
      end
    end
    # puts info("Generating #{args[0]} \"#{args[1]}\"")
    dir = target_dir(args)
    File.open(ROOT + "/#{dir}#{args[1].downcase}.#{args[0]}.rb", 'w') {|f| f.write(content) } if args[0] != "api"
    puts success("Generated #{args[0]} #{args[1]} successfully!")    
  end
end