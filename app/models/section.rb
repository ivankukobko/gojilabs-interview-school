class Section < ApplicationRecord

  belongs_to :schedule
  belongs_to :teacher_subject

  # `stard_date` and `end_date` can be used to set the limits to
  # repeating classes within, say, semester or any other time period
  validates :schedule_id, :teacher_subject_id, :start_date, :end_date, :start_at, :end_at, presence: true
  validate :_class_start_end, :_class_duration, :_cant_overlap, :_at_least_1_day_per_week, on: [:create, :update]

  private

  def _class_start_end
    return unless start_at && end_at && start_date && end_date
    errors.add(:start_at, 'should start after 7:29') if Time.parse(start_at.strftime('%H:%M')) < Time.parse('7:30')
    errors.add(:start_at, 'should start before 21:40') if Time.parse(start_at.strftime('%H:%M')) > Time.parse('21:40')
    errors.add(:end_at, 'should end before 22:30') if Time.parse(end_at.strftime('%H:%M')) > Time.parse('22:30')
    errors.add(:end_at, 'should end after 8:20') if Time.parse(end_at.strftime('%H:%M')) < Time.parse('8:20')
  end

  def _class_duration
    return unless start_at && end_at

    minutes = ((end_at - start_at) / 1.minutes ).to_i
    return if minutes == 50 || minutes == 80

    errors.add(:base, 'class duration is invalid (should be 50 or 80 minutes)')
  end

  def _cant_overlap
    schedule.sections
            .where('start_date >= :start_date AND end_date <= :end_date', start_date:, end_date:)
            .where('start_at <= :end_at AND end_at >= :start_at', start_at:, end_at:)
            .each do |section|
              next if section.id == id # skip current record if validating on update

              %i[dow_mon dow_tue dow_wed dow_thu dow_fri].each do |dow|
                if self[dow] && section[dow]
                  errors.add(:base, "overlaps with #{section.teacher_subject.subject.name} " \
                                    " (#{dow} @ #{section.start_at}-#{section.end_at})")
                end
              end
            end
  end

  def _at_least_1_day_per_week
    unless %i[dow_mon dow_tue dow_wed dow_thu dow_fri].any? { |dow| self[dow] }
      errors.add(:base, "should be at least 1 day per week")
    end
  end
end
