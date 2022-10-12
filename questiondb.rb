require 'sqlite3'
require 'singelton'

class QuestionsDB < SQLite3::Database
    include Singleton

    def initialize
        super('plays.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end

class User

    attr_accessor :id, :fname, :lname

    def self.find_by_id(id)
        user = QuestionsDB.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                users
            WHERE
                id = ?
        SQL
        return nil unless user.length > 0

        User.new(user) 
    end

    def self.find_by_name(fname, lname)
        user = QuestionsDB.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM
                users
            WHERE
                fname = ?
                AND
                lname = ?
        SQL
        return nil unless user.length > 0

        User.new(user)    
    end


    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

end

class Question

    attr_accessor :id, :title, :body, :author_id

    def self.find_by_id(id)
        question = QuestionsDB.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?
        SQL
        return nil unless question.length > 0

        Question.new(question) 
    end

    def self.find_by_title(title)
        f_title = QuestionsDB.instance.execute(<<-SQL, title)
            SELECT
                *
            FROM
                questions
            WHERE
                title = ?
        SQL
        return nil unless f_title.length > 0

        Question.new(f_title) 
    end
    
    def self.find_by_author(author_id)
        f_author_id = QuestionsDB.instance.execute(<<-SQL, author_id)
            SELECT
                *
            FROM
                questions
            WHERE
                author_id = ?
        SQL
        return nil unless f_author_id.length > 0

        Question.new(f_author_id) 
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

end

class Question_follows

    attr_accessor :id, :question_id, :user_id

    def self.find_by_id(id)
        follows = QuestionsDB.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_follows
            WHERE
                id = ?
        SQL
        return nil unless follows.length > 0

        Question_follows.new(follows) 
    end

    def self.find_by_q_id(question_id)
        q_id = QuestionsDB.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                question_follows
            WHERE
                question_id = ?
        SQL
        return nil unless q_id.length > 0

        Question_follows.new(q_id) 
    end

    def self.find_by_u_id(user_id)
        u_id = QuestionsDB.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                question_follows
            WHERE
                user_id = ?
        SQL
        return nil unless u_id.length > 0

        Question_follows.new(u_id) 
    end


    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end
end

class Replies

    attr_accessor :id, :question_id :question_reply_id, :user_id, :body
    def self.find_by_id(id)
        replies = QuestionsDB.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                replies
            WHERE
                id = ?
        SQL
        return nil unless replies.length > 0

        Replies.new(replies) 
    end

    def self.find_by_q_id(question_id)
        q_id = QuestionsDB.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                replies
            WHERE
                question_id = ?
        SQL
        return nil unless q_id.length > 0

        Replies.new(q_id) 
    end

    def self.find_by_u_id(user_id)
        u_id = QuestionsDB.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                replies
            WHERE
                user_id = ?
        SQL
        return nil unless u_id.length > 0

        Replies.new(u_id) 
    end

    def self.find_by_q_r_id(question_reply_id)
        q_r_id = QuestionsDB.instance.execute(<<-SQL, question_reply_id)
            SELECT
                *
            FROM
                replies
            WHERE
                user_id = ?
        SQL
        return nil unless q_r_id.length > 0

        Replies.new(q_r_id) 
    end


    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @question_reply_id = options['question_reply_id']
        @user_id = options['user_id']
        @body = options['body']
    end

end

class Question_likes

    attr_accessor :id, :question_id, :user_id

    def self.find_by_id(id)
        likes = QuestionsDB.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_likes
            WHERE
                id = ?
        SQL
        return nil unless likes.length > 0

        Question_likes.new(likes) 
    end

    def self.find_by_q_id(question_id)
        q_id = QuestionsDB.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                question_likes
            WHERE
                question_id = ?
        SQL
        return nil unless q_id.length > 0

        Question_likes.new(q_id) 
    end

    def self.find_by_u_id(user_id)
        u_id = QuestionsDB.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                question_likes
            WHERE
                user_id = ?
        SQL
        return nil unless u_id.length > 0

        Question_likes.new(u_id) 
    end


    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end
    
end
