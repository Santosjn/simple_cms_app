class Page < ActiveRecord::Base

  belongs_to :subject

  # --------- validation
  validates_presence_of :name
  validates_length_of :name, :maximum => 255

  validates_presence_of :permalink
  validates_length_of :permalink, :within => 3..255

  validates_uniqueness_of :permalink

  # ----------

  # has_and_belongs_to_many :admin_users
  has_and_belongs_to_many :editors, :class_name => "AdminUser"


  #
  has_many :sections

  scope :sorted, lambda{
    order('ID ASC')
  }

  acts_as_list :scope => :subject

  before_validation :add_default_permalink

  after_save :touch_subject
  after_destroy :delete_related_sections

  private
  def add_default_permalink
    if permalink.blank?
      self.permalink = "#{id}-#{name.parameterize}"
    end    
  end

  def touch_subject
    # touch is similar to:
    # subject.update_attribute(:updated_at, Time.now)
    subject.touch    
  end

  def delete_related_sections
    self.sections.each do |section|
      #section.destroy
    end    
  end


end
