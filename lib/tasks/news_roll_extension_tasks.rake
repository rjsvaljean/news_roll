namespace :radiant do
  namespace :extensions do
    namespace :news_roll do
      
      desc "Runs the migration of the News Roll extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          NewsRollExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          NewsRollExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the News Roll to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from NewsRollExtension"
        Dir[NewsRollExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(NewsRollExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
