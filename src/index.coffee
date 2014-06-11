
fs = require('fs')
glob = require('glob')

class AFC

  # supports ext
  PRIORITYS = ['coffee', 'js', 'json']
  FILES = [
    'afc',
    'config',
    'config/index',
    "config/#{process.env.NODE_ENV or 'development'}",
    "config/enviroments/#{process.env.NODE_ENV or 'development'}"
  ]
  DIRS = ['/etc', process.env.PWD, "#{process.env.PWD}/lib"]

  cache: {}

  set: (key, value) ->
    if arguments.length is 1
      return @[key]

    @[key] = value
    return @

  get: @::set

  @::__defineGetter__ 'config', ->

    return @cache.config if @cache.config

    configs = []

    dirs = @dirs or DIRS

    for dir in dirs
      for filename in FILES
        for ext in PRIORITYS
          path = glob("#{filename}.#{ext}", {mark: true, cwd: dir, sync: true})
          configs.push "#{dir}/#{path[0]}" if path.length and "#{dir}/#{path[0]}" not in configs

    config = require(configs[0] or {})
    @cache.config = config
    config

afc = new AFC
afc.AFC = AFC
module.exports = afc