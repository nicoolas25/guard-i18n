require 'guard'
require 'guard/guard'
require 'json'
require 'yaml'

module Guard
  class I18n < Guard

    TARGET_DIR = Pathname.pwd.join('app', 'assets', 'javascripts', 'i18n')

    COFFEE_TPL = <<-EOS
locale = {}
locale.h = `%s`
locale.t = (name) ->
  h_result = this.h
  for n in name.split(".")
    if n of h_result
      h_result = h_result[n]
    else
      return "missing i18n : " + name
  return h_result
root = exports ? this
root.locale = locale
      EOS

    def run_on_change(paths)
      Dir::mkdir(TARGET_DIR) unless File.directory?(TARGET_DIR)

      locales = Rails.root.join('config', 'locales', '**', '*.yml')
      paths.each do |locale_path|
        filename = File.basename(locale_path, ".yml")
        input = File.new(locale_path, 'r')
        locale = YAML.load(input.read)
        input.close

        name = locale.keys[0]
        content = locale[name]
        next unless content.key?("javascript")
        File.open(TARGET_DIR + "#{filename}.js.coffee", "w") do |f|
          f.puts COFFEE_TPL % content["javascript"].to_json
        end
      end
    end
  end
end
