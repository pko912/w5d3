# frozen_string_literal: true

require_relative 'questions_database'
require_relative 'user'

class Question
  attr_accessor :id, :title, :body, :author_id

  def self.find_by_id(id)
    question = QuestionsDatabase.instance.get_first_row(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
      LIMIT 1
    SQL
    question.nil? ? nil : Question.new(question)
  end

  def self.find_by_author_id(author_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL
    questions.map {|question| Question.new(question) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def author
    User.find_by_id(self.author_id)
  end

  def replies
  end
end

