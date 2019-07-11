require 'bundler'
Bundler.require
require 'require_all'
require_all './app'
require 'rainbow/refinement'
require 'timeout'

ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/library.db')

ActiveRecord::Base.logger = nil
