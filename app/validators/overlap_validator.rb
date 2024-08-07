class OverlapValidator < ActiveModel::Validator
  def validate(record)
    return unless record.start_at && record.end_at

    minutes = ((record.end_at - record.start_at) / 1.minutes ).to_i
    return if minutes == 50 || minutes == 80

    record.errors.add(:base, 'class duration is invalid (should be 50 or 80 minutes)')
  end
end
