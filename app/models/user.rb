class User < ApplicationRecord
  scope :school_registed, -> {
     select(:school_id).map(&:school_id).uniq.count
  }  
  scope :user_registed, -> {
     where.not(school_id: nil).where(role: "user").count
  }  
  
  attr_accessor :login
  
  validates :username,length: {minimum: 5}, uniqueness: true
  #digest_password
  #has_secure_password
  validates :school_id, presence: true
  validates :prefix, presence: true
  validates :name, presence: true
  validates :surname, presence: true
  validates :cardnumber, presence: true, length: {minimum: 13, maximum: 13}, format: { with: /\A[+-]?\d+?(_?\d+)*(\.\d+e?\d*)?\Z/, message: "accept Number only." }
  validates :position, presence: true
  validates :phone, presence: true , format: { with: /\A[+-]?\d+?(_?\d+)*(\.\d+e?\d*)?\Z/, message: "accept Number only." }
  validates :email, presence: true, uniqueness: true
  
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  belongs_to :school
  has_many :loghistories  
  has_many :tloghistories 
  has_many :formmanages 
  
  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
  end
  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end
end
