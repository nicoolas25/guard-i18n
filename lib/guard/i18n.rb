require 'guard'
require 'guard/guard'
require 'json'
require 'yaml'

module Guard
  class I18n < Guard

   def run_on_change(paths)
      target = Pathname.pwd.join('app', 'assets', 'javascripts', 'i18n')
      Dir::mkdir(target) unless File.directory?(target)

      paths.each do |locale_path|
        filename = File.basename(locale_path, ".yml")
        input = File.new(locale_path, 'r')
        locale = YAML.load(input.read)
        input.close

        name = locale.keys[0]
        content = locale[name]
        next unless content.key?("javascript")
        File.open(target + "#{filename}.js", "w") do |f|
          f.puts "var locale = {}; locale.t = #{content["javascript"].to_json};"
        end
      end
   end

  end
end
