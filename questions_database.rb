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

    User.new(user.first)
  end
end

class Question
  attr_accessor :id, :title, :body
  
  def self.find_by_id(id)
    question =  QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL
  end

  Question.new(question.first)
end

class QuestionFollow
  attr_accessor :id, :question_id, :que

  def self.find_by_id(id)
    question_follow = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT 
        *
      FROM
         question_follows
      WHERE
        id = ?
    SQL

    QuestionFollow.new(question_follow.first)
  end
end

class Reply
  attr_accessor :id, :subject_q, :parent_reply, :body

  def self.find_by_id(id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL

    Reply.new(reply.first)
  end
end

class QuestionLike
  attr_accessor: :id, :subject_q

  def self.find_by_id(id)
    question_like = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT 
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL

    QuestionLike.new(question_like.first)
  end
end