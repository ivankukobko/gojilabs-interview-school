class DurationValidator < ActiveModel::Validator
  attr_reader :record

  def validate(record)
    @record = record
    record.schedule.sections
                  .where('start_date >= :start_date AND end_date <= :end_date',
                          start_date: record.start_date, end_date: record.end_date)
                  .where('start_at <= :end_at AND end_at >= :start_at',
                        start_at: record.start_at, end_at: record.start_at)
                  .each do |section|
                    next if section.id == record.id # skip current record if validating on update

                     _validate_proc(section)
                  end
  end

  private

  def _validate_proc(section)
    Section::DOW_FIELDS.each do |dow|
      if record[dow] && section[dow]
        record.errors.add(:base, "overlaps with #{section.teacher_subject.subject.name} " \
                                 " (#{I18n.t(dow, scope: 'activerecord.attributes.section')} @"\
                                 " #{I18n.l(section.start_at, format: :hours)}-#{I18n.l(section.end_at, format: :hours)})")
      end
    end
  end
end
