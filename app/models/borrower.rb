class Borrower < ActiveRecord::Base
  has_many :historys
  has_many :lenders_history, through: :historys, source: :lender

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  PASSWORD_REGEX = /(?=.*[a-zA-Z])(?=.*[0-9]).{8,}/

  before_create validates :first, :last, presence: true
  before_create validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  has_secure_password
  before_create validates :password, allow_blank: true, format: { with: PASSWORD_REGEX }
  before_create validates :purpose, :description, presence: true

  before_validation :firstcapitalize, :lastcapitalize, :emaillower

  private
    def firstcapitalize
      self.first = first.downcase.titleize
    end
    def lastcapitalize
      self.last = last.downcase.titleize
    end
    def emaillower
      self.email = email.downcase
    end
end
