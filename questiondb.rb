require 'sqlite3'
require 'singelton'

class QuestionsDB < SQLite3::Database
    include Singleton
    