class Section < ApplicationRecord

  DOW_FIELDS = %i[dow_mon dow_tue dow_wed dow_thu dow_fri].freeze

  belongs_to :schedule
  belongs_to :teacher_subject

  # `stard_date` and `end_date` can be used to set the limits to
  # repeating classes within, say, semester or any other time period
  validates :schedule_id, :teacher_subject_id, :start_date, :end_date, :start_at, :end_at, presence: true
  validates_with StartEndAtValidator
  validates_with DurationValidator
  validates_with OverlapValidator
  validates_with DowValidator
end
