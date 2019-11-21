class User < ApplicationRecord
    attr_accessor :id, :name, :email

    def marshal_dump
        [@id, @name, @email]
    end
    def marshal_load array
        @id, @name, @email = array
    end
end
