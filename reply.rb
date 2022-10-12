# frozen_string_literal: true

require_relative 'questions_database'

class Reply
    attr_accessor :id, :body, :question_id, :parent_id, :user_id

    def self.find_by_id(id)
        reply = QuestionsDatabase.instance.get_first_row(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
      LIMIT 1
    SQL
    reply.nil? ? nil : Reply.new(reply)
    end

def self.find_by_user_id(user_id)
        reply = QuestionsDatabase.instance.get_first_row(<<-SQL, user_id)
    SELECT
        *
    FROM
        replies
    WHERE
        user_id = ?
    LIMIT 1
    SQL
    reply.nil? ? nil : Reply.new(reply)
    end


    def initialize(options)
        @id = options['id']
        @body = options['body']
        @question_id = options['question_id']
        @parent_id = options['parent_id']
        @user_id = options['user_id']
    end
end


# p Reply.find_by_user_id(1)