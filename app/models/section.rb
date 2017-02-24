class Section < ActiveRecord::Base
  has_many :section_edits

  # --------- validation
  validates_presence_of :name
  validates_length_of :name, :maximum => 255

  CONTENT_TYPES = ['text', 'HTML']

  validates_inclusion_of :content_type,
    :in => ['text', 'HTML'],
    :message => "must be one of: #{CONTENT_TYPES.join(', ')}"
    validates_presence_of :content



  # ---------

  has_many :editors, :through => :section_edits,
    :class_name => "AdminUser"

  #
  belongs_to :page

  scope :sorted, lambda{
    order('ID ASC')
  }

  acts_as_list :scope => :page

  after_save :touch_page

  private
  def touch_page
    page.touch
  end

end
