# frozen_string_literal: true

require_relative 'questions_database'
require_relative 'question'

class User
    attr_accessor :id, :fname, :lname

    def self.find_by_id(id)
        user = QuestionsDatabase.instance.get_first_row(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
      LIMIT 1
    SQL
    user.nil? ? nil : User.new(user)
    end

    def self.find_by_name(fname,lname)
        user = QuestionsDatabase.instance.get_first_row(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
      LIMIT 1
    SQL
     user.nil? ? nil : User.new(user)
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def authored_questions
        Question.find_by_author_id(self.id)
    end
end 


# p User.find_by_id(1)
# p User.find_by_name('Jane','Doe')
# user = User.find_by_id(1)
# user.authored_questions