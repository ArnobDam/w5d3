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

    attr_accessor :id, :fname, :lname
    
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

    attr_accessor :id, :title, :body, :author_id

    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?
            SQL
        Question.new(question[0])
    end

    def initialize(hash)
        @id = hash['id']
        @title = hash['title']
        @body = hash['body']
        @author_id = hash['author_id']
    end

end

class QuestionFollow

    attr_accessor :id, :user_id, :question_id

    def self.find_by_id(id)
        question_follow = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_follows
            WHERE
                id = ?
            SQL
        QuestionFollow.new(question_follow[0])
    end

    def initialize(hash)
        @id = hash['id']
        @user_id = hash['user_id']
        @question_id = hash['question_id']
    end
end

class Reply

    attr_accessor :id, :body, :user_id, :question_id, :parent_reply_id

    def self.find_by_id(id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                replies
            WHERE
                id = ?
            SQL
        Reply.new(reply[0])
    end

    def initialize(hash)
        @id = hash['id']
        @body = hash['body']
        @user_id = hash['user_id']
        @question_id = hash['question_id']
        @parent_reply_id = hash['parent_reply_id']
    end
end

class QuestionLike

    attr_accessor :id, :user_id, :question_id

    def self.find_by_id(id)
        question_like = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_likes
            WHERE
                id = ?
            SQL
        QuestionLike.new(question_like[0])
    end

    def initialize(hash)
        @id = hash['id']
        @user_id = hash['user_id']
        @question_id = hash['question_id']
    end
end