class User < ActiveRecord::Base
  WEAVER_KNITTER = %w(weaver knitter)

  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :opt_in, :group_id,
                  :discipline, :full_name, :graduated, :school, :school_major, :weaver_or_knitter, :website

  belongs_to :group

  validates_presence_of  :full_name, :discipline, :school,
                         if: Proc.new { |u| u.group.present? && u.group.name.downcase == 'clothier' }
  validates_presence_of  :full_name, :discipline, :school, :school_major,
                         if: Proc.new { |u| u.group.present? && u.group.name.downcase == 'textile engineer' }
  validates_presence_of  :full_name, :weaver_or_knitter, :website,
                         if: Proc.new { |u| u.group.present? && u.group.name.downcase == 'weavers and knitters' }
  validates_inclusion_of :graduated, in: [true, false], message: "can't be blank",
                         if: Proc.new { |u| u.group.present? && u.group.name.downcase == 'textile engineer' }
  validates_inclusion_of :weaver_or_knitter, in: WEAVER_KNITTER,
                         if: Proc.new { |u| u.group.present? && u.group.name.downcase == 'weavers and knitters' }

  after_create :add_user_to_mailchimp unless Rails.env.test? or Rails.env.development?
  before_destroy :remove_user_from_mailchimp unless Rails.env.test? or Rails.env.development?

  # override Devise method
  # no password is required when the account is created; validate password when the user sets one
  validates_confirmation_of :password
  def password_required?
    if !persisted? 
      !(password != "")
    else
      !password.nil? || !password_confirmation.nil?
    end
  end
  
  # override Devise method
  def confirmation_required?
    false
  end
  
  # override Devise method
  def active_for_authentication?
    confirmed? || confirmation_period_valid?
  end
  
  # new function to set the password
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end
  
  # new function to determine whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  # new function to provide access to protected method pending_any_confirmation
  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end
    
private

  def add_user_to_mailchimp
    unless self.email.include?('@example.com')
      mailchimp = Hominid::API.new(ENV["MAILCHIMP_API_KEY"])
      list_id = mailchimp.find_list_id_by_name "visitors"
      info = { }
      result = mailchimp.list_subscribe(list_id, self.email, info, 'html', false, true, false, false)
      Rails.logger.info("MAILCHIMP SUBSCRIBE: result #{result.inspect} for #{self.email}")
    end
  end
  
  def remove_user_from_mailchimp
    unless self.email.include?('@example.com')
      mailchimp = Hominid::API.new(ENV["MAILCHIMP_API_KEY"])
      list_id = mailchimp.find_list_id_by_name "visitors"
      result = mailchimp.list_unsubscribe(list_id, self.email, true, true, true)
      Rails.logger.info("MAILCHIMP UNSUBSCRIBE: result #{result.inspect} for #{self.email}")
    end
  end

end
  
