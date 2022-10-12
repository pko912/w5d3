require_relative 'question'
require_relative 'user'
require_relative 'reply'
require_relative 'questions_database'

p Question.find_by_author_id(1)
q = Question.find_by_id(1)
q.author