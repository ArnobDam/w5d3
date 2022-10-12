require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton

    def initialize 
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end

end

class User
    def self.find_by_id(id)
        user = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                users
            WHERE
                id = ?
            SQL
        User.new(user[0])
    end

    def self.find_by_fname(fname)
        user = QuestionsDatabase.instance.execute(<<-SQL, fname)
            SELECT
                *
            FROM
                users
            WHERE
                fname = ?
            SQL
        User.new(user[0])
    end

    def self.find_by_lname(lname)
        user = QuestionsDatabase.instance.execute(<<-SQL, lname)
            SELECT
                *
            FROM
                users
            WHERE
                lname = ?
            SQL
        User.new(user[0])
    end

    def initialize(hash)
        @id = hash['id']
        @fname = hash['fname']
        @lname = hash['lname']
    end
end

class Question


end

class QuestionFollow
end

class Reply
end

class QuestionLike
end